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

  readTodos() async { // passar o userid
    return await _repository.readData('todos');
  }

  readTodosByCategory(category) async { // passar o userid // melhor passar la no foreach
    return await _repository.readDataByColumn('todos', 'category', category);
  }

  readTodosById(taskId) async {
    return await _repository.readDataById('categories', taskId);
  }

  // delete data da table
  deleteTodo(todosId) async {
    return await _repository.deleteData('todos', todosId);
  }

  updateTodo(Todo todo) async {
    return await _repository.updateData('todos', todo.todoMap());
  }
}
