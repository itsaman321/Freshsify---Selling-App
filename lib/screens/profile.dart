import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var user;
  Map notLoggedUser = {};
  var isLoading = true;
  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    user = {
      'fullname': 'Hi! User',
      'email': 'null@gmail.com',
      'password': '',
      'phonenumber': '+0000000000',
    };
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') == null) {
      notLoggedUser = {
        'fullname': 'Hi! User',
        'email': 'null@gmail.com',
        'password': '',
        'phonenumber': '+0000000000',
      };
      user = notLoggedUser;
    } else {
      user = json.decode(prefs.getString('user').toString());
    }
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          )
        : Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['fullname'],
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          ),
                          Text(user['email']),
                        ],
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              color: Colors.black38,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Orders'),
                          ],
                        ),
                      ),
                      
                      InkWell(
                        onTap: () async {
                          await Provider.of<Auth>(context, listen: false)
                              .logout();
                          Navigator.of(context).pushNamed('/auth');
                        },
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout,
                                color: Colors.black38,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Logout'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
