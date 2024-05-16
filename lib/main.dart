import 'package:flutter/material.dart';
import 'game.dart';
import 'end.dart';
import 'zwischenBild.dart';
import 'game_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => GameData(),
        child: MyApp(),
      ),
  );
  // WidgetsFlutterBinding.ensureInitialized();
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
  GameData gameData = GameData();
  static const MAX_PLAYER_COUNT = 4;
  late List<TextEditingController> controllers = List.generate(MAX_PLAYER_COUNT, (index) => TextEditingController(text: gameData.playerNames[index]));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'DartPilot',
                style: TextStyle(fontSize: 50.0),
                textAlign: TextAlign.center,
              ),
              Text(
                'Anzahl von Spieler:',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: List.generate(MAX_PLAYER_COUNT, (index) {
                  int playerCount = index + 1;
                  return Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          gameData.generatePlayerList(playerCount);
                          print("$gameData.selectedPlayers");
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gameData.numberOfPlayers == playerCount
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
                        style: TextStyle(
                          color: Colors.black, // Hier änderst du die Farbe
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Spielernamen:',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: 300, // Festlegen einer festen Breite für die Spalte
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Spaltenbreite begrenzen
                    children: List.generate(gameData.numberOfPlayers, (index) {
                      return TextFormField(
                        controller: controllers[index],
                        onChanged: (newValue) {
                          setState(() {
                            // Update the value in the playerNames list when text changes
                            gameData.playerNames[index] = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Player ${index + 1}',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                // Clear the text and update the playerNames list
                                controllers[index].clear();
                                gameData.playerNames[index] = '';
                              });
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),


              SizedBox(height: 20),
              Text(
                'Spielmodus:',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        gameData.is301 = true;
                      });
                      gameData.calculateScores();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          gameData.is301 ? Colors.blue[100] : Colors.grey[300],
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
                        gameData.is301 = false;
                      });
                      gameData.calculateScores();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !gameData.is301 ? Colors.blue[100] : Colors.grey[300],
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
              SizedBox(height: 20),
              Text(
                'Out:',
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        gameData.isSingle = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          gameData.isSingle ? Colors.blue[100] : Colors.grey[300],
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
                        gameData.isSingle = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !gameData.isSingle ? Colors.blue[100] : Colors.grey[300],
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
                    setState(() {
                      gameData.calculateScores();
                      gameData.notifyListeners();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                  child: Text('Start'),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EndScreen()),
                    );
                  },
                  child: Text('End'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyGameState {
  const _MyGameState();
}
