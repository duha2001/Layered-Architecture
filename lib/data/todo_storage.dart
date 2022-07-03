import "dart:convert";
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'models/todo.model.dart';

abstract class TodoStorage{
  Future<List<Todo>> readTodoList();
  Future<void> insertTodo(Todo todo);
  Future<void> saveTodoList(List<Todo> todoList);
}

class FileSystemTodoStorage extends TodoStorage{
  @override
  Future<List<Todo>> readTodoList() async{
    try{
      final file = await _localFile;
      final content = await file.readAsString();
      final List<dynamic> jsonArray = jsonDecode(content);
      return jsonArray.map((jsonObject)=> Todo.fromJson(jsonObject),).toList();
    }catch(e){
      return [];
    }
  }

  Future<File> get _localFile async{
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/todoList.json');
  }

  @override
  Future<void> insertTodo(Todo todo) {
    // TODO: implement insertTodo
    throw UnimplementedError();
  }

  @override
  Future<void> saveTodoList(List<Todo> todoList) {
    // TODO: implement saveTodoList
    throw UnimplementedError();
  }
}