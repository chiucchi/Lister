import 'package:flutter/material.dart';
import 'package:lister/main.dart';
import 'package:lister/models/user.dart';
import 'package:lister/screens/categories.dart';
import 'package:lister/screens/mainPage.dart';
import 'package:lister/screens/todos_by_category.dart';
import 'package:lister/services/category_services.dart';

class DrawerNavigation extends StatefulWidget {
  User userObject;

  DrawerNavigation({userObject});

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState(userObject);
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  List<Widget> _categoryList = List<Widget>();
  CategoryService _categoryService = CategoryService();

  User userObject;
  _DrawerNavigationState(this.userObject);

  @override
  initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
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
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()),
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
