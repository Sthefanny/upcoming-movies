import 'package:flutter/material.dart';

class SnackbarMessages {
  static buildErrorMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.red[200],
    );
    Future.delayed(Duration.zero).then((_) {
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }

  static buildSuccessMessage(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.green[200],
    );
    Future.delayed(Duration.zero).then((_) {
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
}
