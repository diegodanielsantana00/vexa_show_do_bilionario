// ignore_for_file: file_names, avoid_init_to_null, unused_local_variable, argument_type_not_assignable_to_error_handler, non_constant_identifier_names

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vexa_show_do_bilionario/Areas/Home/Models/User.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  DatabaseHelper._crateInstance();

  factory DatabaseHelper() => _databaseHelper ??= DatabaseHelper._crateInstance();

  Future<Database> get database async => _database ??= await initializeDatabase();

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = "${dir.path}kdi2rf_392kdi.db";
    var exercisesDatabase = await openDatabase(path, version: 1, onCreate: _createDatabase);

    return exercisesDatabase;
  }

  void _createDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE user(id INTEGER primary key autoincrement, qtd_play BIGINT, money BIGINT, token_premium TEXT, pix_date STRING, pix_qrcode TEXT, paymentID TEXT, email TEXT);");
  }

  Future<int> insertDatabase(String table, dynamic object, {Database? database2}) async {
    var result = null;
    if (database2 == null) {
      Database db = await database;
      result = db.insert(table, object.toMap());
    } else {
      result = database2.insert(table, object.toMap());
    }
    return result;
  }

  Future<void> executeStringLocal(String sql) async {
    Database db = await database;
    dynamic result;
    if (sql.toLowerCase().contains("delete")) {
      result = await db.rawDelete(sql);
    } else if (sql.toLowerCase().contains("insert")) {
      result = await db.rawInsert(sql);
    } else {
      await db.execute(sql);
    }
  }

  Future<void> UpdateFimPartida(int money) async {
    executeStringLocal("UPDATE user SET qtd_play = qtd_play+1, money = money+$money");
  }

  Future<List<User>> getUser() async {
    Database db = await database;
    var result = await db.query("user");
    return result.isNotEmpty ? result.map((c) => User.fromMap(c)).toList() : [];
  }

  // Future<List<History>> getHistory() async {
  //   Database db = await database;
  //   var result = await db.query("history", limit: 100);
  //   List<History> listAux =  result.isNotEmpty ? result.map((c) => History.fromMap(c)).toList() : [];
  //   listAux.sort((a, b) => (b.id??0).compareTo(a.id??0));
  //   return listAux;
  // }

  // Future<List<History>> getHistoryID(int id_lottery) async {
  //   Database db = await database;
  //   var result = await db.query("history", limit: 100, where: "lotery = $id_lottery");
  //   List<History> listAux =  result.isNotEmpty ? result.map((c) => History.fromMap(c)).toList() : [];
  //   listAux.sort((a, b) => (b.id??0).compareTo(a.id??0));
  //   return listAux;
  // }

  // Future<int?> getQtdRoll() async {
  //   Database db = await database;
  //   var result = await db.query("user");
  //   return User.fromMap(result.first).qtd_roll;
  // }

  // Future<String?> getTokenVip() async {
  //   Database db = await database;
  //   var result = await db.query("user");
  //   return User.fromMap(result.first).token_premium;
  // }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
