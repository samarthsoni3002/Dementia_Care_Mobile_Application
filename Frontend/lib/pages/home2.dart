import 'package:flutter/material.dart';
import 'package:minor/pages/emergency_page.dart';
import 'package:minor/pages/games.dart';
import 'package:minor/pages/home2.dart';
import 'package:minor/pages/home_screen.dart';
import 'package:minor/pages/livetracker.dart';
import 'package:minor/pages/mmse.dart';
import 'package:minor/pages/signin_page.dart'; // Import the page where you want to navigate

class HomePage1 extends StatefulWidget {
  final String username;

  const HomePage1({Key? key, required this.username}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome, ${widget.username.isNotEmpty ? widget.username : 'User'}!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20), // Adjust the spacing as needed
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              children: [
                _buildButton("Upload MRI", () {
                  // Redirect to HomePage()
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                }),
                _buildButton("MMSE", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MMSE()),
                  );
                }),
                _buildButton("Games", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Games()),
                  );
                }),
                _buildCenteredButton("Emergency Contact", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EmergencyScreen()),
                  );
                }),
                _buildButton("Live tracker", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LocationScreen()),
                  );
                }),
                _buildButton("Log out", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SigninScreen()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText, VoidCallback onPressed) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText),
      ),
    );
  }

  Widget _buildCenteredButton(String buttonText, VoidCallback onPressed) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Center(child: Text(buttonText)),
      ),
    );
  }
}
