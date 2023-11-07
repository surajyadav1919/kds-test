import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


final DatabaseHelper instance = DatabaseHelper._init();

class DatabaseHelper {

  DatabaseHelper._init();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), 'user_database.db');
    _database = await openDatabase(path, version: 1, onCreate: _createDatabase);
    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT,
        title TEXT,
        description TEXT
      )
    ''');
  }
}

// user_model.dart
class User {
  int? id;
  String date;
  String title;
  String description;

  User({
    this.id,
    required this.date,
    required this.title,
    required this.description
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description
    };
  }
}

// database_helper.dart

// Create a new user
Future<int> insertUser(User user) async {
  final db = await instance.database;
  return await db.insert('users', user.toMap());
}

// Read all users
Future<List<User>> getUsers() async {
  final db = await instance.database;
  final List<Map<String, dynamic>> maps = await db.query('users');
  print(maps);
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      date: maps[i]['date'],
      title: maps[i]['title'],
      description: maps[i]['description']
    );
  });
}

// Update a user
Future<int> updateUser(User user) async {
  final db = await instance.database;
  return await db.update(
    'users',
    user.toMap(),
    where: 'id = ?',
    whereArgs: [user.id],
  );
}

// Delete a user
Future<int> deleteUser(int id) async {
  final db = await instance.database;
  return await db.delete(
    'users',
    where: 'id = ?',
    whereArgs: [id],
  );
}
