import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';
import 'package:flutters/providers/todo_provider.dart';
import 'package:flutters/screens/create_todo.dart';
import 'package:flutters/screens/edit_todo.dart';
import 'package:flutters/widgets/bottom_navigation_bar.dart';
import 'package:flutters/widgets/shimmer_loading.dart';
import 'package:flutters/widgets/status.dart';

import 'package:provider/provider.dart';

class TodoViewArguments {
  final int todoId;

  const TodoViewArguments({required this.todoId});
}

class TodoView extends StatefulWidget {
  static String routeName = '/todo/view';

  const TodoView({super.key, required this.todoId});

  final int todoId;

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  static const labelStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold);
  static double labelWidth = 100;
  // ignore: unused_field
  late Todo _todoInformation;
  // ignore: unused_field
  bool _isLoading = false;

  @override
  initState() {
    setState(() {
      _isLoading = true;
    });

    Provider.of<TodoProvider>(context, listen: false).getTodo(widget.todoId).then((todo) {
      setState(() {
        _todoInformation = todo as Todo;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  void _redirectToCreateTodo(context) {
    Navigator.of(context).pushNamed(
      CreateTodo.routeName,
    );
  }

  void _redirectToEditTodo(context, int todoId) {
    Navigator.of(context).pushNamed(
      EditTodo.routeName,
      arguments: EditTodoArguments(todoId: todoId)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Todo information'),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading ? const LoadingDetailPage() : Column(
          children: <Widget>[
            Row(
              children: [
                SizedBox(
                  width: labelWidth,
                  child: const Text('ID: ', style: labelStyle),
                ),
                Expanded(
                  child: Text(_todoInformation.id.toString()),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: labelWidth,
                  child: const Text('Title: ', style: labelStyle),
                ),
                Expanded(
                  child: Text(_todoInformation.title),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: labelWidth,
                  child: const Text('Description: ', style: labelStyle),
                ),
                Expanded(
                  child: Text(_todoInformation.description),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: labelWidth,
                  child: const Text('Status: ', style: labelStyle),
                ),
                Expanded(
                  child: StatusWidget(status: _todoInformation.status, loading: false),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: UniqueKey(),
            tooltip: 'Create a todo',
            onPressed: () => _redirectToCreateTodo(context),
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: UniqueKey(),
            tooltip: 'Edit todo',
            onPressed: () => _redirectToEditTodo(context, widget.todoId),
            child: const Icon(Icons.edit),
          ),
        ]
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Edit todo',
      //   onPressed: () => _redirectToEditTodo(context, widget.todoId),
      //   child: const Icon(Icons.edit),
      // ),
      bottomNavigationBar: const BottomNavigationBarWidget(
        selectedMenu: 'todo',
      )
    );
  }
}
