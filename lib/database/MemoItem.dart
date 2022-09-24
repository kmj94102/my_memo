import 'package:my_memo/database/MemoProvider.dart';
import 'package:sqflite/sql.dart';

class MemoItem {
  final int id;
  final String title;
  final String contents;
  final bool isSecret;
  final bool isImportance;
  final String? password;
  final int timestamp;
  final int colorGroup;

  MemoItem(
      {this.id = 0,
      this.title = "",
      this.contents = "",
      this.isSecret = false,
      this.isImportance = false,
      this.password,
      this.timestamp = 0,
      this.colorGroup = 0});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'contents': contents,
      'isSecret': isSecret,
      'isImportance': isImportance,
      'password': password,
      'timestamp': timestamp,
      'colorGroup': colorGroup,
    };
  }
}

class MemoItemModify {
  int id;
  String title;
  String contents;
  bool isSecret;
  bool isImportance;
  String? password;
  int timestamp;
  int colorGroup;

  MemoItemModify(
      {this.id = 0,
      this.title = "",
      this.contents = "",
      this.isSecret = false,
      this.isImportance = false,
      this.password,
      this.timestamp = 0,
      this.colorGroup = 0});

  mapper() {
    return MemoItem(
        id: id,
      title: title,
      contents: contents,
      isSecret: isSecret,
      isImportance: isImportance,
      password: password,
      timestamp: timestamp,
      colorGroup: colorGroup
    );
  }
}

Future<List<MemoItem>> getDB() async {
  final db = await MemoProvider().database;
  final List<Map<String, dynamic>> maps = await db!.query("MEMO");
  if (maps.isEmpty) return [];
  List<MemoItem> list = List.generate(maps.length, (index) {
    return MemoItem(
      id: maps[index]["id"],
      title: maps[index]["title"],
      contents: maps[index]["contents"],
      isSecret: maps[index]["isSecret"],
      isImportance: maps[index]["isImportance"],
      password: maps[index]["password"],
      timestamp: maps[index]["timestamp"],
      colorGroup: maps[index]["colorGroup"],
    );
  });
  return list;
}

Future<void> insert(MemoItem item) async {
  final db = await MemoProvider().database;
  await db?.insert("Memo", item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}