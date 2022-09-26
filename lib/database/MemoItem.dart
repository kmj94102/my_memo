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

  mapper() {
    return MemoItemModify(
      id: id,
      title: title,
      contents: contents,
      isSecret: isSecret,
      isImportance: isImportance,
      timestamp: timestamp,
      colorGroup: colorGroup
    );
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