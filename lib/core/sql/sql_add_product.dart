import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelperProduct {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 2;
  static const table = "my_table";

  static const columnId = 'id';
  static const columnTitle = 'name';
  static const columnImage = 'imgPath';
  static const columnQuantity = 'price';
  static const columnrating = 'averageRating';

  // Make this a singleton class.
  DatabaseHelperProduct._privateConstructor();
  static final DatabaseHelperProduct instance = DatabaseHelperProduct._privateConstructor();

  // Only have a single app-wide reference to the database.
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  // Open the database and create the table if it doesn't exist.
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnImage TEXT NOT NULL,
            $columnQuantity INTEGER NOT NULL,
            $columnrating REAL NOT NULL
          )
          ''');
  }

  // Helper methods for CRUD operations:
  Future<int> insert(Item myDataModel) async {
    Database db = await database;
    return await db.insert(table, myDataModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Item>> queryAllRows() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    List<Item> list = maps.isNotEmpty ? maps.map((product) => Item.fromJson(product)).toList() : [];
    return list;

  }
  Future<List<Item>> fetchProductsWithRatings() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT p.id, p.name, p.imgPath, p.price, AVG(r.rating) AS averageRating
    FROM ratings p
    LEFT JOIN ratings r ON p.id = r.productId
    GROUP BY p.id
    ORDER BY averageRating DESC;
  ''');

    return List.generate(results.length, (i) {
      return Item(
        id: results[i]['id'],
        name: results[i]['name'],
        imgPath: results[i]['imgPath'],
        price: results[i]['price'],
        averageRating: results[i]['averageRating'] ?? 0.0, // Use a default value if null
      );
    });
  }

  Future<void> clearTable() async {
    Database db = await database;
    await db.delete(table);
  }
  delete(String table,String? where)async{
    Database db = await database;

    Database? mydb =db;
    int response = await mydb.delete(table , where: where);
    return response;
  }

}
