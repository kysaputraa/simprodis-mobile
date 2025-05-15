import 'package:flutter/material.dart';

// Show loading dialog function (global)
void showLoadingEntireScreen(BuildContext context, {bool status = true}) {
  if (status) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  } else {
    Navigator.of(context, rootNavigator: true).pop(); // Close the dialog
  }
}
