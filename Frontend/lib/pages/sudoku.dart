import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sudoku(),
    );
  }
}

class Sudoku extends StatefulWidget {
  const Sudoku({Key? key}) : super(key: key);

  @override
  State<Sudoku> createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  late List<List<int>> sudokuGrid;

  @override
  void initState() {
    super.initState();
    sudokuGrid = generateSudoku();
  }

  List<List<int>> generateSudoku() {
    // You can implement your own Sudoku generation logic here.
    // For demonstration, here's a simple example of a partially filled Sudoku grid.
    return [
      [5, 3, 0, 0, 7, 0, 0, 0, 0],
      [6, 0, 0, 1, 9, 5, 0, 0, 0],
      [0, 9, 8, 0, 0, 0, 0, 6, 0],
      [8, 0, 0, 0, 6, 0, 0, 0, 3],
      [4, 0, 0, 8, 0, 3, 0, 0, 1],
      [7, 0, 0, 0, 2, 0, 0, 0, 6],
      [0, 6, 0, 0, 0, 0, 2, 8, 0],
      [0, 0, 0, 4, 1, 9, 0, 0, 5],
      [0, 0, 0, 0, 8, 0, 0, 7, 9],
    ];
  }

  void showNumberPicker(int row, int col) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a number'),
          content: Container(
            height: 200,
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      // Check if the selected number is valid in the current cell
                      if (isValidMove(row, col, index + 1)) {
                        sudokuGrid[row][col] = index + 1;
                      } else {
                        // Optionally, show a message indicating an invalid move
                        // For simplicity, we are not handling invalid moves here.
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
              itemCount: 9,
            ),
          ),
        );
      },
    );
  }

  bool isValidMove(int row, int col, int num) {
    // Check if the number is not present in the current row and column
    for (int i = 0; i < 9; i++) {
      if (sudokuGrid[row][i] == num || sudokuGrid[i][col] == num) {
        return false;
      }
    }

    // Check if the number is not present in the current 3x3 subgrid
    int subgridRow = row - row % 3;
    int subgridCol = col - col % 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (sudokuGrid[subgridRow + i][subgridCol + j] == num) {
          return false;
        }
      }
    }

    return true;
  }

  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () {
        // Allow users to fill only empty cells
        if (sudokuGrid[row][col] == 0) {
          showNumberPicker(row, col);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black),
        ),
        child: Center(
          child: Text(
            sudokuGrid[row][col] != 0 ? sudokuGrid[row][col].toString() : '',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Create a 9x9 grid of Sudoku cells
            Column(
              children: List.generate(
                9,
                (row) => Row(
                  children: List.generate(
                    9,
                    (col) => SizedBox(
                      width: 40,
                      height: 40,
                      child: buildCell(row, col),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
