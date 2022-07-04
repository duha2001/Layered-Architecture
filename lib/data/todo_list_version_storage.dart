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

    }catch(e){
      return [];
    }
  }
  Future<File> get _localFile async{
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/todoListVersionList.json');
  }
}