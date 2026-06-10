import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductForm extends StatefulWidget {
  final ProductsModel? product;

  const ProductForm({super.key, this.product});

  static void show(BuildContext context, {ProductsModel? product}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder:
          (_, _, _) => Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: 650.rw,
                height: double.infinity,
                child: ProductForm(product: product),
              ),
            ),
          ),
    );
  }

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<ProductsCubit>();

  late final TextEditingController _nameController;
  late final TextEditingController _descController;

  // walletId → controller du quota
  final Map<int, TextEditingController> _quotaControllers = {};
  // walletId → unité choisie pour MB_GB ('MB' ou 'GB')
  final Map<int, String> _unitSelections = {};

  bool get _isEdit => widget.product?.id != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name ?? '');
    _descController = TextEditingController(text: p?.description ?? '');
    _cubit.fetchWallets().then((_) {
      if (mounted) {
        _initControllers();
        setState(() {});
      }
    });
    _initControllers();
  }

  void _initControllers() {
    for (final wallet in _cubit.wallets) {
      final id = wallet.id;
      if (id == null) continue;
      if (!_quotaControllers.containsKey(id)) {
        final existing = widget.product?.quotas
            ?.where((q) => q.walletId == id)
            .firstOrNull
            ?.quota;
        _quotaControllers[id] = TextEditingController(
          text: existing != null ? existing.toString() : '',
        );
      }
      if (wallet.unit == 'MB_GB' && !_unitSelections.containsKey(id)) {
        final existingUnit = widget.product?.quotas
            ?.where((q) => q.walletId == id)
            .firstOrNull
            ?.unit;
        // MB_GB stocké → GB, MB stocké → MB, sinon GB par défaut
        _unitSelections[id] = existingUnit == 'MB' ? 'MB' : 'GB';
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    for (final c in _quotaControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quotas =
        _cubit.wallets
            .where((w) => w.id != null)
            .map((w) {
              final text = _quotaControllers[w.id!]?.text.trim() ?? '';
              final val = double.tryParse(text);
              if (val == null || val <= 0) return null;
              final String unit;
              if (w.unit == 'MB_GB') {
                unit = (_unitSelections[w.id!] ?? 'GB') == 'GB' ? 'MB_GB' : 'MB';
              } else {
                unit = w.unit ?? '';
              }
              return {'wallet_id': w.id!, 'quota': val, 'unit': unit};
            })
            .whereType<Map<String, dynamic>>()
            .toList();

    if (quotas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez renseigner au moins un quota.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (_isEdit) {
      await _cubit.updateProduct(
        productId: widget.product!.id!,
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        quotas: quotas,
      );
    } else {
      await _cubit.createProductsBulk(
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        quotas: quotas,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      bloc: _cubit,
      listener: (context, state) {
        state.whenOrNull(
          createProductsSuccess:
              () => Navigator.of(context, rootNavigator: true).pop(),
          updateProductSuccess:
              () => Navigator.of(context, rootNavigator: true).pop(),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.rw,
                  vertical: 16.rh,
                ),
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
                            _isEdit ? 'Modifier le produit' : 'Nouveau produit',
                            fontSize: 20.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayAsh,
                            highlight: 'produit',
                            fontFamily: FontFamily.syne,
                            highlightColor: AppColors.primary,
                            highlightFontSize: 20.rsp,
                          ),
                          SizedBox(height: 4.rh),
                          AppText(
                            'NOM · DESCRIPTION · WALLETS · QUOTAS',
                            fontSize: 10.rsp,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap:
                          () =>
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

              // BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.rw,
                    vertical: 20.rh,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        'INFORMATIONS PRODUIT',
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(height: 12.rh),
                      AppInput(
                        controller: _nameController,
                        labelText: 'Nom',
                        hintText: 'Ex: SELFCARE VOICE XNET',
                        validator:
                            (v) =>
                                (v == null || v.trim().isEmpty)
                                    ? 'Champ obligatoire'
                                    : null,
                      ),
                      SizedBox(height: 14.rh),
                      AppInput(
                        controller: _descController,
                        labelText: 'Description (optionnel)',
                        hintText: 'Ex: Forfait voix entreprise',
                      ),
                      SizedBox(height: 24.rh),
                      AppText(
                        'WALLETS & QUOTAS',
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                      SizedBox(height: 12.rh),
                      BlocBuilder<ProductsCubit, ProductsState>(
                        bloc: _cubit,
                        buildWhen:
                            (_, state) => state.maybeWhen(
                              walletsLoaded: () => true,
                              walletsLoading: () => true,
                              orElse: () => false,
                            ),
                        builder: (context, state) {
                          if (_cubit.wallets.isEmpty) {
                            return Center(
                              child: SizedBox(
                                height: 24.rh,
                                width: 24.rh,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          }

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.rw,
                                  mainAxisSpacing: 12.rh,
                                  mainAxisExtent: 100.rh,
                                ),
                            itemCount: _cubit.wallets.length,
                            itemBuilder: (_, i) {
                              final wallet = _cubit.wallets[i];
                              final id = wallet.id;
                              if (id == null) return const SizedBox();
                              final isMbGb = wallet.unit == 'MB_GB';
                              return AppInput(
                                controller: _quotaControllers[id],
                                labelText: "${wallet.name ?? '---'} (${wallet.unit ?? ''})",
                                hintText: '0',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                suffixIcon:
                                    isMbGb
                                        ? _UnitToggle(
                                          selected: _unitSelections[id] ?? 'GB',
                                          onChanged:
                                              (unit) => setState(
                                                () => _unitSelections[id] = unit,
                                              ),
                                        )
                                        : null,
                              );
                            },
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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.rw,
                  vertical: 16.rh,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border(top: BorderSide(color: AppColors.gray)),
                ),
                child: BlocBuilder<ProductsCubit, ProductsState>(
                  bloc: _cubit,
                  buildWhen:
                      (_, state) => state.maybeWhen(
                        createProductsLoading: () => true,
                        createProductsError: (_) => true,
                        createProductsSuccess: () => true,
                        updateProductLoading: () => true,
                        updateProductError: (_) => true,
                        updateProductSuccess: () => true,
                        orElse: () => false,
                      ),
                  builder: (context, state) {
                    final isLoading = state.maybeWhen(
                      createProductsLoading: () => true,
                      updateProductLoading: () => true,
                      orElse: () => false,
                    );
                    return Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Annuler',
                            type: AppButtonType.outline,
                            onPressed:
                                () =>
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop(),
                            fontSize: 15.rsp,
                          ),
                        ),
                        SizedBox(width: 12.rw),
                        Expanded(
                          flex: 2,
                          child: AppButton(
                            text:
                                isLoading
                                    ? 'Chargement...'
                                    : _isEdit
                                    ? 'Enregistrer les modifications'
                                    : '+ Créer le produit',
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

class _UnitToggle extends StatelessWidget {
  final String selected;
  final void Function(String) onChanged;

  const _UnitToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 6.rh),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(6.rr),
          border: Border.all(color: AppColors.inputBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: ['MB', 'GB'].map((unit) {
            final isActive = selected == unit;
            return GestureDetector(
              onTap: () => onChanged(unit),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(5.rr),
                ),
                child: AppText(
                  unit,
                  fontSize: 11.rsp,
                  fontWeight: FontWeight.w600,
                  color: isActive ? AppColors.white : AppColors.textMuted,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
