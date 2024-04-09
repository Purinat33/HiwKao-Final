import 'package:flutter/material.dart';
import 'signin.dart'; // Import the file where you want to navigate

void main() {
  runApp(LauncherApp());
}

class LauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Launcher App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HIWKHAO'), // Title "HIWKHAO"
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/hiwkhaologo.png',
              width: 200, // Adjust width as needed
              height: 200, // Adjust height as needed
            ),
            SizedBox(height: 20), // Add some spacing between the image and button
            ElevatedButton(
  onPressed: () {
    // Navigate to SignInScreen when button is pressed
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  },
  style: ElevatedButton.styleFrom(
  backgroundColor:  Colors.blue, // background color
  ),
  child: Text('Start', style: TextStyle(color: Colors.white)), // text color
),
          ],
        ),
      ),
    );
  }
}
