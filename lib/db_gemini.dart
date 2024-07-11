// import 'dart:async';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:profile_remote_control/user.dart'; // Assuming user.dart is in the same directory

// class MyDB {
//   static final MyDB _instance = MyDB._internal();
//   factory MyDB() => _instance;

//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await _initDb();
//     }
//     return _db;
//   }

//   MyDB._internal();

//   Future<Database> _initDb() async {
//     final databasesPath = await getDatabasesPath();
//     final path = '$databasesPath/my_users.db';

//     // Create the database if it doesn't exist
//     final db = await openDatabase(path, version: 1, onCreate: (db, version) {
//       db.execute('''
//         CREATE TABLE Users (
//           id INTEGER PRIMARY KEY AUTOINCREMENT,
//           utitle TEXT NOT NULL,
//           ubody TEXT NOT NULL
//         )
//       ''');
//     });
//     return db;
//   }

//   // CRUD operations

//   // Create
//   Future<User> createUser(User user) async {
//     final db = await this.db;
//     final id = await db?.insert('Users', user.toMap());
//     return user.copyWith(id: id); // Update user with generated ID
//   }

//   // Read
//   Future<List<User>> getAllUsers() async {
//     final db = await this.db;
//     final maps = await db.query('Users');
//     return List.generate(maps.length, (i) => User.fromMap(maps[i]));
//   }

//   // Update
//   Future<int> updateUser(User user) async {
//     final db = await this.db;
//     return await db.update('Users', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
//   }

//   // Delete
//   Future<int> deleteUser(int id) async {
//     final db = await this.db;
//     return await db.delete('Users', where: 'id = ?', whereArgs: [id]);
//   }
// }

// // Helper extension to convert User object to Map
// extension UserToMap on User {
//   Map<String, dynamic> toMap() => {
//         'utitle': utitle,
//         'ubody': ubody,
//       };
// }
