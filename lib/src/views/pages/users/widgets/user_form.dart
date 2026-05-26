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

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _cubit    = getIt<UsersCubit>();
  final _formKey  = GlobalKey<FormState>();

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
          padding: EdgeInsets.all(24.rw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                _isEdit ? 'Modifier l\'utilisateur' : 'Créer un utilisateur',
                fontSize: 18.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              SizedBox(height: 24.rh),
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
              SizedBox(height: 20.rh),
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
              SizedBox(height: 20.rh),
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
              SizedBox(height: 28.rh),
              BlocBuilder<UsersCubit, UsersState>(
                bloc: _cubit,
                builder: (context, state) {
                  final isLoading = state is CreateUserLoading || state is UpdateUserLoading;
                  return SizedBox(
                    width: 220.rw,
                    child: AppButton(
                      text: _isEdit ? 'Enregistrer' : 'Créer l\'utilisateur',
                      type: AppButtonType.secondary,
                      onPressed: isLoading ? null : _submit,
                      fontSize: 14.rsp,
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
