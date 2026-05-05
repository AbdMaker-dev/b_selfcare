import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/empty_table.dart';
import 'package:b_selfcare/src/views/widgets/table/header_table.dart';
import 'package:b_selfcare/src/views/widgets/table/paginator_table.dart';
import 'package:b_selfcare/src/views/widgets/table/row_table.dart';
import 'package:b_selfcare/src/views/widgets/table/title_table.dart';
import 'package:flutter/material.dart';


class AppTable<T> extends StatelessWidget {
  final String title;
  final AppTableSource<T> source;
  final bool hidePaginator;
  final bool activePreviousClicked;
  final bool activeNextClicked;
  final VoidCallback? onPreviousClicked;
  final VoidCallback? onNextClicked;
  final int currentPage;
  final int totalCount;
  final String emptyMessage;
  final List<TableFilter>? filters;
  final String? selectedFilter;
  final ValueChanged<String>? onFilterChanged;

  const AppTable({
    super.key,
    required this.title,
    required this.source,
    this.hidePaginator = false,
    this.activePreviousClicked = false,
    this.activeNextClicked = false,
    this.onPreviousClicked,
    this.onNextClicked,
    this.currentPage = 1,
    this.totalCount = 0,
    this.emptyMessage = 'Aucune donnée',
    this.filters,
    this.selectedFilter,
    this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final rows = source.rows;
    final cols = source.columns;
    final total = totalCount > 0 ? totalCount : rows.length;
    final start = total == 0 ? 0 : (currentPage - 1) * rows.length + 1;
    final end = (start + rows.length - 1).clamp(0, total);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleTable(
            title: title,
            filters: filters,
            selectedFilter: selectedFilter,
            onFilterChanged: onFilterChanged,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderTable(columns: cols),
              if (rows.isEmpty)
                EmptyTable(message: emptyMessage)
              else
                ...rows.asMap().entries.map((e) => RowTable<T>(
                  cells: source.buildRow(e.value),
                  columns: cols,
                  isLast: e.key == rows.length - 1,
                  onTap: () => source.onRowTap(context, e.value),
                )),
            ],
          ),
          if (!hidePaginator)
            PaginatorTable(
              start: start,
              end: end,
              total: total,
              activePrev: activePreviousClicked,
              activeNext: activeNextClicked,
              onPrev: onPreviousClicked,
              onNext: onNextClicked,
            ),
        ],
      ),
    );
  }
}