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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > constraints.maxHeight) {
            // Landscape mode
            return _buildLandscapeLayout();
          } else {
            // Portrait mode
            return _buildPortraitLayout();
          }
        },
      ),
    );
  }

  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('DartPilot', style: TextStyle(fontSize: 50.0), textAlign: TextAlign.center),
            Text('Anzahl von Spieler:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
            SizedBox(height: 20.0),
            _buildPlayerCountButtons(),
            SizedBox(height: 20),
            Text('Spielernamen:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
            SizedBox(height: 10),
            _buildPlayerNameInputs(),
            SizedBox(height: 20),
            Text('Spielmodus:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
            SizedBox(height: 20),
            _buildGameModeButtons(),
            SizedBox(height: 20),
            Text('Out:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
            SizedBox(height: 20),
            _buildOutButtons(),
            SizedBox(height: 20),
            _buildStartButton(),
            SizedBox(height: 20),
            _buildEndButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('DartPilot', style: TextStyle(fontSize: 50.0), textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  Text('Spielmodus:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  _buildGameModeButtons(),
                  SizedBox(height: 10),
                  Text('Out:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  SizedBox(height: 10),
                  _buildOutButtons(),
                  SizedBox(height: 10),
                  _buildStartButton(),
                  _buildEndButton(),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Anzahl von Spieler:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  SizedBox(height: 20.0),
                  _buildPlayerCountButtons(),
                  SizedBox(height: 20),
                  Text('Spielernamen:', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center),
                  SizedBox(height: 5),
                  _buildPlayerNameInputs(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCountButtons() {
    return Wrap(
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
              backgroundColor: gameData.numberOfPlayers == playerCount ? Colors.blue[100] : Colors.grey[300],
              padding: EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: playerCount == 5 ? Colors.black : Colors.transparent,
                  width: 2.0,
                ),
              ),
            ),
            child: Text(
              '$playerCount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPlayerNameInputs() {
    return Center(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(gameData.numberOfPlayers, (index) {
            return TextFormField(
              controller: controllers[index],
              onChanged: (newValue) {
                setState(() {
                  gameData.playerNames[index] = newValue;
                });
              },
              decoration: InputDecoration(
                labelText: 'Player ${index + 1}',
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
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
    );
  }

  Widget _buildGameModeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            setState(() {
              gameData.gameMode = 101;
            });
            gameData.calculateScores();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (gameData.gameMode == 101) ? Colors.blue[100] : Colors.grey[300],
          ),
          child: Text(
            '101',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              gameData.gameMode = 301;
            });
            gameData.calculateScores();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (gameData.gameMode == 301) ? Colors.blue[100] : Colors.grey[300],
          ),
          child: Text(
            '301',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              gameData.gameMode = 501;
            });
            gameData.calculateScores();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (gameData.gameMode == 501) ? Colors.blue[100] : Colors.grey[300],
          ),
          child: Text(
            '501',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutButtons() {
    return Row(
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
            backgroundColor: gameData.isSingle ? Colors.blue[100] : Colors.grey[300],
          ),
          child: Text(
            'Single',
            style: TextStyle(
              color: Colors.black,
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
            backgroundColor: !gameData.isSingle ? Colors.blue[100] : Colors.grey[300],
          ),
          child: Text(
            'Double',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return Center(
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
    );
  }

  Widget _buildEndButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EndScreen( winnerName: 'Leander',)),
          );
        },
        child: Text('End'),
      ),
    );
  }
}

class _MyGameState {
  const _MyGameState();
}
