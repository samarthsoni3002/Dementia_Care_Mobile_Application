import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor/pages/home2.dart';
import 'package:minor/pages/home_screen.dart';
import 'package:minor/pages/signup_page.dart';
import 'package:minor/reusable_widget/reusable_widget.dart';
import 'package:minor/utils/color_utils.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String _errorMessage = ''; // Added variable to store error message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("E3D3F1"),
              hexStringToColor("C99CF0"),
              hexStringToColor("BB7FEF"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logoWidget("assets/images/main_logo1.png"),
                SizedBox(height: 30),
                reusableTextField(
                  "Enter Email",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                SizedBox(height: 30),
                reusableTextField(
                  "Enter Password",
                  Icons.lock_outline,
                  true, // Set to true for password field
                  _passwordTextController,
                ),
                SizedBox(height: 20),
                // Display error message
                Text(
                  _errorMessage,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                signinsignup(context, true, () async {
                  // Clear previous error message
                  setState(() {
                    _errorMessage = '';
                  });

                  // Check if email and password are not empty
                  if (_emailTextController.text.isNotEmpty &&
                      _passwordTextController.text.isNotEmpty) {
                    try {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      );

                      // Set the display name (username)
                      await userCredential.user?.updateProfile(
                        displayName: _emailTextController.text,
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage1(
                            username: _emailTextController.text,
                          ),
                        ),
                      );
                    } catch (error) {
                      // Update error message
                      setState(() {
                        _errorMessage = "Email or Password Wrong";
                      });
                      print("Error: ${error.toString()}");
                    }
                  } else {
                    // Show an error message or handle accordingly
                    setState(() {
                      _errorMessage = "Please fill in all fields";
                    });
                    print("Please fill in all fields");
                  }
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
