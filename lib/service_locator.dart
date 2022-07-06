import 'package:layered_architecture/business/sandbox_todo_bloc.dart';
import 'package:layered_architecture/business/super_sandbox_todo_bloc.dart';
import 'package:layered_architecture/business/todo_bloc.dart';
import 'package:layered_architecture/business/todo_list_version_bloc.dart';
import 'package:layered_architecture/data/todo_storage.dart';
import 'package:layered_architecture/data/todo_list_version_storage.dart';
import 'package:layered_architecture/data/user_mode_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

const kFileSystem = 'fileSystem';
const kCached = 'cached';

void setupMainDeps(){
  getIt.registerSingleton<TodoStorage>(
    FileSystemTodoStorage(),
    instanceName: kFileSystem,
  );
}