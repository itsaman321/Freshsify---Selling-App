import 'package:flutter/material.dart';
import 'package:freshsify/providers/products.dart';
import 'package:freshsify/widgets/recent_search__item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchKey = TextEditingController();
  List searchList = [];
  var onClickHandler = false;
  var isLoading = true;

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('searchList') == null) {
    } else {
      searchList = json.decode(prefs.getString('searchList').toString());
    }
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(searchList);
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
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ],
                ),
              ),
              onClickHandler
                  ? TextButton(
                      onPressed: () async {
                        await Provider.of<Products>(context, listen: false)
                            .searchProduct(searchKey.text);
                        setState(() {});
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
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (ctx, index) {
                        return RecentItem(
                          title: searchList[index].toString(),
                        );
                      },
                      itemCount: searchList.length,
                    ))
        ],
      ),
    );
  }
}
