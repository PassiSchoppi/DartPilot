import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  final String winnerName;

  EndScreen({required this.winnerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'Excalidraw/Winner-Winner-Chicken-Dinner_280x183.png',
              width: 280,
              height: 183,
            ),
            SizedBox(height: 20),
            Text(
              '$winnerName\nhat gewonnen!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black54,
                    offset: Offset(2.0, 2.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
