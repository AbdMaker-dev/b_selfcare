import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/cubit/filter_tab_cubit.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterTabsWidget extends StatefulWidget {
  final List<FilterTab> tabs;
  final ValueChanged<FilterTab>? onTabChanged;

  const FilterTabsWidget({
    super.key,
    required this.tabs,
    this.onTabChanged,
  });

  @override
  State<FilterTabsWidget> createState() => _FilterTabsWidgetState();
}

class _FilterTabsWidgetState extends State<FilterTabsWidget> {
  final filterTabCubit = getIt<FilterTabCubit>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: filterTabCubit,
      child: _FilterTabsView(
        tabs: widget.tabs,
        onTabChanged: widget.onTabChanged,
      ),
    );
  }
}

class _FilterTabsView extends StatelessWidget {
  final List<FilterTab> tabs;
  final ValueChanged<FilterTab>? onTabChanged;

  const _FilterTabsView({required this.tabs, this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final filterTabCubit = getIt<FilterTabCubit>();
    return BlocBuilder<FilterTabCubit, FilterTabState>(
      bloc: filterTabCubit,
      builder: (context, state) {
        final selectedIndex = state.maybeWhen(
          change: (index) => index,
          orElse: () => 0,
        );
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
          child: Row(
            children: List.generate(tabs.length, (i) {
              final tab = tabs[i];
              final isSelected = selectedIndex == i;
              return Padding(
                padding: EdgeInsets.only(right: 8.rw),
                child: _FilterChip(
                  label: tab.label,
                  count: tab.count,
                  isSelected: isSelected,
                  onTap: () {
                    context.read<FilterTabCubit>().selectTab(i);
                    onTabChanged?.call(tab);
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final int? count;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    final text = count != null
        ? '$label (${count!.toString()})'
        : label;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: 14.rw,
          vertical: 6.rh,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999.rr),
          border: Border.all(
            color: isSelected
                ?  AppColors.primary
                : AppColors.white,
            width: isSelected ? 1.5 : 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.rsp,
            fontWeight: isSelected
                ? FontWeight.w600
                : FontWeight.w400,
            color: isSelected
                ? AppColors.primary
                : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}