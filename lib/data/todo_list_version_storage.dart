import 'dart:convert';
import 'dart:io';

import 'package:layered_architecture/data/models/todo.model.dart';
import 'package:layered_architecture/data/models/todo_list_version.model.dart';
import 'package:path_provider/path_provider.dart';

// Khai báo lớp trừu trượng TodoListVersionStorage

abstract class TodoListVersionStorage{
  Future<List<TodoListVersion>> readVersionList();

  Future<void> saveVersion(List<Todo> todoList);
}

class FileSystemTodoListVersionStorage extends TodoListVersionStorage{
  @override
  Future<List<TodoListVersion>> readVersionList() async {
    try {
      final file = await _localFile;
      final content = await file.readAsString();
      final List<dynamic> jsonArray = jsonDecode(content);
      return jsonArray.map((jsonObject) => TodoListVersion.fromJson(jsonObject),).toList();
    }catch(e){
      return [];
    }
  }
  Future<File> get _localFile async{
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/todoListVersionList.json');
  }

  @override
  Future<void> saveVersion(List<Todo> todoList) async {
    final lastestTodoListVersionList = await readVersionList();
    lastestTodoListVersionList.add(TodoListVersion(createdAt: DateTime.now().millisecondsSinceEpoch, todos: todoList));
    try{
      final file = await _localFile;
      final jsonArray = lastestTodoListVersionList.map((e)=> e.toJson(),).toList();
      await file.writeAsString(jsonEncode(jsonArray));
    }catch (e){
      return;
    }
  }
}