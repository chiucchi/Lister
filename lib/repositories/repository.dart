import 'package:lister/repositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
  }

  insertData(table, data) async {
    var connection = await database;
    return await connection.insert(table, data);
  }

  readData(table) async {
    var connection = await database;
    return await connection.query(table);
  }

  readDataById(table, itemId) async {
    var connection = await database;
    return await connection.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  readDataByUser(table, username, password) async {
    var connection = await database;
    return await connection
        .query(table, where: 'username=?', whereArgs: [username]);
  }

  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?', whereArgs: [data['id']]);
    ;
  }

  deleteData(table, itemId) async {
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  readDataByColumn(table, columnName, columnValue) async {
    var connection = await database;
    return await connection
        .query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }

  readUserId(table, user_name) async {
    var connection = await database;
    return await connection
        .rawQuery("SELECT * FROM $table WHERE username = '$user_name'");
  }
}
