import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart';
import 'SignUp.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign up',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Retrieve entered username and password from TextFields
                    String enteredUsername = usernameController.text;
                    String enteredPassword = passwordController.text;

                    // Retrieve data from Firestore
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection('AccountList')
                        .get();
                    List<DocumentSnapshot> docs = querySnapshot.docs;

                    bool isMatched = false;
                    for (var doc in docs) {
                      if (doc['Username'] == enteredUsername &&
                          doc['Password'] == enteredPassword) {
                        // Implement sign-in functionality
                        // For demonstration purposes, just print the username
                        print('Signed in as: ${doc['Username']}');
                        isMatched = true;
                        break;
                      }
                    }

                    if (isMatched) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage(username: enteredUsername)),
                      );
                    } else {
                      // Credentials not found
                      print('Invalid credentials');
                    }
                    
                  },
                  style: ElevatedButton.styleFrom(
                  backgroundColor:  Colors.blue), // background color
                  child: Text('Sign In', style: TextStyle(color: Colors.white)),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
