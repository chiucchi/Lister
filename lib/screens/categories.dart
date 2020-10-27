import 'package:flutter/material.dart';
import 'package:lister/models/category.dart';
import 'package:lister/screens/mainPage.dart';

import '../services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editcategoryNameController = TextEditingController();
  var _editcategoryDescriptionController = TextEditingController();
  var _category = Category();
  var category;
  var _categoryService = CategoryService();
  List<Category> _categoryList = List<Category>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList = List<Category>();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
       // if (category.userid) {}
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        categoryModel.userid = category['userid'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]['name'] ?? 'No name';
      _editcategoryDescriptionController.text =
          category[0]['description'] ?? 'No description';
    });
    _editFormDialog(context);
  }

  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text('Cancel', style: TextStyle(color: Colors.purple[900])),
              ),
              FlatButton(
                onPressed: () async {
                  _category.name = _categoryNameController.text;
                  _category.description = _categoryDescriptionController.text;

                  var result = await _categoryService.saveCategory(_category);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child: Text('Confirm',
                    style: TextStyle(color: Colors.purple[900])),
              ),
            ],
            title: Text('New Category'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      hintText: 'Category name',
                      labelText: 'Category',
                    ),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Category description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text('Cancel', style: TextStyle(color: Colors.purple[900])),
              ),
              FlatButton(
                onPressed: () async {
                  _category.id = category[0]['id'];
                  _category.name = _editcategoryNameController.text;
                  _category.description =
                      _editcategoryDescriptionController.text;

                  var result = await _categoryService.updateCategory(_category);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child:
                    Text('Edit', style: TextStyle(color: Colors.purple[900])),
              ),
            ],
            title: Text('Edit Category'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editcategoryNameController,
                    decoration: InputDecoration(
                      hintText: 'Category name',
                      labelText: 'Category',
                    ),
                  ),
                  TextField(
                    controller: _editcategoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: 'Category description',
                      labelText: 'Description',
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child:
                    Text('Cancel', style: TextStyle(color: Colors.purple[900])),
              ),
              FlatButton(
                onPressed: () async {
                  var result =
                      await _categoryService.deleteCategory(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllCategories();
                  }
                },
                child:
                    Text('Delete', style: TextStyle(color: Colors.purple[900])),
              ),
            ],
            title: Text('Delete category?'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        title: Text("Categories", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[900],
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _editCategory(context, _categoryList[index].id);
                      }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_categoryList[index].name),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteFormDialog(context, _categoryList[index].id);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(_categoryList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
