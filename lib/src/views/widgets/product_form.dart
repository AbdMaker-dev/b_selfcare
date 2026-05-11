import 'package:b_selfcare/singleton.dart';
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
  final TextEditingController quotaController = TextEditingController();

  _QuotaRow();

  void dispose() => quotaController.dispose();
}

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<ProductsCubit>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final List<_QuotaRow> _quotas = List.generate(4, (_) => _QuotaRow());

  @override
  void initState() {
    super.initState();
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

    final quotas = _quotas.map((q) => {'wallet_id': q.walletId!, 'quota': q.quota!}).toList();

    await _cubit.createProductsBulk(
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      quotas: quotas,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      bloc: _cubit,
      listener: (context, state) {
        state.whenOrNull(
          createProductsSuccess: () => Navigator.of(context).pop(),
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
                'Nouveau produit',
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
                  orElse: () => false,
                ),
                builder: (context, state) {
                  final isLoading = state.maybeWhen(
                    createProductsLoading: () => true,
                    orElse: () => false,
                  );
                  return AppButton(
                    text: 'Créer le produit',
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
