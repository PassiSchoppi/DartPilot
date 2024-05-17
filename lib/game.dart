import 'package:dartpilot/game_active_stats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_data.dart';
import 'game_point_selector.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

Widget generateNavigationRow() {
  return Consumer<GameData>(
    builder: (context, gameData, child) {
      return Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade400,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: gameData.previousPlayer,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.green.shade400,
              ),
              child: TextButton(
                onPressed: gameData.nextPlayer,
                child: Text(
                  "Nächster Spieler",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the orientation is portrait or landscape
          bool isPortrait = constraints.maxWidth < constraints.maxHeight;

          if (isPortrait) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Consumer<GameData>(builder: (context, gameData, child) {
                      return ActiveStats();
                    }),
                    SizedBox(height: 40),
                    Consumer<GameData>(builder: (context, gameData, child) {
                      return PointSelector();
                    }),
                    SizedBox(height: 40),
                    generateNavigationRow(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Consumer<GameData>(builder: (context, gameData, child) {
                            return ActiveStats();
                          }),
                          SizedBox(height: 10),
                          generateNavigationRow(),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Consumer<GameData>(builder: (context, gameData, child) {
                            return PointSelector();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

