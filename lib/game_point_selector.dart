import 'package:flutter/material.dart';

enum DartThrow { A, B, C }

int Wurf1 = 0;
int Wurf2 = 0;
int Wurf3 = 0;
DartThrow sel = DartThrow.A;

class SingleChoice extends StatefulWidget {
  const SingleChoice({Key? key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  DartThrow selectedDart = DartThrow.A;
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
            value: DartThrow.A, label: Text(Wurf1.toString())),
        ButtonSegment<DartThrow>(
            value: DartThrow.B, label: Text(Wurf2.toString())),
        ButtonSegment<DartThrow>(
            value: DartThrow.C, label: Text(Wurf3.toString())),
      ],
      selected: <DartThrow>{selectedDart},
      onSelectionChanged: (Set<DartThrow> newSelection) {
        setState(() {
          selectedDart = newSelection.first;
          sel = selectedDart;
        });
      },
      showSelectedIcon: false,
    );
  }
}

class _NumberButtonState extends State<NumberButton> {
  bool multiplied = false;

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
          switch (sel) {
            case DartThrow.A:
              multiplied = false;
              setState(() {
                if (widget.number == -2 && !multiplied) {
                  Wurf1 *= 2;
                  multiplied = true;

                } else if (widget.number == -3 && !multiplied) {
                  Wurf1 *= 3;
                  multiplied= true;
                } else {
                  Wurf1 = widget.number;
                }
              });
              break;
            case DartThrow.B:
              multiplied = false;
              setState(() {
                if (widget.number == -2 && !multiplied) {
                  Wurf2 *= 2;
                  multiplied = true;
                } else if (widget.number == -3 && !multiplied) {
                  Wurf2 *= 3;
                  multiplied = true;
                } else {
                  Wurf2 = widget.number;
                }
              });
              break;
            case DartThrow.C:
              multiplied = false;
              setState(() {
                if (widget.number == -2 && !multiplied) {
                  Wurf3 *= 2;
                  multiplied = true;
                } else if (widget.number == -3 && !multiplied) {
                  Wurf3 *= 3;
                  multiplied = true;
                } else {
                  Wurf3 = widget.number;
                }
              });
              break;
          }
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
