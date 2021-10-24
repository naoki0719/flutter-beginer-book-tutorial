class ToDo {
  ToDo({
    required this.title,
    this.archived = false,
  });

  /// ToDoのタイトルです
  String title;

  /// ToDoの完了状態です
  bool archived;
}
