import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.status});

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Component(status: status);
  }
}

class Component extends StatefulWidget {
  const Component({super.key, required this.status});

  final Status status;

  @override
  State<Component> createState() => _ComponentState();
}

class _ComponentState extends State<Component> {
  Widget _getStatus(Status status) {
    switch (status) {
      case Status.completed:
        return const Text('Completed', style: TextStyle(color: Colors.green, fontSize: 12.0));
      case Status.pending:
        return const Text('Pending', style: TextStyle(color: Colors.orange, fontSize: 12.0));
      case Status.inActive:
        return const Text('In active', style: TextStyle(color: Colors.blue, fontSize: 12.0));
      default:
        return const Text('N/A');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getStatus(widget.status);
  }
}
