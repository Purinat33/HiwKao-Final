import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/restaurantinfo.dart';

class RestaurantListByType extends StatelessWidget {
  final String username;
  RestaurantListByType({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants by Type'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTypeBox('Thai Food', context),
          buildTypeBox('Western Food', context),
          buildTypeBox('Japanese Food', context),
          buildTypeBox('Chinese Food', context),
          // Add more type boxes as needed
        ],
      ),
    );
  }

  Widget buildTypeBox(String type, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to a page showing restaurants of the selected type
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RestaurantListByTypePage(type: type, username: username),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            type,
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

class RestaurantListByTypePage extends StatelessWidget {
  final String type;
  final String username;
  RestaurantListByTypePage({required this.type, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants - $type'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('RestList')
            .where('FoodType', isEqualTo: type)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No restaurants found for $type.'));
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
