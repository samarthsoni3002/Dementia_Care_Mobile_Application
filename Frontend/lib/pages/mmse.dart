import 'package:flutter/material.dart';

class MMSE extends StatefulWidget {
  const MMSE({Key? key}) : super(key: key);

  @override
  State<MMSE> createState() => _MMSEState();
}

class _MMSEState extends State<MMSE> {
  final List<Map<String, dynamic>> mmseQuestions = [
    {
      "number": 1,
      "question": "What is 2 + 2?",
      "options": ["3", "4", "5"],
      "correctAnswer": "4",
      "answer": "",
    },
    {
      "number": 2,
      "question": "What is 10 multiplied by 5?",
      "options": ["40", "50", "60"],
      "correctAnswer": "50",
      "answer": "",
    },
    {
      "number": 3,
      "question": "Which color is the sky during the day?",
      "options": ["Blue", "Green", "Red"],
      "correctAnswer": "Blue",
      "answer": "",
    },
    {
      "number": 4,
      "question": "How many fingers does a person have on one hand?",
      "options": ["4", "5", "6"],
      "correctAnswer": "5",
      "answer": "",
    },
    {
      "number": 5,
      "question": "What is the capital of the United States?",
      "options": ["New York", "Washington, D.C.", "Los Angeles"],
      "correctAnswer": "Washington, D.C.",
      "answer": "",
    },
    {
      "number": 6,
      "question": "Which month comes after April?",
      "options": ["May", "June", "July"],
      "correctAnswer": "May",
      "answer": "",
    },
    {
      "number": 7,
      "question": "How many legs does a cat have?",
      "options": ["2", "4", "6"],
      "correctAnswer": "4",
      "answer": "",
    },
    {
      "number": 8,
      "question": "What is the opposite of 'hot'?",
      "options": ["Cold", "Warm", "Freezing"],
      "correctAnswer": "Cold",
      "answer": "",
    },
    {
      "number": 9,
      "question": "Which is the smallest planet in our solar system?",
      "options": ["Earth", "Mars", "Mercury"],
      "correctAnswer": "Mercury",
      "answer": "",
    },
    {
      "number": 10,
      "question": "What is the result of 8 minus 3?",
      "options": ["2", "5", "8"],
      "correctAnswer": "5",
      "answer": "",
    },
  ];

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mini Mental State Examination (MMSE)"),
      ),
      body: ListView.builder(
        itemCount: mmseQuestions.length,
        itemBuilder: (context, index) {
          return MMSEQuestion(
            questionData: mmseQuestions[index],
            onAnswerSelected: (String answer) {
              setState(() {
                // Check if the answer has already been selected for this question
                if (mmseQuestions[index]["answer"] != answer) {
                  mmseQuestions[index]["answer"] = answer;
                  if (mmseQuestions[index]["correctAnswer"] == answer) {
                    score++;
                  }
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Check if all questions are answered
          bool allQuestionsAnswered =
              mmseQuestions.every((question) => question["answer"].isNotEmpty);
          if (allQuestionsAnswered) {
            // Show the user's score and correct answers
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Assessment Result"),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your score: $score / ${mmseQuestions.length}"),
                      SizedBox(height: 10),
                      Text("Correct Answers:"),
                      for (var question in mmseQuestions)
                        Text(
                            "${question["number"]}. ${question["correctAnswer"]}"),
                    ],
                  ),
                  actions: [
                    // Button to close the dialog
                    TextButton(
                      onPressed: () {
                        // Reset the quiz
                        setState(() {
                          score = 0;
                          for (var question in mmseQuestions) {
                            question["answer"] = "";
                          }
                        });
                        // Close the dialog after resetting the quiz
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          } else {
            // Show an alert if not all questions are answered
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Incomplete Assessment"),
                  content: Text("Please answer all questions."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("OK"),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Icon(Icons.done),
      ),
    );
  }
}

class MMSEQuestion extends StatelessWidget {
  final Map<String, dynamic> questionData;
  final Function(String) onAnswerSelected;

  const MMSEQuestion({
    Key? key,
    required this.questionData,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${questionData["number"]}. ${questionData["question"]}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          // Display appropriate input based on the question type
          if (questionData["options"].isEmpty)
            TextField(
              onChanged: onAnswerSelected,
              keyboardType: TextInputType.text,
            )
          else
            Column(
              children: questionData["options"].map<Widget>((option) {
                return RadioListTile(
                  title: Text(option),
                  value: option,
                  groupValue: questionData["answer"],
                  onChanged: (value) {
                    onAnswerSelected(value as String);
                  },
                );
              }).toList(),
            ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MMSE(),
  ));
}
