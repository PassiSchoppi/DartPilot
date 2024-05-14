import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'game_data.dart';
import 'package:provider/provider.dart';

class ActiveStats extends StatelessWidget {
  GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
          padding: EdgeInsets.only(top: 45, bottom: 15),
          child: Consumer<GameData>(builder: (context, gameData, child) {
            return Text(
              gameData.playerNames[gameData.activePlayer],
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            );
          })),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<GameData>(builder: (context, gameData, child) {
            return Text(
              gameData.playerScores[gameData.activePlayer].toString(),
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            );
          }),
          Text('/501',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
          Flexible(
              child: Padding(
              padding: EdgeInsets.only(left: 55),
              child: Column(children: [
                Text('⌀ im Set:',
                    style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
                Consumer<GameData>(builder: (context, gameData, child) {
                  return Text(
                    gameData.playerScores[gameData.activePlayer].toString(),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ]),
            )
          )
        ],
      )
    ]);
  }
}
