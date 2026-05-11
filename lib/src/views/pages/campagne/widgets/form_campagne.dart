import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';

class FormCampagne extends StatefulWidget {
  final CampagneCubit campagneCubit;
  final VoidCallback? onCreated;

  const FormCampagne({
    super.key,
    required this.campagneCubit,
    this.onCreated,
  });

  @override
  State<FormCampagne> createState() => _FormCampagneState();
}

class _FormCampagneState extends State<FormCampagne> {
  final TextEditingController _nameController = TextEditingController();

  String? _selectedFrequency;
  String? _selectedProductId;
  String? _selectedCiblage;
  final _formKey = GlobalKey<FormState>();
  int _formSectionKey = 0;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void reset() {
    _formKey.currentState?.reset();
    _nameController.clear();
    setState(() {
      _selectedFrequency = null;
      _selectedProductId = null;
      _selectedCiblage = null;
      _formSectionKey++;
    });
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final missing = <String>[];
    if (_selectedFrequency == null) missing.add('Fréquence');
    if (_selectedProductId == null) missing.add('Produit');
    if (_selectedCiblage == null) missing.add('Ciblage');

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

    // TODO: appeler campagneCubit.createCampagne(data: {...}) quand disponible
    widget.onCreated?.call();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Créer une campagne',
                fontSize: 18.rsp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AppInput(
                      labelText: s.nameCampagne,
                      keyboardType: TextInputType.text,
                      controller: _nameController,
                      hintText: 'Ex: Dotation mensuelle Direction',
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Le nom est obligatoire' : null,
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: SelectField<String>(
                      label: 'Fréquence',
                      placeholder: 'Choisir une fréquence',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',     value: 'DAILY'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire', value: 'WEEKLY'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',     value: 'MONTHLY'),
                      ],
                      onChanged: (opt) =>
                          setState(() => _selectedFrequency = opt.value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SelectField<String>(
                      label: 'Produit',
                      placeholder: 'Choisir un produit',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',     value: 'DAILY'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire', value: 'WEEKLY'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',     value: 'MONTHLY'),
                      ],
                      onChanged: (opt) =>
                          setState(() => _selectedProductId = opt.value),
                    ),
                  ),
                  SizedBox(width: 16.rw),
                  Expanded(
                    child: SelectField<String>(
                      label: 'Ciblage',
                      placeholder: 'Choisir un ciblage',
                      options: const [
                        SelectOptionModel(label: 'DAILY - Quotidien',     value: 'DAILY'),
                        SelectOptionModel(label: 'WEEKLY - Hebdomadaire', value: 'WEEKLY'),
                        SelectOptionModel(label: 'MONTHLY - Mensuel',     value: 'MONTHLY'),
                      ],
                      onChanged: (opt) =>
                          setState(() => _selectedCiblage = opt.value),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.rh),
              SizedBox(
                width: 250.rw,
                child: AppButton(
                  text: s.planingCampagne,
                  type: AppButtonType.secondary,
                  onPressed: _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
