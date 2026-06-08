import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/users/cubit/users_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserForm extends StatefulWidget {
  final UserProfileModel? user;

  const UserForm({super.key, this.user});

  static void show(BuildContext context, {UserProfileModel? user}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (_, _, _) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: UserForm(user: user),
          ),
        ),
      ),
    );
  }

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _cubit   = getIt<UsersCubit>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _msisdnCtrl;

  int?    _selectedRoleId;
  String? _selectedStatus;

  bool get _isEdit => widget.user != null;

  List<SelectOptionModel<int>> get _roleOptions => _cubit.roles
      .map((r) => SelectOptionModel<int>(
            label: r.displayName ?? r.name ?? '—',
            value: r.id,
          ))
      .toList();

  static const _statuses = [
    SelectOptionModel<String>(label: 'Actif',   value: 'ACTIVE'),
    SelectOptionModel<String>(label: 'Inactif', value: 'INACTIVE'),
  ];

  @override
  void initState() {
    super.initState();
    final u = widget.user;
    _firstNameCtrl = TextEditingController(text: u?.firstName ?? '');
    _lastNameCtrl  = TextEditingController(text: u?.lastName  ?? '');
    _emailCtrl     = TextEditingController(text: u?.email     ?? '');
    _msisdnCtrl    = TextEditingController(text: u?.msisdn    ?? '');
    _selectedRoleId = u?.roles.firstOrNull?.id;
    _selectedStatus = u?.status ?? 'ACTIVE';
    _cubit.fetchRoles().then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _msisdnCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid || _selectedRoleId == null) {
      if (_selectedRoleId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Veuillez sélectionner un rôle'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      return;
    }

    final payload = {
      'first_name': _firstNameCtrl.text.trim(),
      'last_name':  _lastNameCtrl.text.trim(),
      'email':      _emailCtrl.text.trim(),
      'msisdn':     _msisdnCtrl.text.trim(),
      'roles':      [_selectedRoleId],
    };

    if (_isEdit) {
      _cubit.updateUser(
        id: widget.user!.id!,
        data: {...payload, 'status': _selectedStatus ?? 'ACTIVE'},
      );
    } else {
      _cubit.createUser(data: payload);
    }
  }

  SelectOptionModel<int>? get _initialRole {
    if (_selectedRoleId == null) return null;
    try {
      return _roleOptions.firstWhere((r) => r.value == _selectedRoleId);
    } catch (_) {
      return null;
    }
  }

  SelectOptionModel<String>? get _initialStatus {
    if (_selectedStatus == null) return null;
    try {
      return _statuses.firstWhere((s) => s.value == _selectedStatus);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersCubit, UsersState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          createUserLoaded: () => Navigator.of(context, rootNavigator: true).pop(),
          updateUserLoaded: () => Navigator.of(context, rootNavigator: true).pop(),
          orElse: () {},
        );
      },
      child: Form(
        key: _formKey,
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
                            _isEdit ? 'Modifier l\'utilisateur' : 'Nouvel utilisateur',
                            fontSize: 24.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayAsh,
                            highlight: _isEdit ? 'utilisateur' : 'utilisateur',
                            fontFamily: FontFamily.syne,
                            highlightColor: AppColors.primary,
                            highlightFontSize: 24.rsp,
                          ),
                          SizedBox(height: 4.rh),
                          AppText(
                            'PRÉNOM · NOM · EMAIL · TÉLÉPHONE · RÔLE',
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

              // BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 20.rh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'INFORMATIONS PERSONNELLES',
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(height: 12.rh),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppInput(
                              labelText: 'Prénom',
                              controller: _firstNameCtrl,
                              hintText: 'Ex: Alioune Badara',
                              keyboardType: TextInputType.name,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
                            ),
                          ),
                          SizedBox(width: 16.rw),
                          Expanded(
                            child: AppInput(
                              labelText: 'Nom',
                              controller: _lastNameCtrl,
                              hintText: 'Ex: DIOUF',
                              keyboardType: TextInputType.name,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.rh),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AppInput(
                              labelText: 'Email',
                              controller: _emailCtrl,
                              hintText: 'Ex: prenom.nom@entreprise.sn',
                              keyboardType: TextInputType.emailAddress,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Champ obligatoire';
                                if (!v.contains('@')) return 'Email invalide';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 16.rw),
                          Expanded(
                            child: AppInput(
                              labelText: 'Téléphone (MSISDN)',
                              controller: _msisdnCtrl,
                              hintText: 'Ex: 770000000',
                              keyboardType: TextInputType.phone,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.rh),
                      AppText(
                        'ACCÈS ET PERMISSIONS',
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(height: 12.rh),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SelectField<int>(
                              label: 'Rôle',
                              placeholder: 'Choisir un rôle',
                              options: _roleOptions,
                              initialValue: _initialRole,
                              onChanged: (opt) => setState(() => _selectedRoleId = opt.value),
                            ),
                          ),
                          if (_isEdit) ...[
                            SizedBox(width: 16.rw),
                            Expanded(
                              child: SelectField<String>(
                                label: 'Statut',
                                placeholder: 'Choisir un statut',
                                options: _statuses,
                                initialValue: _initialStatus,
                                onChanged: (opt) => setState(() => _selectedStatus = opt.value),
                              ),
                            ),
                          ] else
                            const Expanded(child: SizedBox()),
                        ],
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
                child: BlocBuilder<UsersCubit, UsersState>(
                  bloc: _cubit,
                  builder: (context, state) {
                    final isLoading = state is CreateUserLoading || state is UpdateUserLoading;
                    return Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Annuler',
                            type: AppButtonType.outline,
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
                            fontSize: 15.rsp,
                          ),
                        ),
                        SizedBox(width: 12.rw),
                        Expanded(
                          flex: 2,
                          child: AppButton(
                            text: isLoading
                                ? 'Chargement...'
                                : _isEdit
                                    ? 'Enregistrer les modifications'
                                    : '+ Créer l\'utilisateur',
                            type: AppButtonType.secondary,
                            onPressed: isLoading ? null : _submit,
                            fontSize: 15.rsp,
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
