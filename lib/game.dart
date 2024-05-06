import 'package:dartpilot/game_active_stats.dart';
import 'package:dartpilot/main.dart';
import 'package:flutter/material.dart';

import 'game_point_selector.dart';

Widget generateNavigationRow() {
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
            onPressed: () {
              // Add your functionality here for the left button
            },
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
            color: Colors.green.shade500,
          ),
          child: ElevatedButton(
            onPressed: () {
              /*Navigator.
              push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              )*/
            },
            child: Text(
              "Next",
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
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
              children: [
                ActiveStats(),
                const SizedBox(height: 40),
                PointSelector(),
                Spacer(),
                generateNavigationRow(),
                const SizedBox(height: 20),
              ],
            )
          ),
        );
  }
}
