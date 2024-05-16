import 'package:dartpilot/game.dart';
import 'package:dartpilot/game_active_stats.dart';
import 'package:flutter/material.dart';

import 'game_data.dart';
import 'game_point_selector.dart';

import 'package:flutter/material.dart';

Widget generateTable(GameData gameData, BuildContext context) {
  return Container(
    height: (gameData.activeSet+1)*500,//220,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First row with player names
        Row(
          children: [
            SizedBox(width: 80), // Adjust the width as needed for spacing
            for (var i = 0; i < gameData.numberOfPlayers; i++)
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    gameData.playerNames[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
        // Table body with scores
        Expanded(
          child: ListView.builder(
            itemCount: GameData.NUMBER_OF_SETS, // Assuming all players have the same number of sets
            itemBuilder: (BuildContext context, int index) {
              // Check if the current row is odd or even to apply different background colors
              final Color? backgroundColor = index % 2 == 0 ? Colors.grey[200] : Colors.white;
              return Container(
                color: backgroundColor,
                child: Row(
                  children: [
                    // Set number
                    Container(
                      width: 80, // Adjust width as needed
                      alignment: Alignment.center,
                      child: Text(
                        'Set ${index + 1}',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Player scores for each leg
                    for (var i = 0; i < gameData.numberOfPlayers; i++)
                      Expanded(
                        child: Column(
                          children: [
                            for (var setScores in gameData.playerScoresByLeg[i])
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  style: TextStyle(fontSize: 24, color: setScores[index]==0 ? Colors.green : Colors.black),
                                    setScores[index].toString()
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        generateNavigationRow(context),
      ],
    ),
  );
}


class ZwischenBild extends StatelessWidget {
  GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: [
          SizedBox(height: 50),
          generateTable(gameData, context),
        ]
        )

      ),
    );
  }
}