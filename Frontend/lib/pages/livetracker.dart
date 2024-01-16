import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "";
  bool locationObtained = false;

  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        // Extract latitude and longitude directly without labels
        locationMessage = "${position.latitude},${position.longitude}";
        locationObtained = true;
      });
    } catch (e) {
      print(e);
    }
  }

  // Function to handle sharing
  void shareLocation() {
    if (locationObtained) {
      // Copy to clipboard
      Clipboard.setData(ClipboardData(text: locationMessage));

      // Launch map application
      launchMap(locationMessage);
    } else {
      // Prompt user to get location first
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Please Get Location"),
            content: Text(
                "Click the 'Get Location' button to obtain your location."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  // Function to launch the map application
  void launchMap(String coordinates) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$coordinates';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        print('Could not launch $url');
      }
    } catch (e) {
      print('Error launching map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              locationMessage,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getCurrentLocation();
              },
              child: Text("Get Location"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                shareLocation();
              },
              child: Text("Share"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LocationScreen(),
  ));
}
