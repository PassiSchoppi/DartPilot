import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class GameData with ChangeNotifier {
  static final GameData _instance = GameData._internal();

  factory GameData() {
    return _instance;
  }

  void nextPlayer() {
    if( activePlayer < numberOfPlayers-1){
      activePlayer += 1;
    }else{
      activePlayer = 0;
    }
    notifyListeners();
  }

  void previousPlayer() {
    if( activePlayer > 0){
      activePlayer -= 1;
    }else{
      activePlayer = 0;
    }
    notifyListeners();
  }

  void calculateScores() {
    // Clear existing playerScores
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i] = 0;
    }

    // Iterate over playerScoresByRound and sum up points for each player
    for (int player = 0; player < playerScoresByRound.length; player++) {
      for (int leg = 0; leg < playerScoresByRound[player].length; leg++) {
        for (int set = 0; set <
            playerScoresByRound[player][leg].length; set++) {
          for (int throwIndex = 0;
          throwIndex < playerScoresByRound[player][leg][set].length;
          throwIndex++) {
            for (int pointIndex = 0;
            pointIndex <
                playerScoresByRound[player][leg][set][throwIndex].length;
            pointIndex++) {
              playerScores[player] +=
              playerScoresByRound[player][leg][set][throwIndex][pointIndex];
            }
          }
        }
      }
    }
  }

  void generateScoreByRound() {
    playerScoresByRound = List.generate(
        MAX_PLAYER_COUNT,
        (index) => List.generate(
            1,
            (indexA) =>
                List.generate(
                    3,
                    (indexB) => List.generate(1, (indexB) => List.generate(1, (indexC) => 0),
                )
              ),
          growable: true // Anzahl der Runden kann wachsen
        )
    );
  }

  void generatePlayerList(int length) {
    numberOfPlayers = length;
    List<String> playerNames =
      List.generate(length, (index) => 'Spieler ${index + 1}');
  }

  GameData._internal();

  // Spielmodus
  bool isSingle = true;
  bool is301 = true;
  static const MAX_PLAYER_COUNT = 4;

  // Anzahl der Spieler
  int numberOfPlayers = 1;
  List<String> playerNames =
      List.generate(MAX_PLAYER_COUNT, (index) => 'Spieler ${index + 1}');

  // Aktiver Spieler
  int activePlayer = 0;
  int activeLeg = 0;
  int activeSet = 0;

  List<int> playerScores = List.generate(1, (index) => 0);
  // Spieler Sets Legs Wurf Punkte
  List<List<List<List<List<int>>>>> playerScoresByRound =
  List.generate(
      1,
      (index) => List.generate(
          1,
          (indexA) => List.generate(
              1,
              (indexSet) => List.generate(3, (indexB) => List.generate(1, (indexB) => 0)
              ),
              growable: true // Sets
          ),
          growable: true // Legs
      )
  );
  // Gewinner pro Runde
  List<int> winnerPerRound = List.generate(0, (index) => 0, growable: true);
}
