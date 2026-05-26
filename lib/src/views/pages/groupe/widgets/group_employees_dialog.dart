import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table_source.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_badge_table.dart';
import 'package:b_selfcare/src/views/widgets/table/cell_text_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupEmployeesDialog extends StatefulWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const GroupEmployeesDialog({super.key, required this.groupe, required this.groupCubit});

  static void show(BuildContext context, {required GroupModel groupe, required GroupCubit groupCubit}) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: AppColors.primary.withValues(alpha: 0.6),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.rr)),
        insetPadding: EdgeInsets.symmetric(horizontal: 32.rw, vertical: 32.rh),
        child: GroupEmployeesDialog(groupe: groupe, groupCubit: groupCubit),
      ),
    );
  }

  @override
  State<GroupEmployeesDialog> createState() => _GroupEmployeesDialogState();
}

class _GroupEmployeesDialogState extends State<GroupEmployeesDialog> {
  int _currentPage = 1;
  int _selectedFilterIndex = 0;
  DataEmployeeResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    _fetchPage(1);
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    widget.groupCubit.getEmployeesGroup(
      id: widget.groupe.id!,
      data: _buildParams(page: page),
    );
  }

  void _search(String query) {
    setState(() {
      _currentPage = 1;
      _selectedFilterIndex = 0;
    });
    widget.groupCubit.getEmployeesGroup(
      id: widget.groupe.id!,
      data: query.isNotEmpty ? {'search': query} : {'page': 1},
    );
  }

  void _applyFilter(int index) {
    setState(() {
      _selectedFilterIndex = index;
      _currentPage = 1;
    });
    widget.groupCubit.getEmployeesGroup(
      id: widget.groupe.id!,
      data: switch (index) {
        1 => {'status': 'ACTIVE'},
        2 => {'status': 'INACTIVE'},
        _ => {'page': 1},
      },
    );
  }

  Map<String, dynamic> _buildParams({required int page}) {
    return switch (_selectedFilterIndex) {
      1 => {'status': 'ACTIVE', 'page': page},
      2 => {'status': 'INACTIVE', 'page': page},
      _ => {'page': page},
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listenWhen: (_, current) => current is GetEmployeesGroupLoaded,
      listener: (context, state) {
        if (state is GetEmployeesGroupLoaded) {
          setState(() => _cachedData = state.data);
        }
      },
      buildWhen: (_, current) =>
          current is GetEmployeesGroupLoading ||
          current is GetEmployeesGroupLoaded ||
          current is GetEmployeesGroupFailed,
      builder: (context, state) {
        final isLoading = state is GetEmployeesGroupLoading;
        final employees = _cachedData?.data?.employees ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        return SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              _Header(
                groupe: widget.groupe,
                total: total,
                onClose: () => Navigator.of(context, rootNavigator: true).pop(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 16.rh),
                child: AppSearchInput(onChanged: _search),
              ),
              _FilterBar(
                selectedIndex: _selectedFilterIndex,
                total: total,
                onChanged: _applyFilter,
              ),
              SizedBox(height: 12.rh),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.rw),
                  child: isLoading && employees.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          ),
                        )
                      : AppTable(
                          title: 'Employés du groupe',
                          source: _SourceGroupEmployees(rows: employees),
                          currentPage: _currentPage,
                          totalCount: total,
                          activePreviousClicked: _currentPage > 1,
                          activeNextClicked: _currentPage < lastPage,
                          onPreviousClicked: _currentPage > 1
                              ? () => _fetchPage(_currentPage - 1)
                              : null,
                          onNextClicked: _currentPage < lastPage
                              ? () => _fetchPage(_currentPage + 1)
                              : null,
                        ),
                ),
              ),
              SizedBox(height: 24.rh),
            ],
          ),
        );
      },
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final GroupModel groupe;
  final int total;
  final VoidCallback onClose;

  const _Header({required this.groupe, required this.total, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 20.rh),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.gray)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.rw),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10.rr),
            ),
            child: Icon(Icons.people_outline, color: AppColors.primary, size: 22.rsp),
          ),
          SizedBox(width: 14.rw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Employés · ${groupe.name ?? ''}',
                  fontSize: 16.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeading,
                ),
                SizedBox(height: 2.rh),
                AppText(
                  total > 0
                      ? '$total employé${total > 1 ? 's' : ''} dans ce groupe'
                      : 'Aucun employé dans ce groupe',
                  fontSize: 11.rsp,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            icon: Icon(Icons.close, size: 20.rsp, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

// ─── Filter bar ──────────────────────────────────────────────────────────────

class _FilterBar extends StatelessWidget {
  final int selectedIndex;
  final int total;
  final ValueChanged<int> onChanged;

  const _FilterBar({
    required this.selectedIndex,
    required this.total,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (label: 'Tous', count: total > 0 ? total : null),
      (label: 'Active', count: null),
      (label: 'Inactive', count: null),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 24.rw),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final tab = tabs[i];
          return Padding(
            padding: EdgeInsets.only(right: 8.rw),
            child: _FilterChip(
              label: tab.label,
              count: tab.count,
              isSelected: selectedIndex == i,
              onTap: () => onChanged(i),
            ),
          );
        }),
      ),
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
    final text = count != null ? '$label ($count)' : label;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 6.rh),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(999.rr),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.gray,
            width: isSelected ? 1.5 : 1.2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13.rsp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

// ─── Source table ─────────────────────────────────────────────────────────────

class _SourceGroupEmployees extends AppTableSource<EmployeeModel> {
  @override
  final List<EmployeeModel> rows;

  _SourceGroupEmployees({required this.rows});

  @override
  List<({String label, int flex})> get columns => [
    (label: 'Employé', flex: 5),
    (label: 'Poste',   flex: 4),
    (label: 'Numéros', flex: 5),
    (label: 'Statut',  flex: 3),
  ];

  @override
  void onRowTap(BuildContext context, EmployeeModel item) {}

  @override
  List<Widget> buildRow(EmployeeModel e) => [
    CellTextTable(
      text: '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim(),
      sub: e.phone,
    ),
    CellTextTable(text: e.position ?? '-'),
    CellTextTable(
      text: e.fleetNumbers?.isNotEmpty == true
          ? e.fleetNumbers!.map((f) => f.msisdn ?? '').join('\n')
          : '-',
    ),
    _statusBadge(e.status),
  ];

  Widget _statusBadge(String? status) {
    return switch (status?.toLowerCase()) {
      'active'   => CellBadgeTable.actif(),
      'inactive' => CellBadgeTable.inactif(),
      'paused'   => CellBadgeTable.enAttente(),
      _          => CellBadgeTable.inactif(),
    };
  }
}
