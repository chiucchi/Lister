import 'package:flutter/material.dart';
import 'package:lister/helpers/drawerNavigation.dart';
import 'package:lister/models/todos.dart';
import 'package:lister/screens/todo.dart';
import 'package:lister/services/todo_service.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TodoService _todoService;
  List<Todo> _todoList = List<Todo>();
  var _edittodoNameController = TextEditingController();
  var _edittodoDescriptionController = TextEditingController();
  var _todo = Todo();
  var todo;

  @override
  initState() {
    super.initState();
    getAllTodos();
  }

  getAllTodos() async {
    _todoService = TodoService();
    _todoList = List<Todo>();

    var todos = await _todoService.readTodos();

    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.isFinished = todo['isFinished'];
        model.userid = todo['userid'];
        _todoList.add(model);
      });
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
                  var result = await _todoService.deleteTodo(categoryId);
                  if (result > 0) {
                    Navigator.pop(context);
                    getAllTodos();
                  }
                },
                child:
                    Text('Delete', style: TextStyle(color: Colors.purple[900])),
              ),
            ],
            title: Text('Delete Task?'),
          );
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
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_todoList[index].title),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteFormDialog(context, _todoList[index].id);
                        },
                      ),
                    ],
                  ),
                  subtitle: Text(_todoList[index].description),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ToDo()),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
