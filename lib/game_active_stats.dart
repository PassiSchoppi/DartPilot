import 'package:flutter/widgets.dart';
import 'game_data.dart';

class ActiveStats extends StatelessWidget {
  GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 45, bottom: 15),
        child: Text(
          gameData.playerNames[gameData.activePlayer],
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('187',
              style: TextStyle(fontSize: 96, fontStyle: FontStyle.italic)),
          Text('/501',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
          Padding(
            padding: EdgeInsets.only(left: 55),
            child: Column(children: [
              Text('⌀ im Set:',
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic)),
              Text(
                '161', // Replace with the name of the user
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
            ]),
          ),
        ],
      )
    ]);
  }
}
