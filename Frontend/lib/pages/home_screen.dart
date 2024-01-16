import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PickedFile? _pickedImage;
  String _prediction = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.purple[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset(
              'assets/images/upload_oldies.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Please upload your MRI Here",
            style: TextStyle(
              color: Colors.purple[800],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().getImage(source: ImageSource.gallery);

              if (pickedFile != null) {
                setState(() {
                  _pickedImage = pickedFile;
                  _prediction =
                      "Loading..."; // Set loading text while waiting for prediction
                });

                // Perform image upload and prediction
                await predictImage(pickedFile.path);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.purple[600],
            ),
            child: Text(
              "Upload MRI",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          if (_pickedImage != null)
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                child: Image.file(
                  File(_pickedImage!.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(height: 16),
          Text(
            _prediction,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        "Dementia",
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.purple[700],
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context); // Navigate back
        },
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.arrow_back, color: Colors.purple[700]),
        ),
      ),
      elevation: 0.0,
    );
  }

  Future<void> predictImage(String imagePath) async {
    final url = "http://09aa-2409-40d0-17-d1cb-4d0d-7078-b8eb-89d4.ngrok.io";

    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imagePath,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data =
            json.decode(await response.stream.bytesToString());
        final prediction = data["prediction"];

        setState(() {
          _prediction = prediction;
        });
      } else {
        setState(() {
          _prediction = "Error occurred while making the prediction.";
        });
      }
    } catch (error) {
      setState(() {
        _prediction = "Error occurred: $error";
      });
    }
  }
}
