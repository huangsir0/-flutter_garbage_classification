import 'dart:core';

import 'package:flutter_garbage_classification/bean/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String dbName = "user.db";
final String tableName = "table_user";
final String columnId = "_id";
final String columnPhone = "phone";
final String columnPsw = "password";
final String columnToken = "token";
final String columnNickName = "nickname";

class DatabaseHelper {
  Database db;

  static DatabaseHelper get instance => _getInstnce();

  static DatabaseHelper _instance;

  DatabaseHelper._internal();

  //单例
  static _getInstnce() {
    if (null == _instance) {
      _instance = DatabaseHelper._internal();
    }

    return _instance;
  }

  openSqlite() async {
    //获取数据文件的存储路径
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    //根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY, 
            $columnPhone TEXT, 
            $columnPsw TEXT, 
            $columnNickName TEXT, 
            $columnToken TEXT )
          ''');
    });
  }

  //插入一条数据
  Future<bool> insert(User user) async {
    await this.openSqlite();
    var person = await getUser(user.phone);
    if (person.phone != null) {
      return false;
    }
    await db.insert(tableName, user.toMap());
    return true;
  }

  Future<List<User>> queryAll() async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableName, columns: [
      columnId,
      columnPhone,
      columnPsw,
      columnNickName,
      columnToken
    ]);
    if (maps == null || maps.length == 0) {
      return null;
    }
    List<User> users = [];
    for (int i = 0; i < maps.length; i++) {
      users.add(User.fromMap(maps[i]));
    }
    return users;
  }

  //获取用户
  Future<User> getUser(String phone) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableName,
        columns: [
          columnId,
          columnPhone,
          columnPsw,
          columnNickName,
          columnToken
        ],
        where: '$columnPhone=?',
        whereArgs: [phone]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    }
    return new User();
  }

  // 根据ID删除书籍信息
  Future<int> delete(String phone) async {
    await this.openSqlite();
    return await db
        .delete(tableName, where: '$columnPhone = ?', whereArgs: [phone]);
  }

  //判断当前用户是否在线
  Future<bool> queryIsOnLine(String phone) async {
    await this.openSqlite();
    List<Map> maps = await db.query(tableName,
        columns: [
          columnId,
          columnPhone,
          columnPsw,
          columnNickName,
          columnToken,
        ],
        where: '$columnPhone = ?',
        whereArgs: [columnPhone]);
    if (maps.length > 0 && (maps.first[columnToken] as String).isNotEmpty) {
      return true;
    }
    return false;
  }

  // 更新书籍信息
  Future<int> update(User user) async {
    await this.openSqlite();
    print("更新${user.toMap()}");
    return await db.update(tableName, user.toMap(),
        where: '$columnPhone = ?', whereArgs: [user.phone]);
  }

  // 记得及时关闭数据库，防止内存泄漏
  close() async {
    await db.close();
  }
}
