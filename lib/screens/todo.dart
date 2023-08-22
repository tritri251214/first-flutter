import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';
import 'package:flutters/providers/todo_provider.dart';
import 'package:flutters/screens/todo_view.dart';
import 'package:flutters/utils/snackbar.dart';
import 'package:flutters/widgets/bottom_navigation_bar.dart';
import 'package:flutters/widgets/empty.dart';
import 'package:flutters/widgets/popup_more.dart';
import 'package:flutters/widgets/popup_status.dart';
// import 'package:flutters/widgets/loading.dart';
import 'package:flutters/widgets/shimmer_loading.dart';
import 'package:flutters/widgets/status.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  static String routeName = '/todo';

  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // ignore: unused_field
  List<Todo> _todoData = [];
  bool _isLoading = false;
  final List<int> _selection = [];
  Status filterStatus = Status.all;
  late TodoProvider _todoProvider;
  bool _isLoadingStatus = false;

  @override
  void initState() {
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    _reload();

    super.initState();
  }

  void _reload() {
    setState(() {
      _isLoading = true;
    });

    _todoProvider.changeQueryTodo(filterStatus).then((_) {
      setState(() {
        _isLoading = false;
        _todoData = _todoProvider.todoData;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _changeFilterStatus(Status status) {
    setState(() {
      filterStatus = status;
    });
    _reload();
  }

  void _onChangeSelection(bool? checked, int todoId) {
    if (checked != null && checked) {
      setState(() {
        _selection.add(todoId);
      });
    } else {
      setState(() {
        _selection.remove(todoId);
      });
    }
  }

  void _redirectToCreateTodo(context) {
    Navigator.of(context).pushNamed('/todo/create');
  }

  void _onSelectAll() {
    setState(() {
      _selection.clear();
      for (var todo in _todoData) {
        if (todo.id != null) {
          _selection.add(todo.id as int);
        }
      }
    });
  }

  void _onUnSelectAll() {
    setState(() {
      _selection.clear();
    });
  }

  void _onMakeCompleted() {
    setState(() {
      _isLoadingStatus = true;
    });
    _todoProvider.makeCompleted(_selection).then((_) {
      showSnackBar(
        context,
        const Text('Update status completed of the todo success'),
        TypeSnackBar.success,
      );
      setState(() {
        _todoData = _todoProvider.todoData;
        _isLoadingStatus = false;
      });
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something occur when change status todo'),
        TypeSnackBar.error,
      );
      setState(() {
        _isLoadingStatus = false;
      });
    });
  }

  void _onMakePending() {
    setState(() {
      _isLoadingStatus = true;
    });
    _todoProvider.makePending(_selection).then((_) {
      showSnackBar(
        context,
        const Text('Update status pending of the todo success'),
        TypeSnackBar.success,
      );
      setState(() {
        _todoData = _todoProvider.todoData;
        _isLoadingStatus = false;
      });
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something occur when change status todo'),
        TypeSnackBar.error,
      );
      setState(() {
        _isLoadingStatus = false;
      });
    });
  }

  void _onMakeInActive() {
    setState(() {
      _isLoadingStatus = true;
    });
    _todoProvider.makeInActive(_selection).then((_) {
      showSnackBar(
        context,
        const Text('Update status in active of the todo success'),
        TypeSnackBar.success,
      );
      setState(() {
        _todoData = _todoProvider.todoData;
        _isLoadingStatus = false;
      });
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something occur when update todo'),
        TypeSnackBar.error,
      );
      setState(() {
        _isLoadingStatus = false;
      });
    });
  }

  void _onDeleteTodo(Todo todo) {
    _todoProvider.deleteTodo(todo.id as int).then((_) {
      showSnackBar(
        context,
        const Text('Delete todo success'),
        TypeSnackBar.success,
      );
    }).catchError((error) {
      showSnackBar(
        context,
        const Text('Something occur when delete todo'),
        TypeSnackBar.error,
      );
    });
  }

  Widget buildListTodo(BuildContext context) {
    Widget widget;
    if (_isLoading) {
      widget = const LoadingListPage();
    } else if (_todoData.isEmpty) {
      widget = Container(
        padding: const EdgeInsets.all(64.0),
        child: const EmptyWidget(),
      );
    } else {
      widget = ListView.builder(
        itemCount: _todoData.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            direction: DismissDirection.endToStart,
            key: ValueKey<int>(_todoData[index].id as int),
            onDismissed: (DismissDirection _) => _onDeleteTodo(_todoData[index]),
            child: ListTile(
              leading: Checkbox(
                value: _selection.contains(_todoData[index].id as int),
                onChanged: (checked) => _onChangeSelection(checked!, _todoData[index].id as int),
              ),
              title: Text(_todoData[index].title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
              subtitle: Text(_todoData[index].description),
              trailing: TextButton(
                onPressed: null,
                child: StatusWidget(status: _todoData[index].status, loading: _isLoadingStatus),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TodoView.routeName,
                  arguments: TodoViewArguments(todoId: _todoData[index].id as int),
                );
              },
            ),
          );
        },
      );
    }

    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Todo screen'),
        ),
        actions: <Widget>[
          PopupStatusWidget(
            filterStatus: filterStatus,
            changeFilterStatus: _changeFilterStatus,
          ),
          PopupMoreWidget(
            onSelectAll: _onSelectAll,
            onUnSelectAll: _onUnSelectAll,
            onMakeCompleted: _onMakeCompleted,
            onMakePending: _onMakePending,
            onMakeInActive: _onMakeInActive,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildListTodo(context),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create a todo',
        onPressed: () => _redirectToCreateTodo(context),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(
        selectedMenu: 'todo'
      ),
    );
  }
}
