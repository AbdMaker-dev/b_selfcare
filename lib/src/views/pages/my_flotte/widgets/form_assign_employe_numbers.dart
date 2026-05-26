import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/detail_components.dart';
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
    showDetailDialog(
      context,
      width: 530.rw,
      child: FormAssignEmployeNumbers(employee: employee, myFlotteCubit: myFlotteCubit),
    );
  }

  @override
  State<FormAssignEmployeNumbers> createState() => _FormAssignEmployeNumbersState();
}

class _FormAssignEmployeNumbersState extends State<FormAssignEmployeNumbers> {
  final _flotteNumberCubit = getIt<FlotteNumberCubit>();
  List<FlotteNumberModel> _availableNumbers = [];
  final Set<int> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _flotteNumberCubit.getNumbers(data: {'status': 'UNASSIGNED'});
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
            getNumbersLoaded: (data) {
              setState(() {
                _availableNumbers = (data.data?.numbers ?? [])
                    .where((n) => n.employee == null)
                    .toList();
              });
            },
            orElse: () {},
          );
        },
        builder: (context, numberState) {
          return BlocBuilder<MyFlotteCubit, MyFlotteState>(
            bloc: widget.myFlotteCubit,
            builder: (context, myFlotteState) {
              final isSubmitting = myFlotteState is AssignNumbersLoading;
              final isLoadingNumbers = numberState is GetNumbersLoading;

              return DetailContainer(children: [
                // Header
                Row(children: [
                  Container(
                    padding: EdgeInsets.all(10.rw),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.rr),
                    ),
                    child: Icon(Icons.sim_card_outlined, color: AppColors.primary, size: 24.rsp),
                  ),
                  SizedBox(width: 14.rw),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText('Assigner des numéros', fontSize: 16.rsp, fontWeight: FontWeight.w700, color: AppColors.textHeading),
                        SizedBox(height: 3.rh),
                        AppText(
                          fullName.isNotEmpty ? fullName : widget.employee.email ?? '---',
                          fontSize: 13.rsp,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ),
                ]),
                SizedBox(height: 20.rh),
                const DetailDivider(),
                SizedBox(height: 16.rh),

                // Liste des numéros
                if (isLoadingNumbers)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.rh),
                      child: CircularProgressIndicator(color: AppColors.primary),
                    ),
                  )
                else if (_availableNumbers.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.rh),
                    child: Center(
                      child: AppText(
                        'Aucun numéro disponible',
                        fontSize: 14.rsp,
                        color: AppColors.textMuted,
                      ),
                    ),
                  )
                else
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300.rh),
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _availableNumbers.length,
                      separatorBuilder: (_, __) => Divider(height: 1, color: AppColors.gray),
                      itemBuilder: (context, i) {
                        final n = _availableNumbers[i];
                        final selected = _selectedIds.contains(n.id);
                        return InkWell(
                          onTap: n.id != null ? () => _toggle(n.id!) : null,
                          borderRadius: BorderRadius.circular(6.rr),
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
                                AppText(
                                  n.msisdn ?? '---',
                                  fontSize: 14.rsp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textHeading,
                                ),
                                if (n.iccid != null) ...[
                                  SizedBox(width: 10.rw),
                                  AppText(
                                    n.iccid!,
                                    fontSize: 11.rsp,
                                    color: AppColors.textMuted,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                SizedBox(height: 16.rh),
                const DetailDivider(),
                SizedBox(height: 16.rh),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_selectedIds.isNotEmpty)
                      AppText(
                        '${_selectedIds.length} sélectionné${_selectedIds.length > 1 ? 's' : ''}',
                        fontSize: 13.rsp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      )
                    else
                      const SizedBox.shrink(),
                    Row(
                      children: [
                        DetailActionBtn(
                          label: 'Annuler',
                          type: AppButtonType.outline,
                          width: 120.rw,
                          onPressed: isSubmitting ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                        ),
                        SizedBox(width: 10.rw),
                        DetailActionBtn(
                          width: 150.rw,
                          label: isSubmitting ? 'Assignation...' : 'Assigner',
                          icon: Icons.check,
                          onPressed: (isSubmitting || _selectedIds.isEmpty) ? null : _submit,
                        ),
                      ],
                    ),
                  ],
                ),
              ]);
            },
          );
        },
      ),
    );
  }
}
