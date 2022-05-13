import 'package:flutter/material.dart';
import 'package:practice/todo.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

// StatelessWidgetからStatefulWidgetに変換します
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 文字列からToDoインスタンスの配列に変更します
  final _todos = List.generate(
    10,
    (index) => ToDo(title: 'ToDo ${index + 1}'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        // ListTileからCheckedListTileに変更します
        itemBuilder: (context, index) => CheckboxListTile(
          onChanged: (checked) {
            setState(() {
              // 完了状態を反転させます
              final original = todos[index];
              todos[index] = original.copyWith(
                archived: !original.archived,
              );
            });
          },
          value: todos[index].archived,
          title: Text(todos[index].title),
        ),
        itemCount: _todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            // ToDoインスタンスを追加するように変更します
            _todos.add(
              ToDo(title: 'ToDo ${_todos.length + 1}'),
            );
          });
        },
      ),
    );
  }
}
