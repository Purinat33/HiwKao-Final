import 'package:flutter/material.dart';
import 'package:untitled4/Home.dart';
import 'package:untitled4/FoodType.dart';
import 'package:untitled4/Search.dart';
import 'package:untitled4/SignIn.dart';
import 'package:untitled4/Foodlist.dart';
import 'package:untitled4/aboutus.dart';

class DashboardPage extends StatelessWidget {
  final String username;
  DashboardPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        children: [
          // Profile logo and username
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Profile logo
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      'assets/profilepic.png'), // Update the asset path
                ),
                SizedBox(width: 20),
                // Username
                Expanded(
                  child: Text(
                    username,
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Edit Profile and View Points buttons in the same row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add functionality to edit profile
                },
                child: Text('Edit Profile'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to view points
                },
                child: Text('View Points'),
              ),
            ],
          ),
          SizedBox(height: 20),
          // List of options
          ListTile(
            title: Text('Settings'),
            onTap: () {
              // Add functionality for settings
            },
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutUsPage(username: username)),
          );
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Add functionality for logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 4),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(
      BuildContext context, int selectedIndex) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Color.fromARGB(255, 2, 69, 177),
      unselectedItemColor: Colors.black,
      currentIndex: selectedIndex,
      onTap: (int index) {
        switch (index) {
          case 0: // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(username: username)),
            );
            break;
          case 1: // Search
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchPage(username: username)),
            );
            break;
          case 2: // Food List
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FoodListPage(username: username)),
            );
            break;
          case 3: // Location
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FoodType(username: username)),
            );
            break;
          case 4: // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage(username: username)),
            );
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu),
          label: 'Food List',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Location',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
      ],
    );
  }
}
