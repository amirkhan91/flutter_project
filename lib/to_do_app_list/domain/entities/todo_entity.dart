class ToDoEntity {
  final int? userId;
  final int? id;
  final String? title;
  final String? body;
  final bool isCompleted;

  ToDoEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.isCompleted = false,
  });
}
