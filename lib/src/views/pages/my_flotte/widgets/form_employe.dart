import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/app_validators.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/domain/usecases/number_usecase.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/flotte_number/flotte_number_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/multi_select_field.dart';
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
            child: FormEmploye(
              myFlotteCubit: myFlotteCubit,
              onCreated: onCreated,
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
  final flotteNumberCubit = getIt<FlotteNumberCubit>();
  final numberUsecase = getIt<NumberUsecase>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  int? _selectedGroupId;
  List<int> _selectedFleetNumberIds = [];
  final _formKey = GlobalKey<FormState>();
  int _formSectionKey = 0;

  @override
  void initState() {
    super.initState();
    groupCubit.getGroups(data: {'page': 1});
    flotteNumberCubit.getNumbers(data: {'status': 'UNASSIGNED'});
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  void _reset() {
    _formKey.currentState?.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _positionController.clear();
    setState(() {
      _selectedGroupId = null;
      _selectedFleetNumberIds = [];
      _formSectionKey++;
    });
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final missing = <String>[];
    if (_selectedFleetNumberIds.isEmpty) missing.add('Numéros de téléphone');

    if (!formValid || missing.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            missing.isNotEmpty
                ? 'Champs obligatoires manquants : ${missing.join(', ')}'
                : 'Veuillez corriger les erreurs du formulaire',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    widget.myFlotteCubit.createEmployee(data: {
      'first_name': _firstNameController.text.trim(),
      'last_name': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'fleet_number_ids': _selectedFleetNumberIds,
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
            Navigator.of(context, rootNavigator: true).pop();
          },
          createEmployeeFailed: (message) {},
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
        child: KeyedSubtree(
          key: ValueKey(_formSectionKey),
          child: Container(
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
                              'Nouvel employé',
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
                              'PRÉNOM · NOM · EMAIL · POSTE · NUMÉROS',
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
                                isRequired: true,
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
                                isRequired: true,
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
                          isRequired: true,
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
                          isRequired: true,
                          hintText: 'Ex: Directeur Commercial',
                          validator: (v) => (v == null || v.trim().isEmpty) ? 'Le poste est obligatoire' : null,
                        ),
                        SizedBox(height: 16.rh),
                        BlocBuilder<FlotteNumberCubit, FlotteNumberState>(
                          bloc: flotteNumberCubit,
                          builder: (context, numberState) {
                            List<FlotteNumberModel> numbers = [];
                            if (numberState is GetNumbersLoaded) {
                              numbers = numberState.data.data?.numbers ?? [];
                            }
                            final options = numbers
                                .map((n) => SelectOptionModel<int>(
                                      label: n.msisdn ?? '---',
                                      value: n.id ?? 0,
                                    ))
                                .toList();
                            return MultiSelectField<int>(
                              label: 'Numéros de téléphone',
                              placeholder: numberState is GetNumbersLoading ? 'Chargement...' : 'Choisir des numéros',
                              options: options,
                              searchMode: SelectSearchMode.api,
                              onSearch: (query) async {
                                final result = await numberUsecase.getNumbers(
                                  data: {'status': 'UNASSIGNED', 'search': query},
                                );
                                return result.fold(
                                  (_) => [],
                                  (data) => (data.data?.numbers ?? [])
                                      .map((n) => SelectOptionModel<int>(label: n.msisdn ?? '---', value: n.id ?? 0))
                                      .toList(),
                                );
                              },
                              onChanged: (selected) => setState(() => _selectedFleetNumberIds = selected.map((o) => o.value).toList()),
                            );
                          },
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
                            return SelectField<int>(
                              label: 'Groupe',
                              placeholder: groupState is GetGroupsLoading ? 'Chargement...' : 'Choisir un groupe (optionnel)',
                              options: options,
                              onChanged: (opt) => setState(() => _selectedGroupId = opt.value),
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
                  child: BlocBuilder<MyFlotteCubit, MyFlotteState>(
                    bloc: widget.myFlotteCubit,
                    builder: (context, state) {
                      final isLoading = state is CreateEmployeeLoading;
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
                              text: isLoading ? 'Création...' : '+ Créer l\'employé',
                              type: AppButtonType.secondary,
                              fontSize: 14.rsp,
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
      ),
    );
  }
}
