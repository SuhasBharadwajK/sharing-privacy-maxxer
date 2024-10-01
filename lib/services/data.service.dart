import 'dart:async';
import 'dart:developer';

import 'package:clipboard_privacy/models/entity.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataService extends Disposable {
  static String dbName = "monitored_apps_database.db";

  static Map<String, Database> dbMaps = {};

  final String _tablename;
  final String _columnDefs;

  DataService(this._tablename, this._columnDefs);

  Future<Database> get db async {
    if (dbMaps.isEmpty || !dbMaps.containsKey(_tablename) || !(dbMaps[_tablename]?.isOpen ?? true)) {
      var db = await initDb();
      dbMaps[_tablename] = db;
    }

    var db = dbMaps[_tablename];
    if (db == null) {
      throw Exception("Database cannot be null.");
    }

    return db;
  }

  Future<Database> initDb() async {
    var createQuery = _getCreateQuery(_columnDefs);
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, dbName);

    var database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      return db.execute(createQuery);
    });

    return database;
  }

  Future<List<Map<String, dynamic>>> getAll<T extends Entity>() async {
    return await (await db).query(_tablename);
  }

  Future<Map<String, dynamic>?> getEntity<T extends Entity>(int id, List<String> columnsToGet) async {
    var map = await (await db).query(_tablename, columns: columnsToGet, where: "${NameofEntity.fieldId} = ?", whereArgs: [id]);
    if (map.isEmpty) {
      return null;
    }

    return map.first;
  }

  Future<int> insert<T extends Entity>(T entity) async {
    return await (await db).insert(entity.entityName, entity.toJsonMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> delete(int id) async {
    return await (await db).delete(_tablename, where: "${NameofEntity.fieldId} = ?", whereArgs: [id]);
  }

  Future<int> update<T extends Entity>(T entity) async {
    return await (await db).update(_tablename, entity.toJsonMap(), where: "${NameofEntity.fieldId} = ?", whereArgs: [entity.id]);
  }

  String _getCreateQuery(String columnDefs) {
    return "CREATE TABLE ($columnDefs);";
  }

  @override
  FutureOr onDispose() async {
    log("Disposing DataService");
    for (var database in dbMaps.values) {
      if (database.isOpen) {
        await database.close();
      }
    }
  }
}
