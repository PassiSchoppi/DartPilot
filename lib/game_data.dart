class GameData {
  static final GameData _instance = GameData._internal();

  factory GameData() {
    return _instance;
  }

  void calculateScores() {
    // Clear existing playerScores
    for (int i = 0; i < playerScores.length; i++) {
      playerScores[i] = 0;
    }

    // Iterate over playerScoresByRound and sum up points for each player
    for (int player = 0; player < playerScoresByRound.length; player++) {
      for (int round = 0; round < playerScoresByRound[player].length; round++) {
        for (int throwIndex = 0;
            throwIndex < playerScoresByRound[player][round].length;
            throwIndex++) {
          for (int pointIndex = 0;
              pointIndex <
                  playerScoresByRound[player][round][throwIndex].length;
              pointIndex++) {
            playerScores[player] +=
                playerScoresByRound[player][round][throwIndex][pointIndex];
          }
        }
      }
    }
  }

  void generateScoreByRound() {
    playerScoresByRound = List.generate(
        numberOfPlayers,
        (index) => List.generate(
            1,
            (indexA) =>
                List.generate(3, (indexB) => List.generate(1, (indexB) => 0)),
            growable: true));
  }

  GameData._internal();

  // Spielmodus
  bool isSingle = true;
  bool is301 = true;

  // Anzahl der Spieler
  int numberOfPlayers = 1;
  List<String> playerNames =
      List.generate(1, (index) => 'Spieler ${index + 1}');

  // Aktiver Spieler
  int activePlayer = 0;
  int round = 0;
  List<int> playerScores = List.generate(1, (index) => 0);
  // Spieler Runde Wurf Punkte
  List<List<List<List<int>>>> playerScoresByRound = List.generate(
      1,
      (index) => List.generate(
          1,
          (indexA) =>
              List.generate(3, (indexB) => List.generate(1, (indexB) => 0)),
          growable: true));
  // Gewinner pro Runde
  List<int> winnerPerRound = List.generate(0, (index) => 0, growable: true);
}
