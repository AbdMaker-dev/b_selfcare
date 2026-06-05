import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/group_model.dart';
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

class FormEditGroupe extends StatefulWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const FormEditGroupe({
    super.key,
    required this.groupe,
    required this.groupCubit,
  });

  static void show(
    BuildContext context, {
    required GroupModel groupe,
    required GroupCubit groupCubit,
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
            child: FormEditGroupe(
              groupe: groupe,
              groupCubit: groupCubit,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<FormEditGroupe> createState() => _FormEditGroupeState();
}

class _FormEditGroupeState extends State<FormEditGroupe> {
  final productsCubit = getIt<ProductsCubit>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;

  String? _selectedProductId;
  bool _removeProduct = false;

  String? _selectedFrequency;
  String? _selectedDayWeek;
  String? _selectedDayMonth;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.groupe.name ?? '');
    _descriptionController = TextEditingController(text: widget.groupe.description ?? '');
    _selectedProductId = widget.groupe.productId?.toString();
    _selectedFrequency = widget.groupe.campaign?.frequency;
    _selectedDayWeek = widget.groupe.campaign?.dayOfWeek?.toString();
    _selectedDayMonth = widget.groupe.campaign?.dayOfMonth?.toString();
    _selectedStartDate = _parseDate(widget.groupe.campaign?.startDate);
    _selectedEndDate = _parseDate(widget.groupe.campaign?.endDate);
    productsCubit.fetchProducts();
  }

  DateTime? _parseDate(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    try {
      return DateTime.parse(iso);
    } catch (_) {
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (!formValid) return;

    final id = widget.groupe.id;
    if (id == null) return;

    widget.groupCubit.updateGroupe(
      id: id,
      data: {
        'name': _nameController.text.trim(),
        'description': _descriptionController.text.trim(),
        if (!_removeProduct && _selectedProductId != null)
          'product_id': int.tryParse(_selectedProductId!),
        'remove_product': _removeProduct,
        if (_selectedFrequency != null) 'frequency': _selectedFrequency,
        if (_selectedFrequency == 'WEEKLY' && _selectedDayWeek != null)
          'day_of_week': int.tryParse(_selectedDayWeek!),
        if (_selectedFrequency == 'MONTHLY' && _selectedDayMonth != null)
          'day_of_month': int.tryParse(_selectedDayMonth!),
        if (_selectedStartDate != null) 'start_date': _selectedStartDate!.toIso8601String(),
        if (_selectedEndDate != null) 'end_date': _selectedEndDate!.toIso8601String(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupCubit, GroupState>(
      bloc: widget.groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          updateGroupeLoaded: (_) =>
              Navigator.of(context, rootNavigator: true).pop(),
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
                            'Modifier groupe',
                            fontSize: 24.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayAsh,
                            highlight: 'groupe',
                            fontFamily: FontFamily.syne,
                            highlightColor: AppColors.primary,
                            highlightFontSize: 24.rsp,
                          ),
                          SizedBox(height: 4.rh),
                          AppText(
                            'NOM · PRODUIT · FRÉQUENCE · DATE DÉBUT',
                            fontSize: 12.rsp,
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
                        padding:  EdgeInsets.symmetric(
                          horizontal: 10.rw,
                          vertical: 6.rh,
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

              // SCROLLABLE BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16.rw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.rh),
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
                          final initialLabel = widget.groupe.product?.name;
                          return Opacity(
                            opacity: _removeProduct ? 0.4 : 1.0,
                            child: IgnorePointer(
                              ignoring: _removeProduct,
                              child: SelectField<String>(
                                label: 'Produit',
                                placeholder: productsState.maybeWhen(
                                  productsLoading: () => 'Chargement...',
                                  orElse: () => initialLabel ?? 'Choisir un produit',
                                ),
                                options: options,
                                searchMode: SelectSearchMode.local,
                                onChanged: (opt) =>
                                    setState(() => _selectedProductId = opt.value),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.rh),
                      _RemoveProductToggle(
                        value: _removeProduct,
                        onChanged: (val) => setState(() {
                          _removeProduct = val;
                          if (val) _selectedProductId = null;
                        }),
                      ),
                      SizedBox(height: 16.rh),
                      SelectField<String>(
                        label: 'Fréquence',
                        placeholder: _selectedFrequency != null
                            ? _frequencyLabel(_selectedFrequency!)
                            : 'Choisir une fréquence',
                        options: const [
                          SelectOptionModel(label: 'DAILY - Quotidien', value: 'DAILY'),
                          SelectOptionModel(label: 'WEEKLY - Hebdomadaire', value: 'WEEKLY'),
                          SelectOptionModel(label: 'MONTHLY - Mensuel', value: 'MONTHLY'),
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
                          placeholder: _selectedDayWeek != null
                              ? _dayWeekLabel(_selectedDayWeek!)
                              : 'Choisir un jour',
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
                          placeholder: _selectedDayMonth ?? 'Choisir un jour (1–31)',
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
                              required: false,
                              initialDate: _selectedStartDate,
                              onChanged: (date) =>
                                  setState(() => _selectedStartDate = date),
                            ),
                          ),
                          SizedBox(width: 16.rw),
                          Expanded(
                            child: AppDateField(
                              label: 'Date de fin',
                              optional: true,
                              initialDate: _selectedEndDate,
                              onChanged: (date) =>
                                  setState(() => _selectedEndDate = date),
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
                      child: BlocBuilder<GroupCubit, GroupState>(
                        bloc: widget.groupCubit,
                        builder: (context, state) {
                          final isLoading = state is UpdateGroupeLoading;
                          return AppButton(
                            text: isLoading
                                ? 'Mise à jour...'
                                : '+ Enregistrer les modifications',
                            type: AppButtonType.primary,
                            fontSize: 13.rsp,
                            onPressed: isLoading ? null : _submit,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _frequencyLabel(String value) {
    switch (value) {
      case 'DAILY':   return 'DAILY - Quotidien';
      case 'WEEKLY':  return 'WEEKLY - Hebdomadaire';
      case 'MONTHLY': return 'MONTHLY - Mensuel';
      default:        return value;
    }
  }

  String _dayWeekLabel(String value) {
    const labels = {
      '1': 'Lundi', '2': 'Mardi', '3': 'Mercredi',
      '4': 'Jeudi', '5': 'Vendredi', '6': 'Samedi', '7': 'Dimanche',
    };
    return labels[value] ?? value;
  }
}

class _RemoveProductToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _RemoveProductToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'RETIRER LE PRODUIT',
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
                  activeThumbColor: AppColors.error,
                  activeTrackColor: AppColors.error.withValues(alpha: 0.3),
                ),
                SizedBox(width: 8.rw),
                AppText(
                  value ? 'Produit retiré' : 'Conserver le produit',
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
