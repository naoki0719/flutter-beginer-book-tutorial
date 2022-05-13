import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:practice/provider.dart';
import 'package:practice/todo_input_view.dart';

class ToDoListScreen extends HookConsumerWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ToDoListStateに変更があるとリビルドされます
    final todos = ref.watch(todoListProvider);
    // ToDoListStateのメソッドを使えるようにします
    final todoNotifier = ref.read(todoListProvider.notifier);

    // buildが呼ばれてからToDoリストを読み込みます
    useEffect(() {
      todoNotifier.find();
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        // ListTileからCheckedListTileに変更します
        itemBuilder: (context, index) => CheckboxListTile(
          onChanged: (checked) {
            todoNotifier.toggle(todos[index]);
          },
          value: todos[index].value.archived,
          title: Text(
            todos[index].value.title,
          ),
        ),
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          ToDoInputView.show(context);
        },
      ),
    );
  }
}
