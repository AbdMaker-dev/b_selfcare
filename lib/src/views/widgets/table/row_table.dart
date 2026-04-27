import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';


class RowTable<T> extends StatefulWidget {
  final List<Widget> cells;
  final List<({String label, int flex})> columns;
  final bool isLast;
  final VoidCallback? onTap;

  const RowTable({
    required this.cells,
    required this.columns,
    required this.isLast,
    this.onTap,
  });

  @override
  State<RowTable<T>> createState() => _RowTableState<T>();
}

class _RowTableState<T> extends State<RowTable<T>> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding:  EdgeInsets.symmetric(horizontal: 4.rw),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.grayWh : AppColors.white,
            border: widget.isLast
                ? null
                :  Border(bottom: BorderSide(color: AppColors.grayGh)),
          ),
          child: Row(
            children: List.generate(
              widget.columns.length,
              (i) => Expanded(
                flex: widget.columns[i].flex,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 12.rh),
                  child: i < widget.cells.length ? widget.cells[i] : const SizedBox(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}