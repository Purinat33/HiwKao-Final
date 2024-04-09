import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class RestaurantDetail extends StatelessWidget {
  final String restaurantId; // Unique identifier for the restaurant
  final String username;
  RestaurantDetail({required this.restaurantId, required this.username});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchRestaurantDetails(restaurantId), // Function to fetch restaurant details from Firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Display loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}')); // Display error if any
          } else {
            // Display restaurant details once fetched
            final restaurantDetails = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    restaurantDetails['Image'], // URL of the restaurant image
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Restaurant Name: ${restaurantDetails['Name']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Area: ${restaurantDetails['Area']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Food Type: ${restaurantDetails['FoodType']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Province: ${restaurantDetails['Province']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Opening Hours: ${restaurantDetails['OpeningHours']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Ratings: ${restaurantDetails['Ratings']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchRestaurantDetails(String restaurantId) async {
    try {
      // Get reference to the restaurant document in Firestore
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('RestList').doc(restaurantId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract restaurant details from the document data
        Map<String, dynamic> restaurantData = documentSnapshot.data() as Map<String, dynamic>;
        return restaurantData;
      } else {
        // Return null if the document does not exist
        return {};
      }
    } catch (error) {
      // Handle any errors that occur during fetching
      print('Error fetching restaurant details: $error');
      throw error; // Rethrow the error for the FutureBuilder to catch
    }
  }
}
