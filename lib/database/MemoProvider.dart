import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MemoProvider {
  late Database _database;

  Future<Database?> get database async {
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), "flutter_my_memo.db");
    return await openDatabase(
        path,
      version: 1,
      onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE MEMO(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            contents TEXT,
            isSecret BOOLEAN,
            isImportance BOOLEAN,
            password TEXT,
            timestamp INTEGER,
            colorGroup INTEGER
          )
          ''');
      },
      onUpgrade: (db, oldVersion, newVersion){}
    );
  }

}