import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Dashboard.dart';
import 'Home.dart';
import 'Search.dart';
import 'FoodType.dart';
import 'restaurantinfo.dart'; // Import FoodType.dart

class FoodListPage extends StatelessWidget {
  final String username;

  FoodListPage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('RestList').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No restaurants found.'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final restaurantData = snapshot.data!.docs[index];
              final String name = restaurantData['Name'] ?? 'Unknown';
              final String imageUrl = restaurantData['Image'] ?? '';
              final int rating = restaurantData['Ratings'] ?? 0;
              return ListTile(
                title: Text(name),
                subtitle: Text('Rating: $rating'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
                onTap: () {
                  // Navigate to restaurant detail page when tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantDetail(username: username, restaurantId:  restaurantData.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Color.fromARGB(255, 2, 69, 177),
        unselectedItemColor: Colors.black,
        currentIndex: 2, // Index of "Food List" item
        onTap: (int index) {
          if (index == 0) {
            // Home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(username: username)),
            );
          } else if (index == 1) {
            // Search
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SearchPage(username: username)),
            );
          } else if (index == 3) {
            // Location
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => FoodType(username: username)),
            );
          } else if (index == 4) {
            // Dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage(username: username)),
            );
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
      ),
    );
  }
}
