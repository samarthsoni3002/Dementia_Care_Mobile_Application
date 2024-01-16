// Games.dart
import 'package:flutter/material.dart';
import 'package:minor/pages/mismatch.dart';
import 'package:minor/pages/sudoku.dart';
import 'package:minor/pages/tricky_colors.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Games', textAlign: TextAlign.center),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: screenHeight * 0.6,
              margin: EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  'assets/images/games_oldies.jpeg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TGame()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Tricky Colors',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Mismatch()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Mismatched',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sudoku()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Sudoko',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
