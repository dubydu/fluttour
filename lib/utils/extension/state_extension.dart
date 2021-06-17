import 'package:fluttour/app_define/app_route.dart';
import 'package:flutter/material.dart';

extension StatefulWidgetExt on State {
  Future<void> showErrorDialog(String title, String mgs) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('$title $mgs'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                context.navigator()?.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> showConfirmDialog(Function onOK, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                context.navigator()?.pop();
              },
              child: const Text('Cancel'),),
            TextButton(
              onPressed: () async {
                onOK();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}