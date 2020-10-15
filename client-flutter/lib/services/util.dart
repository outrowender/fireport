import 'package:fireport/styles.dart';
import 'package:flutter/material.dart';

class Util {
  static showMessage({String message, BuildContext ctx, Function callbackOK}) {
    Scaffold.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            color: DraculaPalette.background,
          ),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: callbackOK,
        ),
      ),
    );
  }
}
