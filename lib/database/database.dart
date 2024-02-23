import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseClass {
  static final DatabaseClass instance = DatabaseClass._databaseCarrier();
  static Database? _database;

  DatabaseClass._databaseCarrier();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE Users(id INTEGER PRIMARY KEY ,name STRING,number STRING,gender STRING)''');
  }
}
