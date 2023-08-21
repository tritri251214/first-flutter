import 'package:flutter/material.dart';

enum More { makeCompleted, makePending, makeInActive, selectAll, unSelectAll }

class PopupMoreWidget extends StatefulWidget {
  const PopupMoreWidget({
    super.key,
    required this.onSelectAll,
    required this.onUnSelectAll,
    required this.onMakeCompleted,
    required this.onMakePending,
    required this.onMakeInActive,
  });

  final Function onSelectAll;
  final Function onUnSelectAll;
  final Function onMakeCompleted;
  final Function onMakePending;
  final Function onMakeInActive;

  @override
  State<PopupMoreWidget> createState() => _ComponentState();
}

class _ComponentState extends State<PopupMoreWidget> {

  void _onSelected(More action) {
    switch (action) {
      case More.selectAll:
        widget.onSelectAll();
        break;
      case More.unSelectAll:
        widget.onUnSelectAll();
        break;
      case More.makeCompleted:
        widget.onMakeCompleted();
        break;
      case More.makePending:
        widget.onMakePending();
        break;
      case More.makeInActive:
        widget.onMakeInActive();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<More>(
      position: PopupMenuPosition.under,
      // Callback that sets the selected popup menu item.
      onSelected: _onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<More>>[
        const PopupMenuItem<More>(
          value: More.selectAll,
          child: Text('Select all'),
        ),
        const PopupMenuItem<More>(
          value: More.unSelectAll,
          child: Text('Un select all'),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<More>(
          value: More.makeCompleted,
          child: Text('Make completed'),
        ),
        const PopupMenuItem<More>(
          value: More.makePending,
          child: Text('Make pending'),
        ),
        const PopupMenuItem<More>(
          value: More.makeInActive,
          child: Text('Make in active'),
        ),
      ],
      child: const IconButton(
        icon: Icon(
          Icons.more_horiz,
          color: Colors.white
        ),
        tooltip: 'More Actions',
        onPressed: null,
      ),
    );
  }
}
