import 'package:flutter/material.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DartPilot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _playerCount = 2; // Default player count
  int _selectedGameMode = 301; // Default game mode
  bool isSingle = true;
  bool is301 = true;
  int selectedPlayers = 1;

  List<String> _playerNames =
      List.generate(4, (index) => 'Spieler ${index + 1}');

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Anzahl von Spieler:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(4, (index) {
                int playerCount = index + 1;
                return Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPlayers = playerCount;
                        _playerNames = List.generate(
                            selectedPlayers, (index) => 'Spieler ${index + 1}');
                        print("$selectedPlayers");
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedPlayers == playerCount
                          ? Colors.blue[100]
                          : Colors.grey[300],
                      padding: EdgeInsets.all(15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: playerCount == 5
                              ? Colors.black
                              : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: Text(
                      '$playerCount',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              'Spielernamen:',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Column(
              children: _playerNames.map((name) {
                return TextFormField(
                  initialValue: name,
                  onChanged: (value) {
                    _playerNames[_playerNames.indexOf(name)] = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Spieler ${_playerNames.indexOf(name) + 1}',
                  ),
                );
              }).toList(),
            ),
            Text(
              'Spielmodus:',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      is301 = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        is301 ? Colors.blue[100] : Colors.grey[300],
                  ),
                  child: Text(
                    '301',
                    style: TextStyle(
                      color: Colors.black, // Hier änderst du die Farbe
                      fontSize: 30.0,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      is301 = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !is301 ? Colors.blue[100] : Colors.grey[300],
                  ),
                  child: Text(
                    '501',
                    style: TextStyle(
                      color: Colors.black, // Hier änderst du die Farbe
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Out:',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSingle = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isSingle ? Colors.blue[100] : Colors.grey[300],
                  ),
                  child: Text(
                    'Single',
                    style: TextStyle(
                      color: Colors.black, // Hier änderst du die Farbe
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isSingle = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        !isSingle ? Colors.blue[100] : Colors.grey[300],
                  ),
                  child: Text(
                    'Double',
                    style: TextStyle(
                      color: Colors.black, // Hier änderst du die Farbe
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GameScreen()),
                  );
                },
                child: Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyGameState {
  const _MyGameState();
}
