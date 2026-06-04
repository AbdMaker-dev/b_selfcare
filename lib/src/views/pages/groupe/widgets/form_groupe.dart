import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_date_field.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormGroupe extends StatefulWidget {
  final GroupCubit groupCubit;
  final VoidCallback? onCreated;

  const FormGroupe({
    super.key,
    required this.groupCubit,
    this.onCreated,
  });

  static void show(
    BuildContext context, {
    required GroupCubit groupCubit,
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
            child: FormGroupe(
              groupCubit: groupCubit,
              onCreated: onCreated,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<FormGroupe> createState() => _FormGroupeState();
}

class _FormGroupeState extends State<FormGroupe> {
  final productsCubit = getIt<ProductsCubit>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _selectedProductId;
  String? _selectedFrequency;
  String? _selectedDayWeek;
  String? _selectedDayMonth;
  DateTime? _selectedStartDate;
  final _formKey = GlobalKey<FormState>();
  int _formSectionKey = 0;

  @override
  void initState() {
    super.initState();
    productsCubit.fetchProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void reset() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedProductId = null;
      _selectedFrequency = null;
      _selectedDayWeek = null;
      _selectedDayMonth = null;
      _selectedStartDate = null;
      _formSectionKey++;
    });
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final missing = <String>[];
    if (_selectedProductId == null) missing.add('Produit');
    if (_selectedFrequency == null) missing.add('Fréquence');
    if (_selectedStartDate == null) missing.add('Date de début');
    if (_selectedFrequency == 'WEEKLY' && _selectedDayWeek == null) missing.add('Jour de la semaine');
    if (_selectedFrequency == 'MONTHLY' && _selectedDayMonth == null) missing.add('Jour du mois');

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

    widget.groupCubit.createGroupe(data: {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text,
      'product_id': _selectedProductId,
      'frequency': _selectedFrequency,
      'start_date': _selectedStartDate!.toIso8601String(),
      if (_selectedFrequency == 'WEEKLY') 'day_of_week': _selectedDayWeek,
      if (_selectedFrequency == 'MONTHLY') 'day_of_month': _selectedDayMonth,
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          createGroupeLoaded: (_) {
            Navigator.of(context, rootNavigator: true).pop();
            widget.onCreated?.call();
          },
          createGroupeFailed: (message) {},
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.rw,
                    vertical: 16.rh,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                      bottom: BorderSide(color: AppColors.gray),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText.textHighlight(
                              'Nouveau groupe',
                              fontSize: 20.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grayAsh,
                              highlight: 'groupe',
                              fontFamily: FontFamily.syne,
                              highlightColor: AppColors.primary,
                              highlightFontSize: 20.rsp,
                            ),
                            SizedBox(height: 4.rh),
                            AppText(
                              'NOM · PRODUIT · FRÉQUENCE · DATE DÉBUT',
                              fontSize: 10.rsp,
                              color: AppColors.textMuted,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
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
                SizedBox(height: 20.rh),
                // SCROLLABLE BODY
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.rw),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'INFORMATIONS GROUPE',
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(height: 12.rh),
                        AppInput(
                          labelText: 'Nom du groupe',
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          isRequired: true,
                          hintText: 'Ex: Direction Générale',
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Le nom est obligatoire'
                              : null,
                        ),
                        SizedBox(height: 16.rh),
                        AppInput(
                          labelText: 'Description',
                          keyboardType: TextInputType.text,
                          controller: _descriptionController,
                          hintText: 'Ex: Groupe des cadres dirigeants',
                        ),
                        SizedBox(height: 24.rh),
                        AppText(
                          'CONFIGURATION',
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                        SizedBox(height: 12.rh),
                        BlocBuilder<ProductsCubit, ProductsState>(
                          bloc: productsCubit,
                          builder: (context, productsState) {
                            final options = productsCubit.products
                                .map((p) => SelectOptionModel<String>(
                                      label: p.name ?? '---',
                                      value: p.id.toString(),
                                    ))
                                .toList();
                            return SelectField<String>(
                              label: 'Produit',
                              placeholder: productsState.maybeWhen(
                                productsLoading: () => 'Chargement...',
                                orElse: () => 'Choisir un produit',
                              ),
                              options: options,
                              searchMode: SelectSearchMode.local,
                              onChanged: (opt) => setState(
                                  () => _selectedProductId = opt.value.toString()),
                            );
                          },
                        ),
                        SizedBox(height: 16.rh),
                        SelectField<String>(
                          label: 'Fréquence',
                          placeholder: 'Choisir une fréquence',
                          options: const [
                            SelectOptionModel(
                                label: 'DAILY - Quotidien', value: 'DAILY'),
                            SelectOptionModel(
                                label: 'WEEKLY - Hebdomadaire', value: 'WEEKLY'),
                            SelectOptionModel(
                                label: 'MONTHLY - Mensuel', value: 'MONTHLY'),
                          ],
                          onChanged: (opt) => setState(() {
                            _selectedFrequency = opt.value;
                            _selectedDayWeek = null;
                            _selectedDayMonth = null;
                          }),
                        ),
                        if (_selectedFrequency == 'WEEKLY') ...[
                          SizedBox(height: 16.rh),
                          SelectField<String>(
                            label: 'Jour de la semaine',
                            placeholder: 'Choisir un jour',
                            options: const [
                              SelectOptionModel(label: 'Lundi', value: '1'),
                              SelectOptionModel(label: 'Mardi', value: '2'),
                              SelectOptionModel(label: 'Mercredi', value: '3'),
                              SelectOptionModel(label: 'Jeudi', value: '4'),
                              SelectOptionModel(label: 'Vendredi', value: '5'),
                              SelectOptionModel(label: 'Samedi', value: '6'),
                              SelectOptionModel(label: 'Dimanche', value: '7'),
                            ],
                            onChanged: (opt) =>
                                setState(() => _selectedDayWeek = opt.value),
                          ),
                        ],
                        if (_selectedFrequency == 'MONTHLY') ...[
                          SizedBox(height: 16.rh),
                          SelectField<String>(
                            label: 'Jour du mois',
                            placeholder: 'Choisir un jour (1–31)',
                            searchMode: SelectSearchMode.local,
                            options: List.generate(
                              31,
                              (i) => SelectOptionModel(
                                label: '${i + 1}',
                                value: '${i + 1}',
                              ),
                            ),
                            onChanged: (opt) =>
                                setState(() => _selectedDayMonth = opt.value),
                          ),
                        ],
                        SizedBox(height: 16.rh),
                        Row(
                          children: [
                            Expanded(
                              child: AppDateField(
                                label: 'Date de début',
                                required: true,
                                onChanged: (date) =>
                                    setState(() => _selectedStartDate = date),
                              ),
                            ),
                            SizedBox(width: 16.rw),
                            Expanded(
                              child: AppDateField(
                                label: 'Date de fin',
                                optional: true,
                                onChanged: (date) {},
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.rh),
                      ],
                    ),
                  ),
                ),

                // FOOTER
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.rw,
                    vertical: 16.rh,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                      top: BorderSide(color: AppColors.gray),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: 'Annuler',
                          type: AppButtonType.outline,
                          onPressed: () =>
                              Navigator.of(context, rootNavigator: true).pop(),
                          fontSize: 15.rsp,
                        ),
                      ),
                      SizedBox(width: 12.rw),
                      Expanded(
                        flex: 2,
                        child: AppButton(
                          text: '+ Créer le groupe',
                          type: AppButtonType.secondary,
                          onPressed: _submit,
                          fontSize: 15.rsp,
                        ),
                      ),
                    ],
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
