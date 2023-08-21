import 'package:flutter/material.dart';
import 'package:flutters/models/todo.dart';

class SelectStatusWidget extends StatefulWidget {
  const SelectStatusWidget({super.key, required this.initialSelection, required this.onSelected});

  final dynamic initialSelection;
  final Function onSelected;

  @override
  State<SelectStatusWidget> createState() => _ComponentState();
}

class _ComponentState extends State<SelectStatusWidget> {
  List<DropdownMenuEntry> statusEntries = <DropdownMenuEntry>[];

  @override
  void initState() {
    for (Status status in Status.values) {
      switch (status) {
        case Status.completed:
          statusEntries.add(
            DropdownMenuEntry(
              value: status,
              label: 'Completed',
            )
          );
          break;
        case Status.pending:
          statusEntries.add(
            DropdownMenuEntry(
              value: status,
              label: 'Pending',
            )
          );
          break;
        case Status.inActive:
          statusEntries.add(
            DropdownMenuEntry(
              value: status,
              label: 'In active',
            )
          );
          break;
        default:
          break;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DropdownMenu(
        initialSelection: widget.initialSelection,
        label: const Text('Status'),
        dropdownMenuEntries: statusEntries,
        onSelected: (status) => widget.onSelected(status),
        width: MediaQuery.of(context).size.width - 32,
      ),
    );
  }
}
