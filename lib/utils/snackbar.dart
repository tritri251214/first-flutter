import 'package:flutter/material.dart';

enum TypeSnackBar {
  success,
  error,
}

void showSnackBar(BuildContext context, Widget content, TypeSnackBar type) {
  Color backgroundColor = Colors.black;
  switch (type) {
    case TypeSnackBar.success:
      backgroundColor = Colors.green;
      break;
    case TypeSnackBar.error:
      backgroundColor = Colors.red;
      break;
    default:
      backgroundColor = Colors.black;
      break;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      backgroundColor: backgroundColor,
      content: content,
    ),
  );
}
