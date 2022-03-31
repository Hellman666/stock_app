import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stock_sim/models/sqlite_model.dart';

class DatabaseHelper {
  static const _databaseName = "storage8.db";
  static const _databaseVersion = 1;

  static const table = 'storage';
  static const table2 = 'history';
  static const table3 = 'favourite';
  static const table4 = 'trades';

  static const columnId = 'id';
  static const columnBalance = 'balance';
  static const columnProfit = 'profit';

  static const historyId = 'id';
  static const historyProfit = 'price';
  static const historySymbol = 'symbol';
  static const historyName = 'name';

  static const favouriteId = 'id';
  static const favouriteSymbol = 'symbol';
  static const favouriteName = 'name';

  static const orderId = 'id';
  static const buyPrice = 'buyPrice';
  static const orderSymbol = 'symbol';
  static const orderName = 'name';

  DatabaseHelper() : super();

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnBalance INTEGER NOT NULL,
        $columnProfit INTEGER NOT NULL
      )
      '''
    );

    await db.execute(
        '''
      CREATE TABLE $table2 (
        $historyId INTEGER PRIMARY KEY AUTOINCREMENT,
        $historySymbol TEXT,
        $historyName TEXT,
        $historyProfit INTEGER
      )
      '''
    );

    await db.execute(
        '''
      CREATE TABLE $table3 (
        $favouriteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $favouriteSymbol TEXT,
        $favouriteName TEXT
      )
      '''
    );

    await db.execute(
        '''
      CREATE TABLE $table4 (
        $orderId INTEGER PRIMARY KEY AUTOINCREMENT,
        $buyPrice INTEGER,
        $orderSymbol TEXT,
        $orderName TEXT
      )
      '''
    );
  }

  static Future<void> insertUserRow() async {
    User _user = User(id: 1, balance: 10000, profit: 0);
    final db = await instance.database;
    await db!.insert(
      table,
      _user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getBalance() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table);
    print(res);
    //print(res.runtimeType);
    return res;
  }

  static Future<List<Map<String, dynamic>>> getProfit() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table);
    print(res);
    //print(res.runtimeType);
    return res;
  }

  static Future<int> updateBalance(User user) async {
    Database? db = await instance.database;
    int? id = user.toMap()['id'] as int?;
    return await db!.update(
        table, user.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  static Future<void> insertTrades(String symbol, int price,
      String name) async {
    Order _order = Order(buyPrice: price, symbol: symbol, name: name);
    final db = await instance.database;
    await db!.insert(
      table4,
      _order.toMap(),
    );
  }

  static Future<List<Map<String, dynamic>>> getTrades() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table4);
    //print(res);
    return res;
  }

  Future<List<Order>> getTradesSell() async {
    Database? db = await instance.database;
    var trades = await db!.query(table4, orderBy: 'id');
    List<Order> orderList = trades.isNotEmpty
        ? trades.map((c) => Order.fromMap(c)).toList()
        : [];
    return orderList;
  }

  static Future<int> sellTrades(int? id) async {
    Database? db = await instance.database;
    return await db!.delete(table4, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertFavourite(String symbol, String name) async {
    Favourite _favourite = Favourite(symbol: symbol, name: name);
    final db = await instance.database;
    await db!.insert(
      table3,
      _favourite.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getFavourite() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table3);
    //print(res);
    return res;
  }

  static Future<int> removeFavourite(int? id) async {
    Database? db = await instance.database;
    return await db!.delete(table3, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertHistory(String symbol, String name, int profit) async {
    History _history = History(symbol: symbol, name: name, price: profit);
    final db = await instance.database;
    await db!.insert(
      table2,
      _history.toMap(),
    );
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table2);
    print(res);
    return res;
  }
}