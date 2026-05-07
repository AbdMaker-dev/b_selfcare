import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/source_groupe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_date_field.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyGroupeScreen extends StatefulWidget {
  const MyGroupeScreen({super.key});

  @override
  State<MyGroupeScreen> createState() => _MyGroupeScreenState();
}

class _MyGroupeScreenState extends State<MyGroupeScreen> {
  final groupCubit = getIt<GroupCubit>();
  final productsCubit = getIt<ProductsCubit>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  int _currentPage = 1;
  DataGroupResponseModel? _cachedData;
  String? _selectedProductId;
  String? _selectedFrequency;
  DateTime? _selectedStartDate;
  final _formKey = GlobalKey<FormState>();
  int _formSectionKey = 0;

  @override
  void initState() {
    super.initState();
    groupCubit.getGroups(data: {'page': _currentPage});
    productsCubit.fetchProducts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedProductId = null;
      _selectedFrequency = null;
      _selectedStartDate = null;
      _formSectionKey++;
    });
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    groupCubit.getGroups(data: {'page': page});
  }

  void _createGroupe() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final missing = <String>[];
    if (_selectedProductId == null) missing.add('Produit');
    if (_selectedFrequency == null) missing.add('Fréquence');
    if (_selectedStartDate == null) missing.add('Date de début');

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

    groupCubit.createGroupe(data: {
      'name': _nameController.text.trim(),
      'description': _descriptionController.text,
      'product_id': _selectedProductId,
      'frequency': _selectedFrequency,
      'start_date': _selectedStartDate!.toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          getGroupsFailed: (message) =>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: AppColors.error),
              ),
          createGroupeLoaded: (_) {
            _resetForm();
            groupCubit.getGroups(data: {'page': _currentPage});
          },
          createGroupeFailed: (message) =>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: AppColors.error),
              ),
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetGroupsLoaded) {
          _cachedData = state.data;
        }

        final isLoading = state is GetGroupsLoading;
        final groups = _cachedData?.data?.groups ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText.textHighlight(
                      'Mes groupes',
                      highlight: 'groupes',
                      fontSize: 22.rsp,
                      highlightColor: AppColors.warning,
                      fontFamily: FontFamily.syne,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0
                          ? '$total groupes · Gestion des groupes d\'employés'
                          : 'Organisez vos employés par groupes et produits',
                      fontSize: 11.rsp,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: '+ Groupe',
                  type: AppButtonType.secondary,
                  width: 130.rw,
                  height: 38.rh,
                  fontSize: 13.rsp,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            Form(
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
                            options: [
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
                        onPressed: _createGroupe,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
            SizedBox(height: 20.rh),
            if (isLoading && groups.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else ...[
              AppTable(
                title: 'Mes groupes',
                source: SourceGroupe(rows: groups),
                currentPage: _currentPage,
                totalCount: total,
                activePreviousClicked: _currentPage > 1,
                activeNextClicked: _currentPage < lastPage,
                onPreviousClicked: _currentPage > 1 ? () => _fetchPage(_currentPage - 1) : null,
                onNextClicked: _currentPage < lastPage ? () => _fetchPage(_currentPage + 1) : null,
              ),
            ],
          ],
        );
      },
    );
  }
}
