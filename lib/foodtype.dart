import 'package:flutter/material.dart';
import 'package:untitled4/restArea.dart';
import 'dashboard.dart';
import 'foodlist.dart';
import 'home.dart';
import 'search.dart';
import 'RestType.dart'; // Import the RestaurantListByType page

class FoodType extends StatelessWidget {
  final String username;
  FoodType({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Categories'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 75,
              height: 200,
              padding: EdgeInsets.all(20),
              child: Image.asset(
                'assets/chef.png',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                'Explore by categories HERE!!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildBox(context, 'Restaurant Area/Province', Colors.blue, true), // Set to true for area
            SizedBox(height: 10),
            buildBox(context, 'Restaurant Type', Colors.orange, false), // Set to false for type
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 3, username), // Pass the username
    );
  }

  Widget buildBox(BuildContext context, String title, Color color, bool isArea) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding page based on the button pressed
        if (isArea) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RestaurantListByArea(username: username)),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RestaurantListByType(username: username)),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context, int selectedIndex, String username) {
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
          case 3: // FoodType
            // Do nothing as we are already on the FoodType page
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
          icon: Icon(Icons.restaurant),
          label: 'FoodType',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
      ],
    );
  }
}
