import 'package:flutter/material.dart';

class CustomAlertDialog {

  void showErrorDialog({
    required BuildContext context,
    required String title,
    required String message
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK")
            )
          ],
        );
      },
    );
  }
}
