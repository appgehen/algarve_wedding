import 'package:flutter/material.dart';

void showSnackbar(BuildContext context) {
  final snackBar = SnackBar(content: const Text('Download erfolgreich'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
