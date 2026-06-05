import 'package:b_selfcare/gen/fonts.gen.dart';
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
            width: 650.rw,
            height: double.infinity,
            child: FormEditEmploye(
              employee: employee,
              myFlotteCubit: myFlotteCubit,
            ),
          ),
        ),
      ),
    ).then((_) => onUpdated?.call());
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
          updateEmployeeLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          updateEmployeeFailed: (message) {},
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: Container(
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
                            'Modifier employé',
                            fontSize: 24.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayAsh,
                            highlight: 'employé',
                            fontFamily: FontFamily.syne,
                            highlightColor: AppColors.primary,
                            highlightFontSize: 24.rsp,
                          ),
                          SizedBox(height: 4.rh),
                          AppText(
                            '${widget.employee.firstName ?? ''} ${widget.employee.lastName ?? ''}'.trim(),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.rh),
                      AppText('IDENTITÉ', fontSize: 11.rsp, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                      SizedBox(height: 12.rh),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppInput(
                              labelText: 'Prénom',
                              keyboardType: TextInputType.text,
                              controller: _firstNameController,
                              hintText: 'Ex: Ousman',
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Le prénom est obligatoire' : null,
                            ),
                          ),
                          SizedBox(width: 16.rw),
                          Expanded(
                            child: AppInput(
                              labelText: 'Nom',
                              keyboardType: TextInputType.text,
                              controller: _lastNameController,
                              hintText: 'Ex: Diallo',
                              validator: (v) => (v == null || v.trim().isEmpty) ? 'Le nom est obligatoire' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.rh),
                      AppInput(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        hintText: 'Ex: ousman@example.com',
                        validator: AppValidators.email(context),
                      ),
                      SizedBox(height: 24.rh),
                      AppText('AFFECTATION', fontSize: 11.rsp, fontWeight: FontWeight.w600, color: AppColors.textMuted),
                      SizedBox(height: 12.rh),
                      AppInput(
                        labelText: 'Poste',
                        keyboardType: TextInputType.text,
                        controller: _positionController,
                        hintText: 'Ex: Directeur Commercial',
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Le poste est obligatoire' : null,
                      ),
                      SizedBox(height: 16.rh),
                      _FleetNumbersReadOnly(
                        fleetNumbers: widget.employee.fleetNumbers
                                ?.map((f) => f.msisdn ?? '')
                                .where((m) => m.isNotEmpty)
                                .toList() ??
                            [],
                      ),
                      SizedBox(height: 16.rh),
                      BlocBuilder<GroupCubit, GroupState>(
                        bloc: groupCubit,
                        builder: (context, groupState) {
                          DataGroupResponseModel? groupData;
                          if (groupState is GetGroupsLoaded) groupData = groupState.data;
                          final groups = groupData?.data?.groups ?? [];
                          final options = groups
                              .map((g) => SelectOptionModel<int>(label: g.name ?? '---', value: g.id ?? 0))
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
                                onChanged: (opt) => setState(() => _selectedGroupId = opt.value),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.rh),
                      _RemoveGroupToggle(
                        value: _removeGroup,
                        onChanged: (val) => setState(() {
                          _removeGroup = val;
                          if (val) _selectedGroupId = null;
                        }),
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
                child: BlocBuilder<MyFlotteCubit, MyFlotteState>(
                  bloc: widget.myFlotteCubit,
                  builder: (context, state) {
                    final isLoading = state is UpdateEmployeeLoading;
                    return Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Annuler',
                            type: AppButtonType.outline,
                            fontSize: 14.rsp,
                            onPressed: isLoading ? null : () => Navigator.of(context, rootNavigator: true).pop(),
                          ),
                        ),
                        SizedBox(width: 12.rw),
                        Expanded(
                          flex: 2,
                          child: AppButton(
                            text: isLoading ? 'Mise à jour...' : '+ Enregistrer les modifications',
                            type: AppButtonType.secondary,
                            fontSize: 13.rsp,
                            onPressed: isLoading ? null : _submit,
                          ),
                        ),
                      ],
                    );
                  },
                ),
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
        AppText('NUMÉROS DE TÉLÉPHONE', color: AppColors.grayAsh, fontWeight: FontWeight.w600, fontSize: 10.rsp),
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
        AppText('RETIRER LE GROUPE', color: AppColors.grayAsh, fontWeight: FontWeight.w600, fontSize: 10.rsp),
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
              border: Border.all(color: value ? AppColors.error : AppColors.gray),
            ),
            child: Row(
              children: [
                Switch(value: value, onChanged: onChanged, activeColor: AppColors.error),
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
