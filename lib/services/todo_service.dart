import 'package:lister/models/todos.dart';
import 'package:lister/repositories/repository.dart';

class TodoService {
  Repository _repository;

  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository.insertData('todos', todo.todoMap());
  }

  readTodos() async {
    return await _repository.readData('todos');
  }

  readTodosByCategory(category) async {
    return await _repository.readDataByColumn('todos', 'category', category);
  }

  // delete data da table
  deleteTodo(todosId) async {
    return await _repository.deleteData('todos', todosId);
  }
}
