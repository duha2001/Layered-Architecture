import 'package:layered_architecture/business/sandbox_todo_bloc.dart';
import 'package:layered_architecture/business/super_sandbox_todo_bloc.dart';
import 'package:layered_architecture/business/todo_bloc.dart';
import 'package:layered_architecture/business/todo_list_version_bloc.dart';
import 'package:layered_architecture/data/todo_storage.dart';
import 'package:layered_architecture/data/todo_list_version_storage.dart';
import 'package:layered_architecture/data/user_mode_storage.dart';
import 'package:layered_architecture/business/user_mode_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

const kFileSystem = 'fileSystem';
const kCached = 'cached';

void setupMainDeps(){
  getIt.registerSingleton<TodoStorage>(
    FileSystemTodoStorage(),
    instanceName: kFileSystem,
  );
  getIt.registerSingleton<UserModeStorage>(CacheUserModeStorage());
  getIt.registerFactory<TodoBloc>(
        () => TodoBloc(todoStorage: getIt.get(instanceName: kFileSystem)),
  );
  getIt.registerFactory<UserModeBloc>(
        () => UserModeBloc(userModeStorage: getIt.get()),
  );
  // getIt.registerFactory(() => )
}

void setupSandBoxDeps(){
  getIt.registerSingleton<TodoStorage>(
    CashedTodoStorage(),
    instanceName: kCached
  );

  getIt.registerFactory(() =>
      SandboxTodoBloc(
          sandboxTodoStorage: getIt.get(instanceName: kCached),
          normalTodoStorage: getIt.get(instanceName: kFileSystem),
      )
  );
}

void setupSuperSandboxDeps(){
  getIt.registerSingleton<TodoStorage>(
    CashedTodoStorage(),
    instanceName: kCached,
  );

  getIt.registerSingleton<TodoListVersionStorage>(
    FileSystemTodoListVersionStorage(),
    instanceName: kFileSystem,
  );

  getIt.registerFactory(() =>
    SuperSanboxTodoBloc(
        superSandboxTodoStorage: getIt.get(instanceName: kCached),
        normalTodoStorage: getIt.get(instanceName: kCached),
        todoListVersionStorage: getIt.get(instanceName: kFileSystem),
    )
  );
  getIt.registerFactory(() =>
    TodoListVersionBloc(todoStorage: getIt.get(instanceName: kCached),
    )
  );
}