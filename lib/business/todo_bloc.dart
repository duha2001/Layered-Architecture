import 'package:layered_architecture/business/todo_creator.dart';
import 'package:layered_architecture/data/todo_storage.dart';

class TodoBloc{
  final TodoStorage _todoStorage;
  TodoBloc({required TodoStorage todoStorage}) : _todoStorage = todoStorage;
  Future<void> addTodo() async{
    final todo = todoCreator();
    await _todoStorage.insertTodo(todo);
  }
}