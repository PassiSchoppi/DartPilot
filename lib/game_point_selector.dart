import 'package:dartpilot/game_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum DartThrow { A, B, C }

var sel = 0;

class SingleChoice extends StatefulWidget {
  const SingleChoice({Key? key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  DartThrow selectedDart = DartThrow.A;
  GameData gameData = GameData();
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<DartThrow>(
      style: SegmentedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          selectedForegroundColor: Colors.white,
          selectedBackgroundColor: Colors.black,
          textStyle: TextStyle(
            fontSize: 23,
          )),
      segments: <ButtonSegment<DartThrow>>[
        ButtonSegment<DartThrow>(
            value: DartThrow.A,
            label: Consumer<GameData>(builder: (context, gameData, child) {
              return Text((gameData.playerScoresByRound[gameData.activePlayer]
                          [gameData.activeSet][gameData.activeLeg][0][0] *
                      gameData.playerScoresByRound[gameData.activePlayer]
                          [gameData.activeSet][gameData.activeLeg][0][1])
                  .toString());
            })),
        ButtonSegment<DartThrow>(
            value: DartThrow.B, label: Consumer<GameData>(builder: (context, gameData, child) {
          return Text((gameData.playerScoresByRound[gameData.activePlayer]
          [gameData.activeSet][gameData.activeLeg][1][0] *
              gameData.playerScoresByRound[gameData.activePlayer]
              [gameData.activeSet][gameData.activeLeg][1][1])
              .toString());
        })),
        ButtonSegment<DartThrow>(
            value: DartThrow.C, label: Consumer<GameData>(builder: (context, gameData, child) {
          return Text((gameData.playerScoresByRound[gameData.activePlayer]
          [gameData.activeSet][gameData.activeLeg][2][0] *
              gameData.playerScoresByRound[gameData.activePlayer]
              [gameData.activeSet][gameData.activeLeg][2][1])
              .toString());
        })),
      ],
      selected: <DartThrow>{selectedDart},
      onSelectionChanged: (Set<DartThrow> newSelection) {
        setState(() {
          selectedDart = newSelection.first;
          switch (selectedDart) {
            case DartThrow.A:
              sel = 0;
              break;
            case DartThrow.B:
              sel = 1;
              break;
            case DartThrow.C:
              sel = 2;
              break;
          }
        });
      },
      showSelectedIcon: false,
    );
  }
}

class _NumberButtonState extends State<NumberButton> {
  bool multiplied = false;
  GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    final Color finalBackgroundColor = widget.backgrounC ?? Colors.transparent;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          backgroundColor: finalBackgroundColor,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          // Handle button press
          print('Button ${widget.number} pressed');
          setState(() {
            if (widget.number < 0) {
              gameData.playerScoresByRound[gameData.activePlayer]
                      [gameData.activeSet][gameData.activeLeg][sel][1] =
                  -widget.number;
            } else {
              gameData.playerScoresByRound[gameData.activePlayer]
                      [gameData.activeSet][gameData.activeLeg][sel][0] =
                  widget.number;
            }
            gameData.calculateScores();
            gameData.notifyListeners();
          });
        },
        child: Text(
          widget.text ?? '${widget.number}',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}

class NumberButton extends StatefulWidget {
  final int number;
  final Color? backgrounC;
  final String? text;

  const NumberButton(this.number, {this.backgrounC, this.text});

  @override
  _NumberButtonState createState() => _NumberButtonState();
}

class PointSelector extends StatelessWidget {
  List<int> numbers = List.generate(20, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap the entire content in SingleChildScrollView
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: const SingleChoice(),
          ),
          SingleChildScrollView(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: List.generate(numbers.length, (index) {
                return NumberButton(numbers[index]);
              }),
            ),
          ),
          SingleChildScrollView(
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: [
                NumberButton(-2,
                    text: 'x2', backgrounC: Colors.amberAccent.shade100),
                NumberButton(-3, text: 'x3', backgrounC: Colors.orange.shade200),
                NumberButton(25, backgrounC: Colors.lightGreen.shade200),
                NumberButton(50, backgrounC: Colors.redAccent.shade100),
              ],
            ),
          )
        ],
      ),
    );
  }
}
