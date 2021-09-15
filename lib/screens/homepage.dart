import 'package:flutter/material.dart';
import 'package:freshsify/screens/SearchPage.dart';
import 'package:freshsify/screens/main_home.dart';
import './cart.dart';
import './profile.dart';
import 'history.dart';

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
    SearchPage(),
    CartPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 3
          ? null
          : AppBar(
              elevation: 0,
              title: Text(
                'Order Summary',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
              iconTheme: Theme.of(context).iconTheme,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.home_outlined),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        unselectedIconTheme: IconThemeData(color: Colors.black26),
        selectedIconTheme: IconThemeData(
          color: Color.fromRGBO(249, 100, 0, 1),
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 28,
        selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search),
            icon: Icon(Icons.search_outlined),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.history),
            icon: Icon(Icons.history_outlined),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: widgets[_selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: Theme.of(context).primaryColor,
        focusColor: Theme.of(context).primaryColor.withAlpha(2),
        hoverColor: Colors.orange,
        child: Icon(
          Icons.add_shopping_cart_outlined,
          color: Colors.white,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartPage(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
