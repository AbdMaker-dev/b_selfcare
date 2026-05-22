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
    showDetailDialog(
      context,
      width: 500.rw,
      child: FormAssignNumero(numero: numero, flotteNumberCubit: flotteNumberCubit),
    );
  }

  @override
  State<FormAssignNumero> createState() => _FormAssignNumeroState();
}

class _FormAssignNumeroState extends State<FormAssignNumero> {
  final _myFlotteCubit = getIt<MyFlotteCubit>();
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
            getEmployeesLoaded: (data) {
              setState(() {
                _employees = data.data?.employees ?? [];
              });
            },
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

              return DetailContainer(children: [
                // Header
                Row(children: [
                  Container(
                    padding: EdgeInsets.all(10.rw),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.rr),
                    ),
                    child: Icon(Icons.person_add_outlined, color: AppColors.primary, size: 24.rsp),
                  ),
                  SizedBox(width: 14.rw),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText('Assigner le numéro', fontSize: 16.rsp, fontWeight: FontWeight.w700, color: AppColors.textHeading),
                        SizedBox(height: 3.rh),
                        AppText(widget.numero.msisdn ?? '---', fontSize: 13.rsp, color: AppColors.textMuted),
                      ],
                    ),
                  ),
                ]),
                SizedBox(height: 20.rh),
                const DetailDivider(),
                SizedBox(height: 20.rh),

                // Sélection d'employé
                if (isLoadingEmployees)
                  Center(child: CircularProgressIndicator(color: AppColors.primary))
                else
                  SelectField<EmployeeModel>(
                    label: 'Employé *',
                    options: options,
                    placeholder: 'Sélectionner un employé...',
                    onChanged: (opt) => setState(() => _selectedEmployee = opt.value),
                  ),

                SizedBox(height: 24.rh),
                const DetailDivider(),
                SizedBox(height: 16.rh),

                // Actions
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DetailActionBtn(
                      label: 'Annuler',
                      type: AppButtonType.outline,
                      width: 120,
                      onPressed: isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                    ),
                    SizedBox(width: 10.rw),
                    DetailActionBtn(
                      label: 'Assigner',
                      icon: Icons.person_add_outlined,
                      onPressed: (isLoading || _selectedEmployee == null) ? null : _submit,
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
