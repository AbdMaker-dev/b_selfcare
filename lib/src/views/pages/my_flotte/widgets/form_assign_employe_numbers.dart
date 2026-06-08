import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAssignEmployeNumbers extends StatefulWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;

  const FormAssignEmployeNumbers({
    super.key,
    required this.employee,
    required this.myFlotteCubit,
  });

  static void show(
    BuildContext context, {
    required EmployeeModel employee,
    required MyFlotteCubit myFlotteCubit,
  }) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, __, ___) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 550.rw,
            height: double.infinity,
            child: FormAssignEmployeNumbers(employee: employee, myFlotteCubit: myFlotteCubit),
          ),
        ),
      ),
    );
  }

  @override
  State<FormAssignEmployeNumbers> createState() => _FormAssignEmployeNumbersState();
}

class _FormAssignEmployeNumbersState extends State<FormAssignEmployeNumbers> {
  final _flotteNumberCubit = getIt<FlotteNumberCubit>();
  List<FlotteNumberModel> _availableNumbers = [];
  final Set<int> _selectedIds = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _flotteNumberCubit.getNumbers(data: {'status': 'UNASSIGNED'});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggle(int id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  void _submit() {
    if (_selectedIds.isEmpty || widget.employee.id == null) return;
    widget.myFlotteCubit.assignNumbersForEmploye(
      id: widget.employee.id!,
      data: {'fleet_number_ids': _selectedIds.toList()},
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${widget.employee.firstName ?? ''} ${widget.employee.lastName ?? ''}'.trim();

    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: widget.myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          assignNumbersLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          assignNumbersFailed: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: AppColors.error),
            );
          },
          orElse: () {},
        );
      },
      child: BlocConsumer<FlotteNumberCubit, FlotteNumberState>(
        bloc: _flotteNumberCubit,
        listener: (context, state) {
          state.maybeWhen(
            getNumbersLoaded: (data) => setState(() {
              _availableNumbers = (data.data?.numbers ?? [])
                  .where((n) => n.employee == null)
                  .toList();
            }),
            orElse: () {},
          );
        },
        builder: (context, numberState) {
          return BlocBuilder<MyFlotteCubit, MyFlotteState>(
            bloc: widget.myFlotteCubit,
            builder: (context, myFlotteState) {
              final isSubmitting = myFlotteState is AssignNumbersLoading;
              final isLoadingNumbers = numberState is GetNumbersLoading;

              final filtered = _searchQuery.isEmpty
                  ? _availableNumbers
                  : _availableNumbers
                      .where((n) =>
                          (n.msisdn ?? '').contains(_searchQuery) ||
                          (n.iccid ?? '').toLowerCase().contains(_searchQuery))
                      .toList();

              return Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.rr),
                    bottomLeft: Radius.circular(12.rr),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(bottom: BorderSide(color: AppColors.gray)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText.textHighlight(
                                  'Assigner numéros',
                                  fontSize: 24.rsp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grayAsh,
                                  highlight: 'numéros',
                                  fontFamily: FontFamily.syne,
                                  highlightColor: AppColors.primary,
                                  highlightFontSize: 24.rsp,
                                ),
                                SizedBox(height: 4.rh),
                                AppText(
                                  fullName.isNotEmpty ? fullName : widget.employee.email ?? '---',
                                  fontSize: 12.rsp,
                                  color: AppColors.textMuted,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context, rootNavigator: true).pop(),
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.graySilver),
                              ),
                              child: AppText('X', fontSize: 13.rsp, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // SCROLLABLE BODY
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(16.rw),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'NUMÉROS DISPONIBLES',
                              fontSize: 11.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                            SizedBox(height: 12.rh),

                            // Recherche
                            if (!isLoadingNumbers && _availableNumbers.isNotEmpty)
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.rh),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
                                  style: TextStyle(fontSize: 14.rsp),
                                  decoration: InputDecoration(
                                    hintText: 'Rechercher un numéro...',
                                    hintStyle: TextStyle(fontSize: 13.rsp, color: AppColors.grayAsh),
                                    prefixIcon: Icon(Icons.search_rounded, size: 18, color: AppColors.grayAsh),
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 10.rh),
                                    filled: true,
                                    fillColor: AppColors.grayWh,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.rr),
                                      borderSide: BorderSide(color: AppColors.gray),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.rr),
                                      borderSide: BorderSide(color: AppColors.gray),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.rr),
                                      borderSide: BorderSide(color: AppColors.primary),
                                    ),
                                  ),
                                ),
                              ),

                            // Liste des numéros
                            if (isLoadingNumbers)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 30.rh),
                                  child: CircularProgressIndicator(color: AppColors.primary),
                                ),
                              )
                            else if (filtered.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.rh),
                                child: Center(
                                  child: AppText(
                                    _searchQuery.isEmpty ? 'Aucun numéro disponible' : 'Aucun résultat',
                                    fontSize: 14.rsp,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10.rr),
                                  border: Border.all(color: AppColors.gray),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: filtered.length,
                                  separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.gray),
                                  itemBuilder: (context, i) {
                                    final n = filtered[i];
                                    final selected = _selectedIds.contains(n.id);
                                    return InkWell(
                                      onTap: n.id != null ? () => _toggle(n.id!) : null,
                                      borderRadius: i == 0
                                          ? BorderRadius.vertical(top: Radius.circular(10.rr))
                                          : i == filtered.length - 1
                                              ? BorderRadius.vertical(bottom: Radius.circular(10.rr))
                                              : BorderRadius.zero,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 4.rw, vertical: 10.rh),
                                        child: Row(
                                          children: [
                                            Checkbox(
                                              value: selected,
                                              activeColor: AppColors.primary,
                                              onChanged: n.id != null ? (_) => _toggle(n.id!) : null,
                                            ),
                                            SizedBox(width: 8.rw),
                                            Container(
                                              width: 8.rw,
                                              height: 8.rh,
                                              decoration: BoxDecoration(
                                                color: n.status?.toUpperCase() == 'ACTIVE'
                                                    ? AppColors.success
                                                    : AppColors.grayAsh,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 8.rw),
                                            AppText(n.msisdn ?? '---', fontSize: 14.rsp, fontWeight: FontWeight.w600, color: AppColors.textHeading),
                                            if (n.iccid != null) ...[
                                              SizedBox(width: 10.rw),
                                              AppText(n.iccid!, fontSize: 11.rsp, color: AppColors.textMuted),
                                            ],
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            SizedBox(height: 16.rh),
                          ],
                        ),
                      ),
                    ),

                    // FOOTER
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border(top: BorderSide(color: AppColors.gray)),
                      ),
                      child: Row(
                        children: [
                          if (_selectedIds.isNotEmpty) ...[
                            AppText(
                              '${_selectedIds.length} sélectionné${_selectedIds.length > 1 ? 's' : ''}',
                              fontSize: 13.rsp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(width: 12.rw),
                          ],
                          Expanded(
                            child: AppButton(
                              text: 'Annuler',
                              type: AppButtonType.outline,
                              fontSize: 14.rsp,
                              onPressed: isSubmitting ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                            ),
                          ),
                          SizedBox(width: 12.rw),
                          Expanded(
                            flex: 2,
                            child: AppButton(
                              text: isSubmitting ? 'Assignation...' : '+ Assigner les numéros',
                              type: AppButtonType.secondary,
                              fontSize: 13.rsp,
                              onPressed: (isSubmitting || _selectedIds.isEmpty) ? null : _submit,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
