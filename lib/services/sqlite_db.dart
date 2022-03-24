import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:stock_sim/models/sqlite_model.dart';

class DatabaseHelper{
  static const _databaseName = "storage1.db";
  static const _databaseVersion = 3;

  static const table = 'storage';
  static const table2 = 'history';
  static const table3 = 'favourite';

  static const columnId = 'id';
  static const columnBalance ='balance';
  static const columnProfit = 'profit';

  static const historyId = 'id';
  static const historyPrice = 'price';
  static const historySymbol = 'symbol';
  static const historyName = 'name';

  static const favouriteId = 'id';
  static const favouriteSymbol = 'symbol';
  static const favouriteName = 'name';


  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async{
    if(_database != null) return _database;

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
      CREATE TABLE IF NOT EXISTS $table(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnBalance INTEGER NOT NULL,
        $columnProfit INTEGER NOT NULL
      )
      '''
      );

    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $table2(
        $historyId INTEGER PRIMARY KEY AUTOINCREMENT,
        $historySymbol TEXT NOT NULL,
        $historyName TEXT NOT NULL,
        $historyPrice INTEGER NOT NULL
      )
      '''
    );

    await db.execute(
      '''
      CREATE TABLE IF NOT EXISTS $table3(
        $favouriteId INTEGER PRIMARY KEY AUTOINCREMENT,
        $favouriteSymbol TEXT NOT NULL,
        $favouriteName TEXT NOT NULL
      )
      '''
    );
  }

  static Future<void> insertUserRow() async {
    User _user = User(1, 50000, 0);
    final db = await instance.database;
    await db!.insert(
      table,
      _user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getBalance() async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table);
    print(res);
   //print(res.runtimeType);
    return res;
  }

  static Future<List<Map<String, dynamic>>> getProfit() async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table);
    print(res);
    //print(res.runtimeType);
    return res;
  }

  static Future<void> insertHistoryRow() async {
    History _history = History(id: 1, symbol: 'AAPL', name: 'Apple', price: 120);
    final db = await instance.database;
    await db!.insert(
      table2,
      _history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> getHistory() async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table2);
    print(res);
    //print(res.runtimeType);
    return res;
  }

  static Future<void> insertFavourite() async {
    Favourite _favourite = Favourite(id: 1, symbol: 'GOOG', name: 'Google');
    final db = await instance.database;
    await db!.insert(
        table3,
        _favourite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> getFavourite() async{
    Database? db = await instance.database;
    List<Map<String, dynamic>> res = await db!.query(table3);
    print(res);
    print(res.runtimeType);
    return res;
    //return res.map((e) => Favourite.fromMap(e)).toList();
  }

  static Future<void> deleteFavourite(int id) async{
    Database? db = await instance.database;
    await db?.delete(
      table3,
      where: "id = ?",
      whereArgs: [id],
    );
  }
}


/*class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'storage.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE user (
        balance INTEGER NOT NULL,
        profit INTEGER NOT NULL
      );
    ''');
  }

  Future<List<User>> getUser() async{
    Database db = await instance.database;
    var user = await db.query('storage', orderBy: 'balance');
    List<User> userList = user.isNotEmpty
        ? user.map((c) => User.fromMap(c)).toList()
        : [];
    return userList;
  }

  newUser(newUser) async{
    final db = await database;

    var res = await db.rawInsert(
        '''
      INSERT INTO user(balance, profit) VALUES (10000, 0)
      ''', [newUser.balance, newUser.profit]);
    return res;
  }

  Future<int> add(User user) async{
    Database db = await instance.database;
    return await db.insert('storage', user.toMap());
  }
}*/

/*class DatabaseHelper{
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();
  DatabaseHelper._();
  static Database _database;

  factory DatabaseHelper(){
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'storage.db'),
      onCreate: (db, version) async {
        await db.execute(
          """
          CREATE TABLE user (
              balance INTEGER NOT NULL,
              profit INTEGER NOT NULL,
              fav_symbol TEXT,
              fav_name TEXT,
              history_symbol TEXT,
              history_name TEXT,
              history_price INTEGER
            )
          """
        );
      },
      version: 1,
    );
  }

  newUser(newUser) async{
    final db = await database;

    var res = await db.rawInsert(
      '''
      INSERT INTO user(balance, profit) VALUES (10000, 0)
      ''', [newUser.balance, newUser.profit]);
    return res;
  }

  Future<dynamic> getUser() async {
    final db = await database;
    var res = await db.query("user");
    if(res.length == 0){
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }

}
*/

/*class DatabaseHelper{
  static final DatabaseHelper _databaseHelper = DatabaseHelper._();

  DatabaseHelper._();

  late Database db;

  var opendb = openDatabase('storage.db');

  factory DatabaseHelper(){
    return _databaseHelper;
  }

  Future<void> initDB() async {
    String path = await getDatabasesPath();
    db = await openDatabase(
      join(path, 'storage.db'),
      onCreate: (Database opendb, version) async {
        await opendb.execute(
          """
            CREATE TABLE user (
              balance INTEGER NOT NULL,
              profit INTEGER NOT NULL
            );
            CREATE TABLE favourite(
              symbol TEXT NOT NULL,
              name TEXT NOT NULL
            );
            CREATE TABLE history (
              symbol TEXT NOT NULL,
              name TEXT NOT NULL,
              price INTEGER NOT NULL
            );
          """,
        );
      },
      version: 1,
    );

    await db.transaction((txn) async {
      int id1 = await txn.rawInsert('INSERT INTO user(balance, profit) VALUES(10000, 0)');
      print(id1);
    });
  }

  Future<int> insertFavourite(Favourite favourite) async {
    int result = await db.insert('favourite', favourite.toMap());
    return result;
  }

  Future<int> updateFavourite(Favourite favourite) async {
    int result = await db.update('favourite', favourite.toMap());
    return result;
  }

  Future<int> deleteFavourite(Favourite favourite) async {
    int result = await db.delete('favourite', where: 'symbol = ?', whereArgs: ['item']);
    return result;
  }
  //TODO: finish delete favourite

  Future<int> insertHistory(History history) async {
    int result = await db.insert('history', history.toMap());
    return result;
  }

  Future<int> updateHistory(History history) async {
    int result = await db.update('history', history.toMap());
    return result;
  }

  Future<int> insertUser(User user) async {
    int result = await db.insert('user', user.toMap());
    return result;
  }

  Future<int> updateUser(User user) async {
    int result = await db.update('user', user.toMap());
    return result;
  }

}
*/


/*class DatabaseHelper{
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'history.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async{
    await db.execute('''
      CREATE TABLE history(
        id INTEGER PRIMARY KEY,
        name TEXT
      )
    ''');
  }

  Future<List<History>> getHistory() async{
    Database db = await instance.database;
    var history = await db.query('history', orderBy: 'name');
    List<History> historyList = history.isNotEmpty
        ? history.map((c) => History.fromMap(c)).toList()
        : [];
    return historyList;
  }

  Future<int> add(History history) async{
    Database db = await instance.database;
    return await db.insert('history', history.toMap());
  }
}*/