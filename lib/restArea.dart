import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/restaurantinfo.dart';

class RestaurantListByArea extends StatelessWidget {
  final String username;
  RestaurantListByArea({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants by Area'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildAreaBox('Bangkok', context),
          buildAreaBox('Nonthaburi', context),
          buildAreaBox('Nakhon Pathom', context),
          // Add more area boxes as needed
        ],
      ),
    );
  }

  Widget buildAreaBox(String area, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a page showing restaurants in the selected area
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RestaurantListPage(area: area, username: username)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            area,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  final String area;
  final String username;
  RestaurantListPage({required this.area, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants in $area'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('RestList')
            .where('Province', isEqualTo: area)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No restaurants found in $area.'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot restaurantDoc = snapshot.data!.docs[index];
              return buildRestaurantCard(restaurantDoc, context);
            },
          );
        },
      ),
    );
  }

  Widget buildRestaurantCard(
      DocumentSnapshot restaurantDoc, BuildContext context) {
    Map<String, dynamic> restaurantData =
        restaurantDoc.data() as Map<String, dynamic>;
    String name = restaurantData['Name'] ?? 'Unknown';
    String imageUrl = restaurantData['Image'] ?? '';
    int rating = restaurantData['Ratings'] ?? 0;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: imageUrl.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
              )
            : null,
        title: Text(name),
        subtitle: Text('Rating: $rating'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RestaurantDetail(
                  username: username, restaurantId: restaurantDoc.id),
            ),
          );
        },
      ),
    );
  }
}
