import 'package:dartpilot/game_data.dart';
import 'package:dartpilot/zwischenBild.dart';
import 'package:flutter/material.dart';
import 'package:dartpilot/end.dart';
import 'package:flutter/cupertino.dart';
import 'game_point_selector.dart';

class GameData with ChangeNotifier {
  static final GameData _instance = GameData._internal();

  factory GameData() {
    return _instance;
  }

  void nextPlayer(BuildContext context) {
    // Hat der aktive Spieler 0 Punkte erreicht?
    calculateScores();

    if (activeScoresByPlayers[activePlayer] == 0) {
      // Der Aktive Spieler hat 0 Punkte erreicht und so das Leg gewonnen
      print("Leg gewonnen!");
      // War das das letzte Leg im Set?
      if(activeLeg == NUMBER_OF_LEGS-1){
        // ist es das letzte Set im Spiel?
        if(activeSet == GameData.NUMBER_OF_SETS-1) {
          // Das Spiel ist zuende. Gehe zum End Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EndScreen()),
          );
        }else{
          // Das Spiel ist noch nicht zuende. Das nächste Set beginnt
          activeSet += 1;
          // wir starten natürlich wieder beim ersten Leg und Runde des Sets
          activeLeg = 0;
          activeRound = 0;
          activePlayer = 0;
          // Der Zwischen Bildschirm wird angezeigt
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ZwischenBild()),
          );
        }
      }else{
        // Alle Spieler haben jeweils 3 mal gewurfen
        print("Growing Legs");
        for (int player = 0; player < playerScoresByRound.length; player++) {
          playerScoresByRound[player][activeSet].add(List.generate(
            // Würfe
              3,
                  (indexB) => List.from([0, 1])));
        }
        activeLeg += 1;
        activePlayer = 0;
      }
    }
    // der aktuelle Wurf wird zu 1/3 gesetzt
    activeThrow = 0;
    calculateScores();
    notifyListeners();
  }

  void previousPlayer() {
    if (activePlayer > 0) {
      activePlayer -= 1;
    } else if (activePlayer == 0 && activeLeg > 0) {
      activeLeg -= 1;
      activePlayer = numberOfPlayers - 1;
    } else {
      activePlayer = 0;
    }
    activeThrow = 2;
    calculateScores();
    notifyListeners();
  }

  void calculateScores() {
    // print("calculating scores:");
    playerScoresByLeg = List.generate(MAX_PLAYER_COUNT, (index) => List.generate(NUMBER_OF_SETS, (index) => List.generate(NUMBER_OF_LEGS, (index) => is301 ? 301 : 501)));

    // Iterate over playerScoresByRound and sum up points for each player
    for (int player = 0; player < numberOfPlayers; player++) {
      for (int setty = 0; setty < playerScoresByRound[player].length; setty++) {
        for (int leggy = 0;
            leggy < playerScoresByRound[player][setty].length;
            leggy++) {
          // Clear existing playerScores
          if(setty == activeSet && leggy == activeLeg) {
            activeScoresByPlayers[player] = is301 ? 301 : 501;
          }
          List<int> counter = List.generate(MAX_PLAYER_COUNT, (index) => is301 ? 301 : 501);
          for (int round = 0;
              round < playerScoresByRound[player][setty][leggy].length;
              round++) {
            int befor_this_round = counter[player];
            for (int throwIndex = 0;
                throwIndex <
                    playerScoresByRound[player][setty][leggy][round].length;
                throwIndex++) {
              if (playerScoresByRound[player][setty][leggy][round][throwIndex]
                      [0] >
                  20) {
                counter[player] -= playerScoresByRound[player][setty]
                        [leggy][round][throwIndex][0] *
                    1;
              } else {
                counter[player] -= playerScoresByRound[player][setty]
                        [leggy][round][throwIndex][0] *
                    playerScoresByRound[player][setty][leggy][round][throwIndex]
                        [1];
              }
            }
            // Wenn zu viele Punkte gewurfen wurden zählt das entsprechende Leg nicht
            if (counter[player] < 0) {
              counter[player] = befor_this_round;
            }
          }
          if(setty == activeSet && leggy == activeLeg) {
            activeScoresByPlayers[player] = counter[player];
          }
          playerScoresByLeg[player][setty][leggy] = counter[player];
        }
      }
    }
    notifyListeners();
    print(playerScoresByLeg);
  }

  void generateScoreByRound() {
    playerScoresByRound = List.generate(
        MAX_PLAYER_COUNT,
        (index) => List.generate(
              // Sets ist konstant
              NUMBER_OF_SETS,
              (indexA) => List.generate(
                // Legs ist konstant
                NUMBER_OF_LEGS,
                (indexSet) => List.generate(
                  // Runde in Leg, kann variabel viele Runden pro Leg geben
                  1,
                  (indexThrow) => List.generate(
                      // einer von 3 Würfen
                      3,
                      (indexB) => List.from([0, 1])),
                  growable: true,
                ),
              ), // Sets
            ));
  }

  void generatePlayerList(int length) {
    numberOfPlayers = length;
    List<String> playerNames =
        List.generate(length, (index) => 'Spieler ${index + 1}');
    calculateScores();
  }

  GameData._internal();

  // Spielmodus
  bool isSingle = true;
  bool is301 = true;
  static const MAX_PLAYER_COUNT = 4;
  static const NUMBER_OF_SETS = 3;
  static const NUMBER_OF_LEGS = 3;

  List<List<List<int>>> playerScoresByLeg = List.generate(MAX_PLAYER_COUNT, (index) => List.generate(NUMBER_OF_SETS, (index) => List.generate(NUMBER_OF_LEGS, (index) => 0)));

  // Anzahl der Spieler
  int numberOfPlayers = 1;
  List<String> playerNames =
      List.generate(MAX_PLAYER_COUNT, (index) => 'Spieler ${index + 1}');

  // Aktiver Spieler
  int activePlayer = 0;
  int activeRound = 0; // 0-... bis einer 0 hat
  int activeLeg = 0; // 0-NUMBER_OF_SETS
  int activeSet = 0; // 0-NUMBER_OF_SETS
  int activeThrow = 0; // 0-2  Drei Würfe pro Spieler pro Runde
  DartThrow selectedDart = DartThrow.A;

  List<int> activeScoresByPlayers = List.generate(MAX_PLAYER_COUNT, (index) => 0);
  // Spieler Sets Legs Wurf [Punkte Multiplikator]
  // MAX     grow grow  3   1x
  List<List<List<List<List<List<int>>>>>> playerScoresByRound = List.generate(
      MAX_PLAYER_COUNT,
      (index) => List.generate(
            // Sets ist konstant
            NUMBER_OF_SETS,
            (indexA) => List.generate(
              // Legs ist konstant
              NUMBER_OF_LEGS,
              (indexSet) => List.generate(
                // Runde in Leg, kann variabel viele Runden pro Leg geben
                1,
                (indexThrow) => List.generate(
                    // einer von 3 Würfen
                    3,
                    (indexB) => List.from([0, 1]) // Punkte, Multiplikator
                    ),
                growable: true,
              ),
            ), // Sets
          ));
  // Gewinner pro Runde
  List<int> winnerPerRound = List.generate(0, (index) => 0, growable: true);
}
