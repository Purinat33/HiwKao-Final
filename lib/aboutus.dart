import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  final String username;
  AboutUsPage({required this.username});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CEO picture
              Image.asset(
                'assets/ceo.png', // Replace with the path to your CEO picture asset
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              SizedBox(height: 20),
              // Text paragraph
              Text(
                'Welcome to Hiwkhao, Hiwkhao is an application created to help users find restaurants in their area. We hope our application effectively supports and assists you in your search for restaurants.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
