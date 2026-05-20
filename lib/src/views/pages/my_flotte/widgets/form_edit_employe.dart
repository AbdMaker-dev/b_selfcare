import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_validators.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/phone_number_widget.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormEditEmploye extends StatefulWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;

  const FormEditEmploye({
    super.key,
    required this.employee,
    required this.myFlotteCubit,
  });

  static void show(
    BuildContext context, {
    required EmployeeModel employee,
    required MyFlotteCubit myFlotteCubit,
    VoidCallback? onUpdated,
  }) {
    showDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.rr),
        ),
        child: SizedBox(
          width: 750.rw,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.rw),
            child: FormEditEmploye(
              employee: employee,
              myFlotteCubit: myFlotteCubit,
            ),
          ),
        ),
      ),
    ).then((updated) { if (updated == true) onUpdated?.call(); });
  }

  @override
  State<FormEditEmploye> createState() => _FormEditEmployeState();
}

class _FormEditEmployeState extends State<FormEditEmploye> {
  final groupCubit = getIt<GroupCubit>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _positionController;

  int? _selectedGroupId;
  bool _removeGroup = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.employee.firstName ?? '');
    _lastNameController  = TextEditingController(text: widget.employee.lastName ?? '');
    _emailController     = TextEditingController(text: widget.employee.email ?? '');
    _positionController  = TextEditingController(text: widget.employee.position ?? '');
    _selectedGroupId     = widget.employee.group?.id;
    groupCubit.getGroups(data: {'page': 1});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) return;

    final id = widget.employee.id;
    if (id == null) return;

    widget.myFlotteCubit.updateEmployee(
      id: id,
      data: {
        'first_name': _firstNameController.text.trim(),
        'last_name': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'position': _positionController.text.trim(),
        if (!_removeGroup && _selectedGroupId != null) 'group_id': _selectedGroupId,
        'remove_group': _removeGroup,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: widget.myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          updateEmployeeLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(true),
          updateEmployeeFailed: (message) {},
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(12.rw),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.rr),
            border: Border.all(color: AppColors.gray),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Modifier l\'employé',
                fontSize: 18.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: 'Prénom',
                      keyboardType: TextInputType.text,
                      controller: _firstNameController,
                      hintText: 'Ex: Ousman',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Le prénom est obligatoire' : null,
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: AppInput(
                      labelText: 'Nom',
                      keyboardType: TextInputType.text,
                      controller: _lastNameController,
                      hintText: 'Ex: Diallo',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Le nom est obligatoire' : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      hintText: 'Ex: ousman@example.com',
                      validator: AppValidators.email(context),
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: _FleetNumbersReadOnly(
                      fleetNumbers: widget.employee.fleetNumbers
                              ?.map((f) => f.msisdn ?? '')
                              .where((m) => m.isNotEmpty)
                              .toList() ??
                          [],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: 'Poste',
                      keyboardType: TextInputType.text,
                      controller: _positionController,
                      hintText: 'Ex: Directeur Commercial',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Le poste est obligatoire' : null,
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: BlocBuilder<GroupCubit, GroupState>(
                      bloc: groupCubit,
                      builder: (context, groupState) {
                        DataGroupResponseModel? groupData;
                        if (groupState is GetGroupsLoaded) groupData = groupState.data;
                        final groups = groupData?.data?.groups ?? [];
                        final options = groups
                            .map((g) => SelectOptionModel<int>(
                                  label: g.name ?? '---',
                                  value: g.id ?? 0,
                                ))
                            .toList();
                        final currentGroup = widget.employee.group;
                        return Opacity(
                          opacity: _removeGroup ? 0.4 : 1.0,
                          child: IgnorePointer(
                            ignoring: _removeGroup,
                            child: SelectField<int>(
                              label: 'Groupe',
                              placeholder: groupState is GetGroupsLoading
                                  ? 'Chargement...'
                                  : currentGroup?.name ?? 'Choisir un groupe',
                              options: options,
                              onChanged: (opt) =>
                                  setState(() => _selectedGroupId = opt.value),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              _RemoveGroupToggle(
                value: _removeGroup,
                onChanged: (val) => setState(() {
                  _removeGroup = val;
                  if (val) _selectedGroupId = null;
                }),
              ),
              SizedBox(height: 24.rh),
              BlocBuilder<MyFlotteCubit, MyFlotteState>(
                bloc: widget.myFlotteCubit,
                builder: (context, state) {
                  final isLoading = state is UpdateEmployeeLoading;
                  return SizedBox(
                    width: 250.rw,
                    child: AppButton(
                      text: isLoading ? 'Mise à jour...' : 'Enregistrer les modifications',
                      type: AppButtonType.secondary,
                      fontSize: 12.rsp,
                      onPressed: isLoading ? null : _submit,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FleetNumbersReadOnly extends StatelessWidget {
  final List<String> fleetNumbers;

  const _FleetNumbersReadOnly({required this.fleetNumbers});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          'NUMÉROS DE TÉLÉPHONE',
          color: AppColors.grayAsh,
          fontWeight: FontWeight.w600,
          fontSize: 10.rsp,
        ),
        SizedBox(height: 6.rh),
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
          decoration: BoxDecoration(
            color: AppColors.grayWh,
            borderRadius: BorderRadius.circular(10.rr),
            border: Border.all(color: AppColors.gray),
          ),
          child: fleetNumbers.isEmpty
              ? AppText('-', fontSize: 14.rsp, color: AppColors.grayAsh)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: fleetNumbers
                      .map((msisdn) => Padding(
                            padding: EdgeInsets.only(bottom: 4.rh),
                            child: PhoneNumberWidget(phone: msisdn),
                          ))
                      .toList(),
                ),
        ),
      ],
    );
  }
}

class _RemoveGroupToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RemoveGroupToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'RETIRER LE GROUPE',
          color: AppColors.grayAsh,
          fontWeight: FontWeight.w600,
          fontSize: 10.rsp,
        ),
        SizedBox(height: 6.rh),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            constraints: const BoxConstraints(minHeight: kMinInteractiveDimension),
            padding: EdgeInsets.symmetric(horizontal: 14.rw),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: AppColors.grayWh,
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(
                color: value ? AppColors.error : AppColors.gray,
              ),
            ),
            child: Row(
              children: [
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: AppColors.error,
                ),
                SizedBox(width: 8.rw),
                AppText(
                  value ? 'Groupe retiré' : 'Conserver le groupe',
                  fontSize: 14.rsp,
                  color: value ? AppColors.error : AppColors.textHeading,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
