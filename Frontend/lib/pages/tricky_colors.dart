import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Tricky Colors',
    theme: ThemeData(
      primaryColor: Colors.purple,
      colorScheme: ColorScheme.light(primary: Colors.purple),
      scaffoldBackgroundColor: Colors.purple,
    ),
    home: TGame(),
  ));
}

class TGame extends StatefulWidget {
  const TGame({Key? key}) : super(key: key);

  @override
  State<TGame> createState() => _TGameState();
}

class _TGameState extends State<TGame> {
  List<String> colorWords = [
    'Red',
    'Green',
    'Blue',
    'Yellow',
    'Purple',
    'Orange'
  ];
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange
  ];

  Random random = Random();

  Color currentColor = Colors.transparent;
  String currentWord = '';
  int score = 0;
  int attempts = 0;
  int maxAttempts = 10;

  @override
  void initState() {
    super.initState();
    generateRandomWord();
  }

  void generateRandomWord() {
    if (attempts < maxAttempts) {
      int randomIndex = random.nextInt(colorWords.length);
      setState(() {
        currentWord = colorWords[randomIndex];
        currentColor = colors[random.nextInt(colors.length)];
      });
    } else {
      showGameOverDialog();
    }
  }

  void checkAnswer(Color selectedColor) {
    if (selectedColor == currentColor) {
      // Correct
      setState(() {
        score++;
      });
    }
    attempts++;
    generateRandomWord();
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('Your score: $score / $maxAttempts'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      attempts = 0;
    });
    generateRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tricky Colors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tap on the color, not the word:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Score: $score / $maxAttempts',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              currentWord,
              style: TextStyle(
                color: currentColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: colors
                  .map((color) => ElevatedButton(
                        onPressed: () => checkAnswer(color),
                        style: ElevatedButton.styleFrom(
                          primary: color,
                          padding: EdgeInsets.all(20),
                        ),
                        child: Container(),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
