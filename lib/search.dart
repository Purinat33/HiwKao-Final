import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/searchresult.dart';
import 'dashboard.dart';
import 'home.dart';
import 'FoodType.dart';
import 'foodlist.dart';

class SearchPage extends StatefulWidget {
  final String username;
  SearchPage({required this.username});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  late Stream<QuerySnapshot> _searchStream;
  bool _isSearchButtonClicked = false;

  @override
  void initState() {
    super.initState();
    _searchStream = FirebaseFirestore.instance.collection('RestList').snapshots();
  }

  void _performSearch() {
    setState(() {
      _searchStream = FirebaseFirestore.instance
          .collection('RestList')
          .where('Name', isGreaterThanOrEqualTo: _searchQuery)
          .where('Name', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .snapshots();
      _isSearchButtonClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _performSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for restaurants...',
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          // Conditionally render the search results
          if (_isSearchButtonClicked)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _searchStream,
                builder: (context, snapshot) {
                  return SearchResult(username: widget.username, snapshot: snapshot.data, backgroundColor: Color.fromARGB(255, 245, 199, 91)); // Change the color here
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Text(
                  'Start typing to search desired restaurant',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(context, 1, widget.username),
    );
  }
}
BottomNavigationBar buildBottomNavigationBar(BuildContext context, int selectedIndex, String username) {
  return BottomNavigationBar(
    backgroundColor: Colors.black,
    selectedItemColor: Color.fromARGB(255, 2, 69, 177), // Changed selected item color to white
    unselectedItemColor: Colors.black, // Changed unselected item color to white
    currentIndex: selectedIndex,
    onTap: (int index) {
      switch (index) {
        case 0: // Home
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(username: username)),
          );
          break;
        case 1: // Explore
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
