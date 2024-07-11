import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:profile_remote_control/models/user.dart';
import 'package:profile_remote_control/models/users.dart';

class DBHelper {
  static Database? _db;
  static const String TABLE = 'users';
  static const String USER_ID = 'userId';
  static const String ID = 'id';
  static const String TITLE = 'title';
  static const String BODY = 'body';
  static const String DB_NAME = 'MBusers.db';

  Future<Database?> get db async {
    if (null != _db) {
      return _db;
    }

    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY, $USER_ID TEXT, $TITLE TEXT, $BODY TEXT)");
  }

  Future<User> save(User user) async {
    var dbClient = await db;
    user.id = await dbClient!.insert(TABLE, user.toJson());
    return user;
  }

  Future<Users> getUsers() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient!.query(TABLE, columns: [ID, USER_ID, TITLE, BODY]);
    Users allUsers = Users();
    List<User> users = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromJson(maps[i]));
      }
    }
    allUsers.users = users;
    return allUsers;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(User user) async {
    var dbClient = await db;
    return await dbClient!
        .update(TABLE, user.toJson(), where: '$ID = ?', whereArgs: [user.id]);
  }

  // Method to Truncate the Table
  Future<int> truncateTable() async {
    var dbClient = await db;
    return await dbClient!.delete(TABLE);
  }

  // Method to Close the Database
  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
