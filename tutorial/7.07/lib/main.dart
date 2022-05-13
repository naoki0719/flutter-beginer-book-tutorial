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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 仮のデータ(スタブ)を用意します
    final todos = List.generate(
      10,
      (index) => 'Todo ${index + 1}',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Text(todos[index]),
        ),
        itemCount: todos.length,
      ),
    );
  }
}
