import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DartThrow { A, B, C }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  DartThrow calendarView = DartThrow.A;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<DartThrow>(
      style: SegmentedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          selectedForegroundColor: Colors.white,
          selectedBackgroundColor: Colors.black,

          // visualDensity: VisualDensity(horizontal: 3, vertical: 1),
          textStyle: TextStyle(
            fontSize: 23,
          )),
      segments: const <ButtonSegment<DartThrow>>[
        ButtonSegment<DartThrow>(value: DartThrow.A, label: Text('60')),
        ButtonSegment<DartThrow>(value: DartThrow.B, label: Text('20')),
        ButtonSegment<DartThrow>(value: DartThrow.C, label: Text('14')),
      ],
      selected: <DartThrow>{calendarView},
      onSelectionChanged: (Set<DartThrow> newSelection) {
        setState(() {
          calendarView = newSelection.first;
        });
      },
      showSelectedIcon: false,
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final Color? backgrounC;
  final String? text;

  static const Color defaultBackgroundColor = Colors.transparent;

  NumberButton(this.number, {this.backgrounC, this.text});

  @override
  Widget build(BuildContext context) {
    final Color finalBackgroundColor = backgrounC ?? defaultBackgroundColor;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding:
              const EdgeInsets.symmetric(horizontal: 20), // Set button padding
          backgroundColor: finalBackgroundColor, // Set white background
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black, // Set black foreground color
          side: BorderSide(color: Colors.black), // Set black border color
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Set corner radius to 8px
          ),
        ),
        onPressed: () {
          // Handle button press
          print('Button $number pressed');
        },
        child: Text(
          text ?? '$number',
          style: TextStyle(fontSize: 20.0), // Reduce font size
        ),
      ),
    );
  }
}

class PointSelector extends StatelessWidget {
  List<int> numbers = List.generate(20, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: const SingleChoice(),
        ),
        SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4, // Adjust the number of columns as needed
            childAspectRatio: 2,
            children: List.generate(numbers.length, (index) {
              return NumberButton(numbers[index]);
            }),
          ),
        ),
        SingleChildScrollView(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4, // Adjust the number of columns as needed
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
    );
  }
}
