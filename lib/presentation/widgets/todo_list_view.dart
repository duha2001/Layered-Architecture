import 'package:flutter/material.dart';
import 'package:layered_architecture/data/models/todo.model.dart';
import 'package:layered_architecture/data/todo_storage.dart';

class TodoListView extends StatelessWidget{
  const TodoListView({
    Key? key,
    required TodoStorage todoStorage,
  }): _todoStorage = todoStorage, super(key: key);

  final TodoStorage _todoStorage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: _todoStorage.readTodoList(),
        builder: (_,snapshot) {
          if(snapshot.hasData){
            final todoList = snapshot.data!;
            return ListView(
              children: todoList
                  .map(
                    (e) => Card(
                      child:  Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(e.title),
                    ),
                  ),
              ).toList(),
            );
          }else if (snapshot.hasError){
            return const Center(
              child: Text("Something went wrong"),
            );
          } else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }
}