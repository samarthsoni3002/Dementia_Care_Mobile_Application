import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: EmergencyScreen(),
  ));
}

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Helpline',
          style: TextStyle(color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFCB2B93), Color(0xFF867DAD)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Here are some Helpline Numbers for Dementia and Alzheimer\'s patients in India:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'The National Dementia Support Line (from Dementia India Alliance)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              '8:00 am to 6:00 pm, Monday through Saturday',
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showHelplineNumber(context, '8585 990 990');
                },
                child: Text('Call Helpline Number'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'National Helpline for Senior Citizens (NHSC) – Elder Line:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showHelplineNumber(context, '14567');
                },
                child: Text('Call Helpline Number'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Alzheimer\'s and Related Disorders Society of India:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _showHelplineNumber(context, '+91 4885 223 801');
                },
                child: Text('Call Helpline Number'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Some clinics in India that treat Alzheimer\'s disease include:',
            ),
            Text('Artemis Hospitals, Gurgaon'),
            Text('Manipal Hospitals, Bengaluru'),
            Text('Global Hospital Chennai, Chennai'),
            Text('Apollo Hospital Indraprastha, Delhi'),
          ],
        ),
      ),
    );
  }

  void _showHelplineNumber(BuildContext context, String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Emergency Helpline Number'),
          content: Text('Call: $phoneNumber'),
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
}
