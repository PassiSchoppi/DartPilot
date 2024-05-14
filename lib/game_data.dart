import 'package:flutter/cupertino.dart';
import 'game_point_selector.dart';

class GameData with ChangeNotifier {
  static final GameData _instance = GameData._internal();

  factory GameData() {
    return _instance;
  }

  void nextPlayer() {
    if (activePlayer < numberOfPlayers - 1) {
      activePlayer += 1;
    } else {
      activePlayer = 0;
    }
    activeThrow = 0;
    calculateScores();
    notifyListeners();
  }

  void previousPlayer() {
    if (activePlayer > 0) {
      activePlayer -= 1;
    } else if (activePlayer == 0) {
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
      print(is301 ? "301" : "501");
      playerScores[i] = is301 ? 301 : 501;
    }

    // Iterate over playerScoresByRound and sum up points for each player
    for (int player = 0; player < playerScoresByRound.length; player++) {
      for (int leg = 0; leg < playerScoresByRound[player].length; leg++) {
        for (int set = 0;
            set < playerScoresByRound[player][leg].length;
            set++) {
          for (int throwIndex = 0;
              throwIndex < playerScoresByRound[player][leg][set].length;
              throwIndex++) {

            if(playerScoresByRound[player][leg][set][throwIndex][0] > 20){
              playerScores[player] -=
                  playerScoresByRound[player][leg][set][throwIndex][0] * 1;
            }else {
              playerScores[player] -= playerScoresByRound[player][leg][set]
                      [throwIndex][0] *
                  playerScoresByRound[player][leg][set][throwIndex][1];
            }
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
  int activeLeg = 0;   // 0-... infinit
  int activeSet = 0;   // 0-... bis Sore auf 0
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
                  // Würfe
                  3,
                  (indexB) => List.from([0, 1])),
              growable: true // Sets
              ),
          growable: true // Legs
          ));
  // Gewinner pro Runde
  List<int> winnerPerRound = List.generate(0, (index) => 0, growable: true);
}
