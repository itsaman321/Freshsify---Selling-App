import 'package:flutter/material.dart';
import 'package:freshsify/widgets/sub_category_item.dart';
import '../providers/category.dart';
import 'package:provider/provider.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  var catDetails;
  List subcat = [];
  var isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      isLoading = true;
    });
    catDetails = ModalRoute.of(context)!.settings.arguments;
    Future.delayed(Duration(seconds: 0), () async {
      await Provider.of<CategoryProvider>(context, listen: false)
          .getSubCategory(catDetails['id']);
    });

    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    subcat = Provider.of<CategoryProvider>(context).subcategories;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(catDetails['name']),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Text(
                      'Explore By Sub Categories',
                      style: TextStyle(color: Colors.black,fontSize:18),
                      textAlign: TextAlign.center,
                      
                    ),
                  ),
                  
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: subcat.length,
                    itemBuilder: (ctx, index) {
                      return SubcategoryItem(
                          id: subcat[index].id,
                          categoryId: subcat[index].categoryId,
                          name: subcat[index].name,
                          imageUrl: subcat[index].imageUrl);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
