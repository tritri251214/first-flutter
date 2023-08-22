import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';
import 'package:shimmer/shimmer.dart';

class StatusWidget extends StatefulWidget {
  const StatusWidget({super.key, required this.status, required this.loading});

  final Status status;
  final bool loading;

  @override
  State<StatusWidget> createState() => _StatusWidgetState();
}

class _StatusWidgetState extends State<StatusWidget> {
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
    if (widget.loading) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          width: 60.0,
          height: 10.0,
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 8.0),
        ),
      );
    }

    return _getStatus(widget.status);
  }
}
