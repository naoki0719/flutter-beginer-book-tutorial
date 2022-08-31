import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice/database.dart';
import 'package:practice/todo.dart';
import 'package:practice/todo_list_state.dart';

// 初期値はなく、使う時までにオーバーライドします
final databaseProvider = Provider<DbHelper>(
  (_) => throw UnimplementedError(),
);

// 紙面の都合で改行しています
final todoListProvider = StateNotifierProvider<ToDoListState, List<ToDoRecord>>(
  (ref) => ToDoListState(
    [],
    ref.watch(databaseProvider),
  ),
);
