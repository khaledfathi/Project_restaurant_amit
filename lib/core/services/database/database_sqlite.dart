import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import './interface/database_core_interface.dart'; 
import '../../constants/database_const.dart';

class DatabaseSqlite implements DatabaseCoreInterface<DatabaseSqlite>{

  static DatabaseSqlite appDatabase = DatabaseSqlite(); 

  Database? _db;
  String _tableName = '';
  int _version = 1;

  Future<Database> _connect() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);
    Database currentDB =
        await openDatabase(path, onCreate: _onCreate, version: _version);
    return currentDB;
  }

  Future<void> _onCreate(Database db, int version) async {
    try {      
      for (String table in SCHEMA) {
        await db.execute(table);
      }
      debugPrint("DatabaseSqlite : build database [ok]");
    } catch (e) {
      debugPrint('DatabaseSqlite : ${e.toString()}');
    }
  }

  Future<void> _disconnect() async {
    if (_db != null) {
      await _db!.close();
      _db = null ; 
    }
  }

  @override
  Future<void> initDB() async {
    _db = _db == null ? await _connect() : null;
  }

  Future<void> _dropDatabase() async {
    try {
      await databaseFactory
          .deleteDatabase(join(await getDatabasesPath(),DATABASE_NAME));
      debugPrint("DatabaseSqlite: Drop Database : [ok]");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<void> recreateDatabase() async {
    await _dropDatabase();
    await _disconnect();
    await initDB();
  }

  @override
  DatabaseSqlite table(String table) {
    _tableName = table;
    return this;
  }

  @override
  Future<List<Map<String, Object?>>> select({int? id}) {
    if (id == null) {
      return _db!.query(_tableName);
    } else {
      return _db!.query(_tableName, where: 'id = ?' , whereArgs: [id]);
    }
  }

  @override
  Future<List<Map<String, Object?>>> selectWhere(String where , List<Object?> whereArgs) {
    return _db!.query(_tableName, where: where , whereArgs: whereArgs);
  }

  @override
  Future<int> insert(Map<String, Object?> row) async {
    return _db!.insert(_tableName, row);
  }

  @override
  Future<int> update(Map<String, Object?> row, int id) async {
    return _db!.update(_tableName, row, where: 'id=?' , whereArgs: [id]);
  }

  @override
  Future<int> updateWhere(Map<String, Object?> row, String where, List<Object?> whereArgs) {
    return _db!.update(_tableName, row, where: where , whereArgs: whereArgs);
  }

  @override
  Future<int> delete({int? id}) async {
    if (id == null) {
      return _db!.delete(_tableName);
    }
    return _db!.delete(_tableName, where: 'id = ?' , whereArgs: [id]);
  }
  
  @override
  Future<int> deleteWhere(String where, List<Object?> whereArgs) {
    return _db!.delete(_tableName, where: where , whereArgs: whereArgs);
  }
  
  
}
