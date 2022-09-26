import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'MemoItem.dart';

class MemoProvider {
  late Database _database;
  static const String memoTableName = "Memo";

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

  Future<void> insert(MemoItem item) async {
    final db = await database;
    await db!.insert(memoTableName, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<MemoItem>> getMemoList(MemoListSearch condition, String keyword) async {
    var where = "title LIKE ?";
    switch(condition) {
      case MemoListSearch.searchImportance:
        where += "AND isImportance == 1";
        break;
      case MemoListSearch.searchSecret:
        where += "AND isSecret == 1";
        break;
      default:
        break;
    }
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(memoTableName,
        where: where,
        whereArgs: ['%$keyword%'],
      orderBy: condition == MemoListSearch.searchDate ? "timestamp DESC" : "id"
    );
    if (maps.isEmpty) return [];
    List<MemoItem> list = maps.isNotEmpty
        ? maps
        .map((item) => MemoItem(
      id: item["id"],
      title: item["title"],
      contents: item["contents"],
      isSecret: item["isSecret"] == 1,
      isImportance: item["isImportance"] == 1,
      password: item["password"],
      timestamp: item["timestamp"],
      colorGroup: item["colorGroup"],
    ))
        .toList()
        : [];
    return list;
  }

  Future<MemoItem?> getMemoItem({required int id}) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db!.query(memoTableName, where: "id = ?", whereArgs: [id]);

    if(result.isEmpty) {
      return null;
    } else {
      var item = result.first;
      return MemoItem(
        id: item["id"],
        title: item["title"],
        contents: item["contents"],
        isSecret: item["isSecret"] == 1,
        isImportance: item["isImportance"] == 1,
        password: item["password"],
        timestamp: item["timestamp"],
        colorGroup: item["colorGroup"],
      );
    }
  }

  Future<void> updateImportance({required int id, required bool value}) async {
    final db = await database;
    var result = await db!.update(memoTableName, {'isImportance': value ? 1 : 0,}, where: "id = ?", whereArgs: [id]);
    print("$result");
  }

  Future<int> deleteMemo({required int id}) async {
    final db = await database;

    var result = await db!.delete(memoTableName, where: "id = ?", whereArgs: [id]);

    return result;
  }

}

enum MemoListSearch {
  searchDefault,
  searchDate,
  searchImportance,
  searchSecret;
}