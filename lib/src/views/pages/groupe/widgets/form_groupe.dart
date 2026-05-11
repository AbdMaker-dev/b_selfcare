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
            reset();
            widget.onCreated?.call();
          },
          createGroupeFailed: (message) =>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: AppColors.error),
              ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Créer un groupe',
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
                        labelText: 'Nom du groupe',
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        hintText: 'Ex: Direction Générale',
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Le nom est obligatoire' : null,
                      ),
                    ),
                    SizedBox(width: 16.rw),
                    Expanded(
                      child: AppInput(
                        labelText: 'Description',
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        hintText: 'Ex: Groupe des cadres dirigeants',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.rh),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<ProductsCubit, ProductsState>(
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
                            onChanged: (opt) =>
                                setState(() => _selectedProductId = opt.value.toString()),
                          );
                        },
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
                        onChanged: (opt) => setState(() {
                          _selectedFrequency = opt.value;
                          _selectedDayWeek = null;
                          _selectedDayMonth = null;
                        }),
                      ),
                    ),
                  ],
                ),
                if (_selectedFrequency == 'WEEKLY') ...[
                  SizedBox(height: 20.rh),
                  Row(
                    children: [
                      Expanded(
                        child: SelectField<String>(
                          label: 'Jour de la semaine',
                          placeholder: 'Choisir un jour',
                          options: const [
                            SelectOptionModel(label: 'Lundi',    value: '1'),
                            SelectOptionModel(label: 'Mardi',    value: '2'),
                            SelectOptionModel(label: 'Mercredi', value: '3'),
                            SelectOptionModel(label: 'Jeudi',    value: '4'),
                            SelectOptionModel(label: 'Vendredi', value: '5'),
                            SelectOptionModel(label: 'Samedi',   value: '6'),
                            SelectOptionModel(label: 'Dimanche', value: '7'),
                          ],
                          onChanged: (opt) =>
                              setState(() => _selectedDayWeek = opt.value),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
                if (_selectedFrequency == 'MONTHLY') ...[
                  SizedBox(height: 20.rh),
                  Row(
                    children: [
                      Expanded(
                        child: SelectField<String>(
                          label: 'Jour du mois',
                          placeholder: 'Choisir un jour (1–31)',
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
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
                SizedBox(height: 20.rh),
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
                SizedBox(height: 20.rh),
                SizedBox(
                  width: 250.rw,
                  child: AppButton(
                    text: 'Créer le groupe',
                    type: AppButtonType.secondary,
                    onPressed: _submit,
                    fontSize: 15.rsp,
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
