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
    Cart(),
    ProfilePage(),
    ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        unselectedIconTheme: IconThemeData(color: Colors.black26),
        selectedIconTheme: IconThemeData(
          color: Color.fromRGBO(249, 100, 0, 1),
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 30,
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            title: Text(''),
          ),
        ],
      ),
      body: widgets[_selectedIndex],
    );
  }
}
