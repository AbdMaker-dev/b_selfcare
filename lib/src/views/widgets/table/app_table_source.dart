import 'package:flutter/material.dart';


abstract class AppTableSource<T> {
  List<T> get rows;

  List<({String label, int flex})> get columns;

  /// Cellules d'une ligne
  List<Widget> buildRow(T item);

  /// Callback au tap sur une ligne (optionnel)
  void onRowTap(BuildContext context, T item) {}
}
