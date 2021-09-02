import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:freshsify/providers/category.dart';
import 'package:freshsify/screens/main_home.dart';
import 'package:freshsify/widgets/category_item.dart';
import 'package:provider/provider.dart';
import './cart.dart';
import './profile.dart';
import './contact.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> widgets = [
    MainHome(),
    CartPage(),
    ContactPage(),
    
    MainHome(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedIconTheme: IconThemeData(color: Colors.black26),
        selectedIconTheme: IconThemeData(
          color: Color.fromRGBO(249, 100, 0, 1),
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 30,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Phone',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: widgets[_selectedIndex],
      ),
    );
  }
}
