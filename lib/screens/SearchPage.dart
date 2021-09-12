import 'package:flutter/material.dart';
import 'package:freshsify/providers/products.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchKey = TextEditingController();
  var onClickHandler = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.search_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: TextField(
                        onSubmitted: (String sd) async {
                          await Provider.of<Products>(context, listen: false)
                              .searchProduct(searchKey.text);
                          Navigator.of(context).pushNamed('/searchResult');
                        },
                        onTap: () {
                          setState(() {
                            onClickHandler = true;
                          });
                        },
                        controller: searchKey,
                        decoration: InputDecoration.collapsed(
                          hintText: "Search Products...",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cancel),
                    ),
                  ],
                ),
              ),
              onClickHandler
                  ? TextButton(
                      onPressed: () async {
                        await Provider.of<Products>(context, listen: false)
                            .searchProduct(searchKey.text);
                        Navigator.of(context).pushNamed('/searchResult');
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    )
                  : TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Recent Searches',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Product name'),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.grey,
                      ),
                    ],
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
