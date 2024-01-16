import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // Set the background color to white
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Mismatch Memory Game'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Mismatch(),
      ),
    );
  }
}

class Mismatch extends StatefulWidget {
  const Mismatch({Key? key}) : super(key: key);

  @override
  State<Mismatch> createState() => _MismatchState();
}

class _MismatchState extends State<Mismatch> {
  List<int> cardIndices = [];
  List<bool> cardVisibility = [];
  int? previousIndex;
  int pairsFound = 0;
  bool gameFinished = false;
  late DateTime startTime;
  late DateTime endTime;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    cardIndices = List.generate(8, (index) => index % 4).toList()..shuffle();
    cardVisibility = List.generate(8, (index) => false);
    previousIndex = null;
    pairsFound = 0;
    gameFinished = false;
    startTime = DateTime.now(); // Initialize startTime here
  }

  void onCardTap(int index) {
    if (gameFinished) {
      return;
    }

    setState(() {
      cardVisibility[index] = true;

      if (previousIndex != null) {
        // Check if the selected card matches the previous card
        if (cardIndices[previousIndex!] != cardIndices[index]) {
          // If not a match, hide both cards after a short delay
          Timer(Duration(milliseconds: 500), () {
            setState(() {
              cardVisibility[previousIndex!] = false;
              cardVisibility[index] = false;
              previousIndex = null;
            });
          });
        } else {
          // If it's a match, increment pairsFound and reset the previous index
          pairsFound++;
          previousIndex = null;

          // Check if all pairs are found
          if (pairsFound == cardIndices.length ~/ 2) {
            // Game finished
            gameFinished = true;
            endTime = DateTime.now();
            showCongratulationsDialog();
          }
        }
      } else {
        // Set the previous index for the next comparison
        previousIndex = index;
      }
    });
  }

  void showCongratulationsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content:
              Text('You completed the game in ${calculateTime()} seconds.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  int calculateTime() {
    Duration duration = endTime.difference(startTime);
    return duration.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\nMismatched Game',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\nMatch the numbers to reveal the cards',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: const Color.fromARGB(
                255,
                222,
                213,
                213,
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: cardIndices.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (!cardVisibility[index] && previousIndex != index) {
                      onCardTap(index);
                    }
                  },
                  child: Card(
                    color: cardVisibility[index] ? Colors.purple : Colors.white,
                    child: Center(
                      child: Text(
                        cardVisibility[index]
                            ? cardIndices[index].toString()
                            : '?',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              initializeGame();
            });
          },
          child: Text('Restart Game'),
        ),
      ],
    );
  }
}
