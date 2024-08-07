import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_proj/to_do_app_list/data/model/to_do_model.dart';


class ApiConfig {
  final String baseUrl = "https://jsonplaceholder.typicode.com/todos";

  Future<List<ToDoListModel>> getData() async {
    var uri = Uri.parse(baseUrl);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      return toDoListModelFromJson(response.body);
    } else {
      throw Exception("Failed to load To-Do List: ${response.statusCode}");
    }
  }

  Future<void> addToDo(ToDoListModel toDo) async {
    var uri = Uri.parse(baseUrl);
    var response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toDo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add To-Do: ${response.reasonPhrase}");
    }
  }

  Future<void> updateToDo(ToDoListModel toDo) async {
    var uri = Uri.parse("$baseUrl/${toDo.id}");
    var response = await http.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(toDo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to update To-Do: ${response.reasonPhrase}");
    }
  }

  Future<void> deleteToDo(int id) async {
    var uri = Uri.parse("$baseUrl/$id");
    var response = await http.delete(uri);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Failed to delete To-Do: ${response.reasonPhrase}");
    }
  }
}
