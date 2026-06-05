import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/domain/usecases/employee_usecase.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormAssignNumero extends StatefulWidget {
  final FlotteNumberModel numero;
  final FlotteNumberCubit flotteNumberCubit;

  const FormAssignNumero({
    super.key,
    required this.numero,
    required this.flotteNumberCubit,
  });

  static void show(
    BuildContext context, {
    required FlotteNumberModel numero,
    required FlotteNumberCubit flotteNumberCubit,
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
            child: FormAssignNumero(numero: numero, flotteNumberCubit: flotteNumberCubit),
          ),
        ),
      ),
    );
  }

  @override
  State<FormAssignNumero> createState() => _FormAssignNumeroState();
}

class _FormAssignNumeroState extends State<FormAssignNumero> {
  final _myFlotteCubit = getIt<MyFlotteCubit>();
  final _employeeUsecase = getIt<EmployeeUsecase>();
  EmployeeModel? _selectedEmployee;
  List<EmployeeModel> _employees = [];

  @override
  void initState() {
    super.initState();
    _myFlotteCubit.getEmployees(data: {'per_page': 100, 'status': 'ACTIVE'});
  }

  void _submit() {
    if (widget.numero.id == null || _selectedEmployee?.id == null) return;
    widget.flotteNumberCubit.assignNumber(
      id: widget.numero.id!,
      data: {'employee_id': _selectedEmployee!.id},
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FlotteNumberCubit, FlotteNumberState>(
      bloc: widget.flotteNumberCubit,
      listener: (context, state) {
        state.maybeWhen(
          assignNumberLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: BlocConsumer<MyFlotteCubit, MyFlotteState>(
        bloc: _myFlotteCubit,
        listener: (context, state) {
          state.maybeWhen(
            getEmployeesLoaded: (data) =>
                setState(() => _employees = data.data?.employees ?? []),
            orElse: () {},
          );
        },
        builder: (context, employeeState) {
          return BlocBuilder<FlotteNumberCubit, FlotteNumberState>(
            bloc: widget.flotteNumberCubit,
            builder: (context, state) {
              final isLoading = state is AssignNumberLoading;
              final isLoadingEmployees = employeeState is GetEmployeesLoading;

              final options = _employees
                  .map((e) => SelectOptionModel<EmployeeModel>(
                        label: '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim(),
                        value: e,
                        subtitle: e.position,
                      ))
                  .toList();

              return Container(
                height: double.infinity.rh,
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
                                  'Assigner numéro',
                                  fontSize: 24.rsp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grayAsh,
                                  highlight: 'numéro',
                                  fontFamily: FontFamily.syne,
                                  highlightColor: AppColors.primary,
                                  highlightFontSize: 24.rsp,
                                ),
                                SizedBox(height: 4.rh),
                                AppText(
                                  widget.numero.msisdn ?? '---',
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
                              padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.graySilver),
                              ),
                              child: AppText(
                                'X',
                                fontSize: 13.rsp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
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
                              'SÉLECTION DE L\'EMPLOYÉ',
                              fontSize: 11.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                            SizedBox(height: 12.rh),
                            if (isLoadingEmployees)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24.rh),
                                  child: CircularProgressIndicator(color: AppColors.primary),
                                ),
                              )
                            else
                              SelectField<EmployeeModel>(
                                label: 'Employé',
                                options: options,
                                placeholder: 'Sélectionner un employé...',
                                onChanged: (opt) => setState(() => _selectedEmployee = opt.value),
                                searchMode: SelectSearchMode.api,
                                onSearch: (query) async {
                                  final result = await _employeeUsecase.getEmployees(
                                    data: {'status': 'ACTIVE', 'search': query},
                                  );
                                  return result.fold(
                                    (_) => [],
                                    (data) => (data.data?.employees ?? [])
                                        .map((e) => SelectOptionModel<EmployeeModel>(
                                              label: '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim(),
                                              value: e,
                                              subtitle: e.position,
                                            ))
                                        .toList(),
                                  );
                                },
                              ),
                            SizedBox(height: 24.rh),
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
                          Expanded(
                            child: AppButton(
                              text: 'Annuler',
                              type: AppButtonType.outline,
                              fontSize: 14.rsp,
                              onPressed: isLoading
                                  ? null
                                  : () => Navigator.of(context, rootNavigator: true).pop(),
                            ),
                          ),
                          SizedBox(width: 12.rw),
                          Expanded(
                            flex: 2,
                            child: AppButton(
                              text: isLoading ? 'Assignation...' : '+ Assigner le numéro',
                              type: AppButtonType.secondary,
                              fontSize: 14.rsp,
                              onPressed: (isLoading || _selectedEmployee == null) ? null : _submit,
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
