import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/table/btn.dart';
import 'package:flutter/material.dart';

class CellActionsTable extends StatelessWidget {
  final List<({String label, bool danger, VoidCallback? onTap})> actions;
  const CellActionsTable({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: actions.map((a) => Padding(
        padding:  EdgeInsets.only(right: 6.rw),
        child: Btn(label: a.label, danger: a.danger, onTap: a.onTap),
      )).toList(),
    );
  }
}