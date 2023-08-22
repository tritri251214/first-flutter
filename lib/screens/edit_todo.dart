import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';
import 'package:flutters/providers/todo_provider.dart';
import 'package:flutters/utils/snackbar.dart';
import 'package:flutters/widgets/bottom_navigation_bar.dart';
import 'package:flutters/widgets/loading.dart';
import 'package:flutters/widgets/select_status.dart';
import 'package:flutters/widgets/shimmer_loading.dart';

import 'package:provider/provider.dart';

class EditTodoArguments {
  final int todoId;

  const EditTodoArguments({required this.todoId});
}

class EditTodo extends StatefulWidget {
  static String routeName = '/todo/edit';

  const EditTodo({super.key, required this.todoId});

  final int todoId;

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  // ignore: unused_field
  late Todo _todoInformation;
  // ignore: unused_field
  bool _isLoading = false;
  bool _isLoadingSave = false;
  late TodoProvider _todoProvider;

  @override
  initState() {
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    _reload();

    super.initState();
  }

  void _reload() {
    setState(() {
      _isLoading = true;
    });

    _todoProvider.getTodo(widget.todoId).then((todo) {
      setState(() {
        _todoInformation = todo as Todo;
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _onUpdateTodo(BuildContext context) async {
    setState(() {
      _isLoadingSave = true;
    });

    _todoProvider.updateTodo(_todoInformation).then((todo) {
      showSnackBar(
        context,
        const Text('Update todo information successfully'),
        TypeSnackBar.success,
      );

      setState(() {
        _isLoadingSave = false;
      });

      _todoInformation = todo;
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something went occur while update todo'),
        TypeSnackBar.error,
      );
      setState(() {
        _isLoadingSave = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final params = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Edit todo'),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading ? const LoadingEditPage() : Column(
          children: <Widget>[
            TextFormField(
              initialValue: _todoInformation.id.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter id';
                }
                return null;
              },
              readOnly: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _todoInformation.title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter title';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _todoInformation.title = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: _todoInformation.description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _todoInformation.description = value;
                });
              },
            ),
            const SizedBox(height: 20),
            SelectStatusWidget(
              initialSelection: _todoInformation.status,
              onSelected: (status) {
                setState(() {
                  _todoInformation.status = status;
                });
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: FilledButton(
                onPressed: _isLoadingSave ? null : () => _onUpdateTodo(context),
                child: _isLoadingSave ? const LoadingWidget() : const Text('Update todo'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(
        selectedMenu: 'todo',
      )
    );
  }
}
