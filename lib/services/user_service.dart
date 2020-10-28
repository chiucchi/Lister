import 'package:lister/models/user.dart';
import 'package:lister/repositories/repository.dart';

class UserService {
  Repository _repository;

  UserService() {
    _repository = Repository();
  }

  saveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  readUser(username, password) async {
    return await _repository.readDataByUser('users', username, password);
  }

  getUserId(username) async {
    return await _repository.readUserId('users', username);
  }
}
