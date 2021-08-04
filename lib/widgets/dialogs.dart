import 'package:flutter/material.dart';

enum DialogAction { yes, cancel }

class Dialogs {
  static Future<DialogAction?> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            title: Text(title),
            content: Text(body),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogAction.cancel;
  }
}
