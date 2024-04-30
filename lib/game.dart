import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        selectedForegroundColor: Colors.white,
        selectedBackgroundColor: Colors.black,

        // visualDensity: VisualDensity(horizontal: 3, vertical: 1),
        textStyle: TextStyle(
          fontSize: 23,
        )
      ),
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('60')),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('20')),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('14')),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
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

  NumberButton(this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, // Set button color to black
          fixedSize: Size(20, 20), // Set button size
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Set button shape
          ),
        ),
        onPressed: () {
          // Handle button press
          print('Button $number pressed');
        },
        child: Text(
          '$number',
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  List<int> numbers = List.generate(20, (index) => index + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(top: 45, bottom: 15),
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
                Text(
                  '187',
                  style: TextStyle(
                    fontSize: 96,
                    fontStyle: FontStyle.italic
                  )
                ),
                Text(
                  '/501',
                  style: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic
                  )
                ),

                Padding(padding: EdgeInsets.only(left: 55),
                  child: Column(
                    children: [
                      Text(
                          '⌀ im Set:',
                          style: TextStyle(
                              fontSize: 24,
                              fontStyle: FontStyle.italic
                          )
                      ),
                      Text(
                        '161', // Replace with the name of the user
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.9,
                child: SingleChoice(),
            ),

            SizedBox(
              height: 700,
              child: GridView.count(
                crossAxisCount: 4, // Adjust the number of columns as needed
                children: List.generate(numbers.length, (index) {
                  return NumberButton(numbers[index]);
                }),
              ),
            ),

          ],
        )
      )
    );
  }
}