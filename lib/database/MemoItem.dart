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
        colorGroup: colorGroup);
  }
}

//    @Insert(onConflict = OnConflictStrategy.REPLACE)
//     suspend fun insertMemoItem(memoEntity: MemoEntity): Long
// 
//     @Query("SELECT * FROM MemoEntity WHERE `title` LIKE :search")
//     fun selectAllMemo(search : String): Flow<List<MemoEntity>>
// 
//     @Query("SELECT * FROM MemoEntity WHERE `index` = :index")
//     fun selectMemoIndex(index: Long): Flow<MemoEntity>
// 
//     @Query("DELETE FROM MemoEntity WHERE `index` = :index")
//     suspend fun deleteMemoIndex(index: Long)
// 
//     @Query("UPDATE  MemoEntity SET `isImportance` = :isImportance WHERE `index` = :index")
//     suspend fun updateImportance(index: Long, isImportance: Boolean): Int

Future<List<MemoItem>> getMemoList() async {
  final db = await MemoProvider().database;
  final List<Map<String, dynamic>> maps = await db!.query("Memo");
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

Future<void> insert(MemoItem item) async {
  final db = await MemoProvider().database;
  await db?.insert("Memo", item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}