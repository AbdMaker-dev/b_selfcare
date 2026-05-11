import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_field.dart';
import 'package:b_selfcare/src/views/widgets/select_option/select_option_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class _QuotaRow {
  int? walletId;
  double? quota;
  final TextEditingController quotaController;

  _QuotaRow({int? initialWalletId, double? initialQuota})
      : walletId = initialWalletId,
        quota = initialQuota,
        quotaController = TextEditingController(
          text: initialQuota != null ? initialQuota.toString() : '',
        );

  void dispose() => quotaController.dispose();
}

class ProductForm extends StatefulWidget {
  final ProductsModel? product;

  const ProductForm({super.key, this.product});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<ProductsCubit>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late final List<_QuotaRow> _quotas;

  bool get _isEdit => widget.product != null;

  @override
  void initState() {
    super.initState();
    final p = widget.product;
    _nameController = TextEditingController(text: p?.name ?? '');
    _descController = TextEditingController(text: p?.description ?? '');

    if (_isEdit && (p!.quotas ?? []).isNotEmpty) {
      _quotas = p.quotas!
          .map((q) => _QuotaRow(
                initialWalletId: q.walletId,
                initialQuota: q.quota?.toDouble(),
              ))
          .toList();
    } else {
      _quotas = List.generate(4, (_) => _QuotaRow());
    }

    _cubit.fetchWallets();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    for (final q in _quotas) {
      q.dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final invalidQuota = _quotas.any((q) => q.walletId == null);
    if (invalidQuota) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner un wallet pour chaque quota.')),
      );
      return;
    }

    final quotas = _quotas
        .map((q) => {'wallet_id': q.walletId!, 'quota': q.quota!})
        .toList();

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
          createProductsSuccess: () => Navigator.of(context).pop(),
          updateProductSuccess: () => Navigator.of(context).pop(),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.rw, vertical: 20.rh),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                _isEdit ? 'Modifier le produit' : 'Nouveau produit',
                fontSize: 18.rsp,
                fontWeight: FontWeight.w700,
                color: AppColors.textHeading,
              ),
              SizedBox(height: 20.rh),
              AppInput(
                controller: _nameController,
                labelText: 'Nom',
                hintText: 'Ex: SELFCARE VOICE XNET',
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
              ),
              SizedBox(height: 14.rh),
              AppInput(
                controller: _descController,
                labelText: 'Description (optionnel)',
                hintText: 'Ex: Forfait voix entreprise',
              ),
              SizedBox(height: 20.rh),
              AppText(
                'Quotas',
                fontSize: 14.rsp,
                fontWeight: FontWeight.w600,
                color: AppColors.textHeading,
              ),
              SizedBox(height: 10.rh),
              BlocBuilder<ProductsCubit, ProductsState>(
                bloc: _cubit,
                buildWhen: (_, state) => state.maybeWhen(
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
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                      ),
                    );
                  }

                  final walletOptions = _cubit.wallets
                      .map((w) => SelectOptionModel<int>(
                            label: w.name ?? '—',
                            value: w.id!,
                            subtitle: '${w.category ?? ''} · ${w.unit ?? ''}',
                          ))
                      .toList();

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _quotas.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.rh),
                    itemBuilder: (_, index) {
                      final row = _quotas[index];
                      final initialOption = row.walletId != null
                          ? walletOptions.firstWhere(
                              (o) => o.value == row.walletId,
                              orElse: () => walletOptions.first,
                            )
                          : null;

                      return Container(
                        padding: EdgeInsets.all(12.rw),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(color: AppColors.inputBorder),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              'Quota ${index + 1}',
                              fontSize: 13.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted,
                            ),
                            SizedBox(height: 10.rh),
                            SelectField<int>(
                              label: 'Wallet',
                              options: walletOptions,
                              placeholder: 'Sélectionner un wallet...',
                              initialValue: initialOption,
                              onChanged: (opt) => setState(() => row.walletId = opt.value),
                            ),
                            SizedBox(height: 10.rh),
                            AppInput(
                              controller: row.quotaController,
                              labelText: 'Valeur',
                              hintText: 'Ex: 100',
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) return 'Champ obligatoire';
                                final parsed = double.tryParse(v.trim());
                                if (parsed == null) return 'Valeur invalide';
                                row.quota = parsed;
                                return null;
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 24.rh),
              BlocBuilder<ProductsCubit, ProductsState>(
                bloc: _cubit,
                buildWhen: (_, state) => state.maybeWhen(
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
                  return AppButton(
                    text: _isEdit ? 'Enregistrer' : 'Créer le produit',
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _submit,
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
