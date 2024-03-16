import 'package:e_commerce_makeup/features/home/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ratings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE ratings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  productId TEXT NOT NULL,
  userId TEXT NOT NULL,
  rating REAL NOT NULL
);
''');
  }

  Future<void> addOrUpdateRating(String productId, String userId, double rating) async {
    final db = await instance.database;
    var existingRating = await db.query(
      'ratings',
      where: 'productId = ? AND userId = ?',
      whereArgs: [productId, userId],
    );

    if (existingRating.isNotEmpty) {
      // Update existing rating
      await db.update(
        'ratings',
        {'rating': rating},
        where: 'productId = ? AND userId = ?',
        whereArgs: [productId, userId],
      );
    } else {
      // Insert new rating
      await db.insert('ratings', {
        'productId': productId,
        'userId': userId,
        'rating': rating,
      });
    }
  }

  Future<double> fetchAverageRating(String productId) async {
    final db = await instance.database;
    var result = await db.rawQuery('''
SELECT AVG(rating) as averageRating FROM ratings WHERE productId = ?
''', [productId]);

    if (result.first['averageRating'] != null) {
      return result.first['averageRating'] as double;
    }
    return 0.0; // Default to 0 if no ratings
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}