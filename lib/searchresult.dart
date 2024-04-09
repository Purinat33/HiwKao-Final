import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'restaurantinfo.dart'; // Import RestaurantDetail.dart

class SearchResult extends StatelessWidget {
  final QuerySnapshot? snapshot;
  final Color backgroundColor; // Change color here
  final String username;
  SearchResult({Key? key, required this.snapshot, required this.backgroundColor, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (snapshot == null || snapshot!.docs.isEmpty) {
      return Center(
        child: Text('No restaurants found.'),
      );
    }

    return ListView.builder(
      itemCount: snapshot!.docs.length,
      itemBuilder: (context, index) {
        final restaurantData = snapshot!.docs[index];
        final String name = restaurantData['Name'] ?? 'Unknown';
        final String imageUrl = restaurantData['Image'] ?? '';
        final int rating = restaurantData['Ratings'] ?? 0;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RestaurantDetail(restaurantId: restaurantData.id, username: username,), // Pass the restaurant id to the detail page
              ),
            );
          },
          child: ListTile(
            title: Text(name),
            subtitle: Text('Rating: $rating'),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            tileColor: backgroundColor, // Set the background color here
          ),
        );
      },
    );
  }
}
