import 'package:bloc_api/authentication/models/database.dart';
import 'package:bloc_api/database/fields.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseMethods {
  static final DatabaseMethods instance = DatabaseMethods._init();

  static Database? _database;

  DatabaseMethods._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('data.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE "data" (
	"timeDate"	TEXT,
	"nitrogen"	REAL,
	"phosphorus"	REAL,
	"potassium"	REAL,
	"soilMoisture"	REAL,
	"timeDateList"	TEXT,
	"id"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
''');
  }

  Future<MyDatabase> create(MyDatabase myDatabase) async {
    final db = await instance.database;
    final id = await db.insert('data', myDatabase.toJson());
    return myDatabase.copy(id: id);
  }

  Future<MyDatabase?> read(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'data',
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MyDatabase.fromJson(maps.first);
    } else {
      throw Exception("ID $id not found");
    }
  }

  Future<List<MyDatabase>> readAllNotes() async {
    final db = await instance.database;
    final list = await db.query('data', orderBy: '${NoteFields.timeDate} DSC');
    return list.map((e) => MyDatabase.fromJson(e)).toList();
  }

  Future<int> updateNote(MyDatabase database) async {
    final db = await instance.database;
    return await db.update(
      'data',
      database.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [database.id],
    );
  }

  //function to get the last input into the database
  Future<MyDatabase> readLast() async {
    final db = await instance.database;
    final maps = await db.query(
      'data',
      columns: NoteFields.values,
      orderBy: '${NoteFields.id} DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return MyDatabase.fromJson(maps.first);
    } else {
      return MyDatabase(timeDateList: [DateTime(2021, 1, 1)]);
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  String join(String dbPath, String filePath) {
    return dbPath + filePath;
  }
}
