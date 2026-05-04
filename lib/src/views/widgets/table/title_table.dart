import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

typedef TableFilter = ({String label, String value});

class TitleTable extends StatelessWidget {
  final String title;
  final List<TableFilter>? filters;
  final String? selectedFilter;
  final ValueChanged<String>? onFilterChanged;

  const TitleTable({
    super.key,
    required this.title,
    this.filters,
    this.selectedFilter,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.rw, 16.rh, 20.rw, 14.rh),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.gray)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppText(
              title,
              fontSize: 15.rsp,
              color: AppColors.textHeading,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (filters != null && filters!.isNotEmpty)
            _FilterPills(
              filters: filters!,
              selected: selectedFilter ?? filters!.first.value,
              onChanged: onFilterChanged,
            ),
        ],
      ),
    );
  }
}

class _FilterPills extends StatelessWidget {
  final List<TableFilter> filters;
  final String selected;
  final ValueChanged<String>? onChanged;

  const _FilterPills({
    required this.filters,
    required this.selected,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.rw),
      decoration: BoxDecoration(
        color: AppColors.grayGh,
        borderRadius: BorderRadius.circular(8.rr),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: filters.map((f) {
          final isSelected = f.value == selected;
          return GestureDetector(
            onTap: () => onChanged?.call(f.value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 5.rh),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(6.rr),
                boxShadow: isSelected
                    ? [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 1))]
                    : [],
              ),
              child: AppText(
                f.label,
                fontSize: 12.rsp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.textHeading : AppColors.textMuted,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}