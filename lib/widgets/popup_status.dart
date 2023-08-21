import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';

class PopupStatusWidget extends StatefulWidget {
  const PopupStatusWidget({super.key, required this.filterStatus, required this.changeFilterStatus});

  final Status filterStatus;
  final Function changeFilterStatus;

  @override
  State<PopupStatusWidget> createState() => _ComponentState();
}

class _ComponentState extends State<PopupStatusWidget> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Status>(
      initialValue: widget.filterStatus,
      position: PopupMenuPosition.under,
      // Callback that sets the selected popup menu item.
      onSelected: (Status item) => widget.changeFilterStatus(item),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Status>>[
        const PopupMenuItem<Status>(
          value: Status.all,
          child: Text('Show all'),
        ),
        const PopupMenuItem<Status>(
          value: Status.completed,
          child: Text('Show completed'),
        ),
        const PopupMenuItem<Status>(
          value: Status.pending,
          child: Text('Show pending'),
        ),
        const PopupMenuItem<Status>(
          value: Status.inActive,
          child: Text('Show in active'),
        ),
      ],
      child: const IconButton(
        icon: Icon(
          Icons.filter_list,
          color: Colors.white
        ),
        tooltip: 'Filter by status',
        onPressed: null,
      ),
    );
  }
}
