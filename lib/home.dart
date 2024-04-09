import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/foodlist.dart';
import 'dashboard.dart';
import 'FoodType.dart';
import 'Search.dart';
import 'restaurantinfo.dart'; // Import RestaurantDetail.dart

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Welcome, $username',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.network(
            'https://www.unileverfoodsolutions.co.th/dam/global-ufs/mcos/SEA/calcmenu/recipes/TH-recipes/pasta-dishes/%E0%B8%A2%E0%B8%B3%E0%B8%82%E0%B8%99%E0%B8%A1%E0%B8%88%E0%B8%B5%E0%B8%99/%E0%B8%A2%E0%B8%B3%E0%B8%82%E0%B8%99%E0%B8%A1%E0%B8%88%E0%B8%B5%E0%B8%99_header.jpg',
            width: 200, // Adjust width as needed
            height: 200, // Adjust height as needed
          ),
          const SizedBox(height: 20),
          Text(
            '  Recommended Restaurants:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('RestList').orderBy('Ratings', descending: true).limit(3).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Text('No restaurants found.');
                      }
                      return Row(
                        children: snapshot.data!.docs.map<Widget>((document) {
                          final restaurantData = document.data() as Map<String, dynamic>;
                          final String name = restaurantData['Name'] ?? 'Unknown';
                          final String imageUrl = restaurantData['Image'] ?? '';
                          final int rating = restaurantData['Ratings'] ?? 0; // Ensure it's treated as an integer
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetail(username: username,restaurantId: document.id),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 200, // Adjust width as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150, // Adjust height as needed
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Rating: $rating'),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 0),
    );
  }


BottomNavigationBar buildBottomNavigationBar(BuildContext context, int selectedIndex) {
  return BottomNavigationBar(
    backgroundColor: Colors.black,
    selectedItemColor: Color.fromARGB(255, 2, 69, 177),
    unselectedItemColor: Colors.black,
    currentIndex: selectedIndex,
    onTap: (int index) {
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(username: username)),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SearchPage(username: username,)),
          );
          break;
        case 2:
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FoodListPage(username: username,)),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FoodType(username: username,)),
          );
          break;
        case 4:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage(username: username)),
          );
          break;
      }
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 30),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search, size: 30),
        label: 'search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.restaurant_menu, size: 30),
        label: 'Explore',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.location_on, size: 30),
        label: 'Location',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard, size: 30),
        label: 'Dashboard',
      ),
    ],
  );
}
}