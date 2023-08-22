import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutters/models/todo.dart';
import 'package:http/http.dart' as http;
// import 'dart:io' show Platform;

class QueryTodo {
  Status status;

  QueryTodo({required this.status});

  String toQuery() {
    if (status == Status.all) {
      return '';
    } else {
      return 'status=${convertStatusToString(status)}';
    }
  }
}

class TodoProvider with ChangeNotifier {
  List<Todo> _todoData = [];
  QueryTodo _queryTodo = QueryTodo(status: Status.all);

  List<Todo> get todoData => _todoData;
  QueryTodo? get queryTodo => _queryTodo;

  // Uri Function(String path) uri = (String path) => Uri.parse('http://localhost:3000/$path');
  Uri Function(String path) uri =
      (String path) => Uri.parse('http://10.0.2.2:3000/$path');

  Future changeQueryTodo(Status filterStatus) async {
    _queryTodo = QueryTodo(status: filterStatus);
    await getListTodo();
  }

  Future<void> getListTodo() async {
    try {
      final http.Response response =
          await http.get(uri('todos?${_queryTodo.toQuery()}'));

      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData.isEmpty) {
        return;
      }
      final List<Todo> loadedTodoData = [];
      for (var item in extractedData) {
        loadedTodoData.add(
          Todo.fromJson(item),
        );
      }
      _todoData = loadedTodoData;
      notifyListeners();
      return;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Todo?> getTodo(int todoId) async {
    try {
      final http.Response response = await http.get(uri('todos/$todoId'));
      return Todo.fromJson(json.decode(response.body));
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Todo> addTodo(Todo data) async {
    try {
      final response = await http.post(uri('todos'), body: data.toJson());

      final todo = Todo.fromJson(json.decode(response.body));
      getListTodo();
      return todo;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<Todo> updateTodo(Todo data) async {
    try {
      final response =
          await http.put(uri('todos/${data.id}'), body: data.toJson());

      final todo = Todo.fromJson(json.decode(response.body));
      getListTodo();
      return todo;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> deleteTodo(int todoId) async {
    try {
      await http.delete(uri('todos/$todoId'));
      _todoData.removeWhere((todo) => todo.id == todoId);
      return true;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> makeCompleted(List<int> selection) async {
    try {
      for (int todoId in selection) {
        Todo todoUpdate = _todoData.firstWhere((todo) => todo.id == todoId);
        todoUpdate.status = Status.completed;
        await http.put(uri('todos/$todoId'), body: todoUpdate.toJson());
        int index = _todoData.indexWhere((todo) => todo.id == todoId);
        _todoData[index].status = Status.completed;
      }
      return true;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> makePending(List<int> selection) async {
    try {
      for (int todoId in selection) {
        Todo todoUpdate = _todoData.firstWhere((todo) => todo.id == todoId);
        todoUpdate.status = Status.pending;
        await http.put(uri('todos/$todoId'), body: todoUpdate.toJson());
        int index = _todoData.indexWhere((todo) => todo.id == todoId);
        _todoData[index].status = Status.pending;
      }
      return true;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }

  Future<bool> makeInActive(List<int> selection) async {
    try {
      for (int todoId in selection) {
        Todo todoUpdate = _todoData.firstWhere((todo) => todo.id == todoId);
        todoUpdate.status = Status.inActive;
        await http.put(uri('todos/$todoId'), body: todoUpdate.toJson());
        int index = _todoData.indexWhere((todo) => todo.id == todoId);
        _todoData[index].status = Status.inActive;
      }
      return true;
    } catch (error) {
      // ignore: use_rethrow_when_possible
      throw error;
    }
  }
}
