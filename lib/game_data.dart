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
    if (activePlayer < numberOfPlayers - 1) {
      activePlayer += 1;
    } else {
      // Hat der aktive Spieler 0 Punkte?
      calculateScores();
      if(playerScores[activePlayer] == 0){
        print("Leg gewonnen!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ZwischenBild()),
        );
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
    activeThrow = 0;
    calculateScores();
    notifyListeners();
  }

  void previousPlayer() {
    if (activePlayer > 0) {
      activePlayer -= 1;
    } else if (activePlayer == 0 && activeLeg>0) {
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
    // Clear existing playerScores
    for (int i = 0; i < playerScores.length; i++) {
      print("calculating scores:");
      playerScores[i] = is301 ? 301 : 501;
    }

    // Iterate over playerScoresByRound and sum up points for each player
    for (int player = 0; player < playerScoresByRound.length; player++) {
      for (int setty = 0; setty < playerScoresByRound[player].length; setty++) {
        for (int leggy = 0;
            leggy < playerScoresByRound[player][setty].length;
            leggy++) {
          int befor_this_leg = playerScores[player];
          for (int throwIndex = 0;
              throwIndex < playerScoresByRound[player][setty][leggy].length;
              throwIndex++) {
            if (playerScoresByRound[player][setty][leggy][throwIndex][0] > 20) {
              playerScores[player] -=
                  playerScoresByRound[player][setty][leggy][throwIndex][0] * 1;
            } else {
              playerScores[player] -= playerScoresByRound[player][setty][leggy]
                      [throwIndex][0] *
                  playerScoresByRound[player][setty][leggy][throwIndex][1];
            }
          }
          // Wenn zu viele Punkte gewurfen wurden zählt das entsprechende Leg nicht
          if(playerScores[player] < 0){
            playerScores[player] = befor_this_leg;
          }
        }
      }
    }
    notifyListeners();
  }

  void generateScoreByRound() {
    playerScoresByRound = List.generate(
        MAX_PLAYER_COUNT,
        (index) => List.generate(
            // Sets
            1,
            (indexA) => List.generate(
                // Legs
                1,
                (indexSet) => List.generate(
                    // Würfe
                    3,
                    (indexB) => List.from([0, 1])),
                growable: true // Sets
                ),
            growable: true // Legs
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

  // Anzahl der Spieler
  int numberOfPlayers = 1;
  List<String> playerNames =
      List.generate(MAX_PLAYER_COUNT, (index) => 'Spieler ${index + 1}');

  // Aktiver Spieler
  int activePlayer = 0;
  int activeLeg = 0; // 0-... infinit
  int activeSet = 0; // 0-... bis Sore auf 0
  int activeThrow = 0; // 0-2
  DartThrow selectedDart = DartThrow.A;

  List<int> playerScores = List.generate(MAX_PLAYER_COUNT, (index) => 0);
  // Spieler Sets Legs Wurf [Punkte Multiplikator]
  // MAX     grow grow  3   1x
  List<List<List<List<List<int>>>>> playerScoresByRound = List.generate(
      MAX_PLAYER_COUNT,
      (index) => List.generate(
          // Sets
          1,
          (indexA) => List.generate(
              // Legs
              1,
              (indexSet) => List.generate(
                  // einer von 3 Würfen
                  3,
                  (indexB) => List.from([0, 1])),
              growable: true // Legs
              ),
          growable: true // Sets
          ));
  // Gewinner pro Runde
  List<int> winnerPerRound = List.generate(0, (index) => 0, growable: true);
}
