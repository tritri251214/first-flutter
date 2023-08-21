import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';
import 'package:flutters/providers/todo_provider.dart';
import 'package:flutters/screens/todo.dart';
import 'package:flutters/utils/snackbar.dart';
import 'package:flutters/widgets/bottom_navigation_bar.dart';
import 'package:flutters/widgets/loading.dart';
import 'package:flutters/widgets/select_status.dart';
import 'package:provider/provider.dart';

class CreateTodo extends StatefulWidget {
  static String routeName = '/todo/create';

  const CreateTodo({super.key});

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  List<DropdownMenuEntry> statusEntries = <DropdownMenuEntry>[];
  final Todo _todoInformation = Todo(title: '', description: '', status: Status.inActive);
  bool _isLoadingSave = false;
  late TodoProvider _todoProvider;

  @override
  initState() {
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);

    super.initState();
  }

  Future<void> _onAddTodo(BuildContext context) async {
    setState(() {
      _isLoadingSave = true;
    });

    _todoProvider.addTodo(_todoInformation).then((todo) {
      showSnackBar(context, const Text('Create todo success'), TypeSnackBar.success);

      setState(() {
        _isLoadingSave = false;
      });
      Navigator.pushReplacementNamed(context, TodoScreen.routeName);
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something went occur when create todo'),
        TypeSnackBar.error,
      );
      setState(() {
        _isLoadingSave = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Create todo'),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
                onPressed: _isLoadingSave ? null : () => _onAddTodo(context),
                child: _isLoadingSave ? const LoadingWidget() : const Text('Add todo'),
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
