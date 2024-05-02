import 'package:flutter/widgets.dart';

class ActiveStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 45, bottom: 15),
        child: Text(
          'Pascal', // Replace with the name of the user
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
