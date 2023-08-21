import 'package:flutter/material.dart';
import 'package:flutters/providers/todo_provider.dart';
import 'package:flutters/screens/todo_view.dart';
import 'package:provider/provider.dart';
import 'package:flutters/screens/create_todo.dart';
import 'package:flutters/screens/edit_todo.dart';
import 'package:flutters/screens/home.dart';
import 'package:flutters/screens/todo.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => TodoProvider()),
  ],
  child: const MainApp(),
));

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        TodoScreen.routeName: (_) => const TodoScreen(),
        CreateTodo.routeName: (_) => const CreateTodo(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == TodoView.routeName) {
          final args = settings.arguments as TodoViewArguments;
          return MaterialPageRoute(
            builder: (context) {
              return TodoView(
                todoId: args.todoId,
              );
            },
          );
        } else if (settings.name == EditTodo.routeName) {
          final args = settings.arguments as EditTodoArguments;
          return MaterialPageRoute(
            builder: (context) {
              return EditTodo(
                todoId: args.todoId,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
