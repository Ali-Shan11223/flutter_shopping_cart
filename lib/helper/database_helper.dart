import 'package:provider_shopping_cart/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  // Creating database var
  static Database? _database;

  // Checking if database is already exists or not.
  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    return _database = await initDatabase();
  }

  // Opening a database
  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var database = openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  // Querying sql commands
  _onCreate(Database database, int version) async {
    await database.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE, productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, unitTag TEXT, image TEXT)');
  }

  // Inserting data in database through CartModel
  Future<CartModel> insert(CartModel cartModel) async {
    var dbClient = await database;
    await dbClient!.insert('cart', cartModel.toMap());
    return cartModel;
  }

  // Fetching data from database
  Future<List<CartModel>> getCart() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => CartModel.fromMap(e)).toList();
  }

  // Deleting data from database
  Future<int> delete(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  // Updating
  Future<int> update(CartModel cartModel) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cartModel.toMap(),
        where: 'id = ?', whereArgs: [cartModel.id]);
  }
}
