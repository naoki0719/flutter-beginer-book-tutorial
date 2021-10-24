import 'package:flutter/material.dart';
import 'package:practice/database.dart';
import 'package:practice/todo.dart';

Future<void> main() async {
  // runAppの前にpath_providerが使えるように呼び出します
  WidgetsFlutterBinding.ensureInitialized();

  // データベースを開きます
  await DbHelper.instance.initialize();
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ToDoRecord>>(
      // Futureを返すメソッドや関数を指定します
      future: DbHelper.instance.find(),
      initialData: const [],
      builder: (context, snapshot) {
        // 非同期処理が終わっていない場合に
        // 待機状態がわかるWidgetを表示します
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        }

        // データの準備が出来たらtodosに展開します
        // nullableなので!で解除します
        final todos = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('ToDo'),
          ),
          body: ListView.builder(
            // ListTileからCheckedListTileに変更します
            itemBuilder: (context, index) {
              final todo = todos[index].value;

              return CheckboxListTile(
                onChanged: (checked) async {
                  final key = todos[index].key;
                  // 完了状態を反転させます
                  final update = todo.copyWith(
                    archived: !todo.archived,
                  );
                  await DbHelper.instance.update(
                    key,
                    update,
                  );

                  setState(() {});
                },
                value: todos[index].value.archived,
                title: Text(todo.title),
              );
            },
            itemCount: todos.length,
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              // ToDoを追加します
              await DbHelper.instance.add(
                ToDo(
                  title: 'ToDo ${todos.length + 1}',
                ),
              );

              setState(() {});
            },
          ),
        );
      },
    );
  }
}
