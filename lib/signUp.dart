import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to add a new user to the "AccountList" collection in Firebase
  void addUserToAccountList(BuildContext context, String username, String email, String password) {
    FirebaseFirestore.instance.collection('AccountList').add({
      'Username': username,
      'Email': email,
      'Password': password, // Note: In a real-world scenario, you should not store passwords directly like this
    }).then((value) {
      // User added successfully, you can navigate to the home screen or display a success message
      Navigator.pop(context); // Return to the previous screen after sign-up
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Sign-up successful!'),
        duration: Duration(seconds: 2),
      ));
    }).catchError((error) {
      // Error handling: Display an error message if user creation fails
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error signing up: $error'),
        duration: Duration(seconds: 2),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the input values and call the addUserToAccountList function
                String username = usernameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
                  addUserToAccountList(context, username, email, password);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please fill all fields.'),
                    duration: Duration(seconds: 2),
                  ));
                }
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
