import 'package:path/path.dart';
import 'package:profile_remote_control/user.dart';
import 'package:sqflite/sqflite.dart';

Database? _database;

List wholeDataList = [];

class LocalDatabase {
  Future get database async {
    if (_database != null) return _database;
    _database = await _initializedDB('Local.db');
    return _database;
  }

  Future _initializedDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      Create Table LocalData
        (id Integer Primary Key,
          DummyData JSON Not Null)

      ''');
  }

  Future addDataLocally({wholedata}) async {
    final db = await database;
    await db.insert('LocalData', {'DummyData': wholedata});
    print('$wholedata Added to database succesfully');
    return 'added';
  }

  Future readAllData() async {
    final db = await database;
    final alldata = await db!.query("LocalData");
    wholeDataList = alldata;
    // wholeDataList = User.recipesFromSnapshot(alldata);
    
    print(wholeDataList);
    print('successfully read');
    return wholeDataList;
    //----------------------------------------------------------------------------
    // final List<Map<String, dynamic>> maps = alldata;

    // if (maps.isEmpty) {
    //   return null;
    // }
    // // return maps;
    // return List.generate(maps.length, (index) => User.fromJson(maps[index]));
  }
}
