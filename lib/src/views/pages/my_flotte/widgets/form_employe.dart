import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_validators.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormEmploye extends StatefulWidget {
  final MyFlotteCubit myFlotteCubit;
  final VoidCallback? onCreated;

  const FormEmploye({
    super.key,
    required this.myFlotteCubit,
    this.onCreated,
  });

  static void show(
    BuildContext context, {
    required MyFlotteCubit myFlotteCubit,
    VoidCallback? onCreated,
  }) {
    showDialog<void>(
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
            child: FormEmploye(
              myFlotteCubit: myFlotteCubit,
              onCreated: () {
                Navigator.of(context, rootNavigator: true).pop();
                onCreated?.call();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<FormEmploye> createState() => _FormEmployeState();
}

class _FormEmployeState extends State<FormEmploye> {
  final groupCubit = getIt<GroupCubit>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  int? _selectedGroupId;
  final _formKey = GlobalKey<FormState>();
  int _formSectionKey = 0;

  @override
  void initState() {
    super.initState();
    groupCubit.getGroups(data: {'page': 1});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _reset() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    _positionController.clear();
    setState(() {
      _selectedGroupId = null;
      _formSectionKey++;
    });
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;

    if (!formValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez corriger les erreurs du formulaire'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    widget.myFlotteCubit.createEmployee(data: {
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phone': _phoneController.text.trim(),
      'position': _positionController.text.trim(),
      if (_selectedGroupId != null) 'group_id': _selectedGroupId,
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: widget.myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          createEmployeeLoaded: (_) {
            _reset();
            widget.onCreated?.call();
          },
          createEmployeeFailed: (message) {

          },
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: KeyedSubtree(
          key: ValueKey(_formSectionKey),
          child: Container(
            padding: EdgeInsets.all(12.rw),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.rr),
              border: Border.all(color: AppColors.gray),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Ajouter un employé',
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
                      child: AppInput(
                        labelText: 'Téléphone',
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        hintText: 'Ex: +221 76 000 00 00',
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Le téléphone est obligatoire' : null,
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
                          if (groupState is GetGroupsLoaded) {
                            groupData = groupState.data;
                          }
                          final groups = groupData?.data?.groups ?? [];
                          final options = groups
                              .map((g) => SelectOptionModel<int>(
                                    label: g.name ?? '---',
                                    value: g.id ?? 0,
                                  ))
                              .toList();
                          return SelectField<int>(
                            label: 'Groupe',
                            placeholder: groupState is GetGroupsLoading
                                ? 'Chargement...'
                                : 'Choisir un groupe (optionnel)',
                            options: options,
                            onChanged: (opt) =>
                                setState(() => _selectedGroupId = opt.value),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.rh),
                BlocBuilder<MyFlotteCubit, MyFlotteState>(
                  bloc: widget.myFlotteCubit,
                  builder: (context, state) {
                    final isLoading = state is CreateEmployeeLoading;
                    return SizedBox(
                      width: 250.rw,
                      child: AppButton(
                        text: isLoading ? 'Création...' : 'Créer l\'employé',
                        type: AppButtonType.secondary,
                        onPressed: isLoading ? null : _submit,
                        fontSize: 15.rsp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
