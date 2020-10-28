import 'package:flutter/material.dart';
import 'package:lister/main.dart';
import 'package:lister/models/category.dart';
import 'package:lister/models/user.dart';
import 'package:lister/screens/categories.dart';
import 'package:lister/screens/mainPage.dart';
import 'package:lister/screens/todos_by_category.dart';
import 'package:lister/services/category_services.dart';

class DrawerNavigation extends StatefulWidget {
  final int _userid;
  DrawerNavigation(this._userid);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategoryService _categoryService = CategoryService();
  int _userid;

  @override
  initState() {
    super.initState();
    getAllCategories();
    _userid = widget._userid;
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.userid = category['userid'];
        if (categoryModel.userid == _userid) {
          _categoryList.add(InkWell(
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => new TodosByCategory(
                          category: category['name'],
                        ))),
            child: ListTile(
              title: Text(category['name']),
            ),
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn.onlinewebfonts.com/svg/img_357118.png')),
              accountName: Text('arrumar'),
              accountEmail: Text('arrumar@uol.com'),
              decoration: BoxDecoration(color: Colors.purple[900]),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage(_userid)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoriesScreen(_userid)),
                );
              },
            ),
            ListTile(
              //  leading: Icon(Icons.logout),
              title: Text('Log out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
