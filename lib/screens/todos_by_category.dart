import 'package:flutter/material.dart';
import 'package:lister/models/todos.dart';
import 'package:lister/services/todo_service.dart';

class TodosByCategory extends StatefulWidget {
  final String category;
  TodosByCategory({this.category});

  @override
  _TodosByCategoryState createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {
  List<Todo> _todoList = List<Todo>();
  TodoService _todoService = TodoService();

  @override
  initState() {
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async {
    var todos = await _todoService.readTodosByCategory(this.widget.category);
    todos.forEach((todo) {
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('LISTER', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple[900],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context,index) {
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    elevation: 8,
                    child: ListTile(
                      title: Text(_todoList[index].title),
                      subtitle: Text(_todoList[index].description),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
