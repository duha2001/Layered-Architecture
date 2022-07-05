import 'package:layered_architecture/business/models/super_sandbox_todo.model.dart';
import 'package:layered_architecture/business/todo_creator.dart';
import 'package:layered_architecture/data/todo_storage.dart';
import 'package:layered_architecture/data/todo_list_version_storage.dart';

class SuperSanboxTodoBloc {
  SuperSanboxTodoBloc({
    required TodoStorage superSandboxTodoStorage,
    required TodoStorage normalTodoStorage,
    required TodoListVersionStorage todoListVersionStorage,
  }) : _superSandboxTodoStorage = superSandboxTodoStorage,
        _normalTodoStorage = normalTodoStorage,
        _todoListVersionStorage = todoListVersionStorage;
  final TodoStorage _superSandboxTodoStorage;
  final TodoStorage _normalTodoStorage;
  final TodoListVersionStorage _todoListVersionStorage;

  Future<void> addTodo() async{
    final todo = todoCreator2();
    await _superSandboxTodoStorage.insertTodo(todo);
  }

  Future<List<SuperSandboxTodo>> readTodoList() async{
    final superSandboxTodoList = await _superSandboxTodoStorage.readTodoList();
    final normalSandboxTodoList = await _normalTodoStorage.readTodoList();
    return superSandboxTodoList.map((e)=>SuperSandboxTodo(title: e.title, matched: normalSandboxTodoList.contains(e),),).toList();
  }

  // Future<void> onExit() async{
  //   await
  // }

  Future<void> saveACopy() async{
    final superSandboxTodoList = await _superSandboxTodoStorage.readTodoList();
    await _todoListVersionStorage.saveVersion(superSandboxTodoList);
  }

  Future<void> onlyRemoveRed() async{
    
  }
}