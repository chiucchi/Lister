import 'package:flutter/material.dart';
import 'package:lister/models/todos.dart';
import 'package:lister/screens/mainPage.dart';
import 'package:lister/services/category_services.dart';
import 'package:lister/services/todo_service.dart';

class ToDo extends StatefulWidget {
  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  var todoTitleController = new TextEditingController();
  var todoDescriptionController = new TextEditingController();
  var _selectedValue;
  var _categories = List<DropdownMenuItem>();

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategories();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("LISTER", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[900],
      ),
      body: Container(
        margin: EdgeInsets.only(left: 24.0, right: 24.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: todoTitleController,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: 'Write the task title',
              ),
            ),
            TextField(
              controller: todoDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Write the task description',
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: DropdownButton(
                  items: _categories,
                  value: _selectedValue,
                  hint: Text('Category'),
                  onChanged: (value) {
                    setState(() {
                      _selectedValue = value;
                    });
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              width: 330.0,
              height: 50.0,
              child: RaisedButton(
                color: Colors.purple[900],
                onPressed: () async {
                  var todoObject = Todo();
                  todoObject.title = todoTitleController.text;
                  todoObject.description = todoDescriptionController.text;
                  todoObject.category = _selectedValue.toString();
                  todoObject.isFinished = 0;

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);
                  if (result > 0) {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  }
                },
                child: Text('Save', style: TextStyle(color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
