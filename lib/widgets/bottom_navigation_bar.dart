import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key, required this.selectedMenu});

  final String selectedMenu;

  @override
  State<BottomNavigationBarWidget> createState() => _ComponentState();
}

class _ComponentState extends State<BottomNavigationBarWidget> {
  int selectedMenu = 0;

  void _onChangeMenu(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        break;
      case 1:
        Navigator.of(context).pushNamedAndRemoveUntil('/todo', (route) => false);
        break;
      default:
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.selectedMenu) {
      case 'home':
        selectedMenu = 0;
        break;
      case 'todo':
        selectedMenu = 1;
        break;
      default:
        selectedMenu = 0;
        break;
    }
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Todo',
        ),
      ],
      currentIndex: selectedMenu,
      selectedItemColor: Colors.amber[800],
      onTap: _onChangeMenu,
    );
  }
}
