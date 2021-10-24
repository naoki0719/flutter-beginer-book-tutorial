import 'package:flutter/material.dart';

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
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // buildメソッドにあった変数を移動します
  final _todos = List.generate(10, (index) => 'Todo ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(_todos[index]),
        ),
        itemCount: _todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 変更します
          setState(() {
            _todos.add('ToDo ${_todos.length + 1}');
          });
        },
      ),
    );
  }
}
