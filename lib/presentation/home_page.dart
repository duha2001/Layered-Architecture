import 'package:flutter/material.dart';
import 'package:layered_architecture/data/todo_storage.dart';
import 'package:layered_architecture/data/user_mode_storage.dart';
import 'package:layered_architecture/business/todo_bloc.dart';
import 'package:layered_architecture/business/user_mode_bloc.dart';
import 'package:layered_architecture/service_locator.dart';
import 'package:layered_architecture/presentation/widgets/add_todo_button.dart';
import 'package:layered_architecture/presentation/widgets/todo_list_view.dart';

final kMapUserModeToPage = {
  UserMode.normal: '$HomePage',
};
class HomePage extends StatefulWidget{
  const HomePage({Key ? key}) : super(key : key);

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  final TodoStorage _todoStorage = getIt.get(instanceName: kFileSystem);
  final UserModeStorage _userModeStorage = getIt.get();
  final TodoBloc _todoBloc = getIt.get();
  final UserModeBloc _userModeBloc = getIt.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  // Card(
                  //   color: Colors.white,
                  //   child: Padding(
                  //       padding: const EdgeInsets.all(16.0),
                  //       child: DropdownButton<Use>
                  //   ),
                  // ),
                  Expanded(child: TodoListView(todoStorage: _todoStorage,)),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: AddTodoButton(
                  addTodo: _todoBloc.addTodo,
                  onAddedSuccess: (){
                    setState((){});
                  },
                ),
              )
            ],
          )
        ),
      )
    );
  }

}