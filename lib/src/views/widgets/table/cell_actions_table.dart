import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/table/btn.dart';
import 'package:flutter/material.dart';

class CellActionsTable extends StatelessWidget {
  final List<({String label, bool danger, VoidCallback? onTap})> actions;
  const CellActionsTable({super.key, required this.actions});

  @override
  Widget build(BuildContext context) {
    return Wrap(                         // ← passe à la ligne si espace insuffisant
      spacing: 6.rw,                    // espace horizontal entre boutons
      runSpacing: 4.rh,                 // espace vertical si wrap
      children: actions.map((a) => Btn(
        label: a.label,
        danger: a.danger,
        onTap: a.onTap,
      )).toList(),
    );
  }
}