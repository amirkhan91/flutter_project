import 'dart:convert';

List<ToDoListModel> toDoListModelFromJson(String str) =>
    List<ToDoListModel>.from(json.decode(str).map((x) => ToDoListModel.fromJson(x)));

String toDoListModelToJson(List<ToDoListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToDoListModel {
  int? userId;
  int? id;
  String? title;
  String? body; // Assuming body is optional
  bool? completed;

  ToDoListModel({
    this.userId,
    this.id,
    this.title,
    this.body,
    this.completed,
  });

  factory ToDoListModel.fromJson(Map<String, dynamic> json) => ToDoListModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
        "completed": completed,
      };
}
