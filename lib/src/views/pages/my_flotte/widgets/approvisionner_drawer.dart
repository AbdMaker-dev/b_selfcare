import 'dart:async';

import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/products/cubit/products_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_input.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovisionnerDrawer extends StatefulWidget {
  final EmployeeModel employee;

  const ApprovisionnerDrawer({super.key, required this.employee});

  static void show(BuildContext context, {required EmployeeModel employee}) {
    showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      pageBuilder: (context, animation, secondaryAnimation) => Align(
        alignment: Alignment.centerRight,
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            width: 650.rw,
            height: double.infinity,
            child: ApprovisionnerDrawer(employee: employee),
          ),
        ),
      ),
    );
  }

  @override
  State<ApprovisionnerDrawer> createState() => _ApprovisionnerDrawerState();
}

class _ApprovisionnerDrawerState extends State<ApprovisionnerDrawer>
    with SingleTickerProviderStateMixin {
  final _productsCubit = getIt<ProductsCubit>();
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _productsCubit.fetchProducts();
    _productsCubit.fetchWallets();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context, rootNavigator: true).pop();

  @override
  Widget build(BuildContext context) {
    final employeeName =
        '${widget.employee.firstName ?? ''} ${widget.employee.lastName ?? ''}'.trim();

    return Container(
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
          // ─── Header ───────────────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(bottom: BorderSide(color: AppColors.gray)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.textHighlight(
                            'Approvisionner employé',
                            fontSize: 24.rsp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grayAsh,
                            highlight: 'employé',
                            fontFamily: FontFamily.syne,
                            highlightColor: AppColors.primary,
                            highlightFontSize: 24.rsp,
                          ),
                          SizedBox(height: 4.rh),
                          AppText(
                            employeeName.isNotEmpty ? employeeName : '—',
                            fontSize: 12.rsp,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: _close,
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 6.rh),
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
                SizedBox(height: 14.rh),
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textMuted,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 2,
                  dividerColor: AppColors.gray,
                  labelStyle: TextStyle(
                    fontSize: 13.rsp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 13.rsp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                  ),
                  tabs: const [
                    Tab(text: 'Produit existant'),
                    Tab(text: 'Nouveau produit'),
                  ],
                ),
              ],
            ),
          ),

          // ─── Corps ────────────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _SelectProductTab(
                  employee: widget.employee,
                  productsCubit: _productsCubit,
                  onClose: _close,
                ),
                _CreateProductTab(
                  employee: widget.employee,
                  productsCubit: _productsCubit,
                  onClose: _close,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tab 1 : Sélectionner un produit existant ─────────────────────────────────

class _SelectProductTab extends StatefulWidget {
  final EmployeeModel employee;
  final ProductsCubit productsCubit;
  final VoidCallback onClose;

  const _SelectProductTab({
    required this.employee,
    required this.productsCubit,
    required this.onClose,
  });

  @override
  State<_SelectProductTab> createState() => _SelectProductTabState();
}

class _SelectProductTabState extends State<_SelectProductTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';
  ProductsModel? _selected;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  List<ProductsModel> get _filtered {
    final products =
        widget.productsCubit.products.where((p) => p.isActive == true).toList();
    if (_searchQuery.isEmpty) return products;
    return products
        .where((p) =>
            (p.name ?? '').toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Recherche
        Padding(
          padding: EdgeInsets.fromLTRB(16.rw, 16.rh, 16.rw, 0),
          child: AppSearchInput(
            controller: _searchController,
            hintText: 'Rechercher un produit...',
            onChanged: (v) {
              _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 300), () {
                setState(() { _searchQuery = v; });
              });
            },
          ),
        ),

        // Liste
        Expanded(
          child: BlocBuilder<ProductsCubit, ProductsState>(
            bloc: widget.productsCubit,
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                productsLoading: () => true,
                orElse: () => false,
              );

              if (isLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              final products = _filtered;
              if (products.isEmpty) {
                return Center(
                  child: AppText(
                    'Aucun produit actif trouvé',
                    fontSize: 13.rsp,
                    color: AppColors.textMuted,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
                itemCount: products.length,
                separatorBuilder: (_, index) => SizedBox(height: 10.rh),
                itemBuilder: (_, i) {
                  final p = products[i];
                  final isSelected = _selected?.id == p.id;
                  return GestureDetector(
                    onTap: () => setState(() => _selected = isSelected ? null : p),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary.withValues(alpha: 0.06)
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(10.rr),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.gray,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  p.name ?? '—',
                                  fontSize: 14.rsp,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.textHeading,
                                ),
                                if (p.description != null) ...[
                                  SizedBox(height: 2.rh),
                                  AppText(
                                    p.description!,
                                    fontSize: 12.rsp,
                                    color: AppColors.textMuted,
                                  ),
                                ],
                                if (p.quotas?.isNotEmpty == true) ...[
                                  SizedBox(height: 8.rh),
                                  Wrap(
                                    spacing: 6.rw,
                                    runSpacing: 4.rh,
                                    children: (p.quotas ?? [])
                                        .map((q) => Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.rw, vertical: 3.rh),
                                              decoration: BoxDecoration(
                                                color: AppColors.background,
                                                borderRadius: BorderRadius.circular(6.rr),
                                                border: Border.all(
                                                    color: AppColors.inputBorder),
                                              ),
                                              child: AppText(
                                                '${q.name ?? ''}: ${q.quota ?? 0} ${q.unit ?? ''}',
                                                fontSize: 11.rsp,
                                                color: AppColors.textMuted,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          if (p.price != null) ...[
                            SizedBox(width: 12.rw),
                            AppText(
                              '${p.price} F',
                              fontSize: 13.rsp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success,
                            ),
                          ],
                          SizedBox(width: 10.rw),
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: isSelected ? AppColors.primary : AppColors.gray,
                            size: 20.rsp,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Footer
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border(top: BorderSide(color: AppColors.gray)),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  text: 'Annuler',
                  type: AppButtonType.outline,
                  fontSize: 14.rsp,
                  onPressed: widget.onClose,
                ),
              ),
              SizedBox(width: 12.rw),
              Expanded(
                flex: 2,
                child: AppButton(
                  text: 'Approvisionner',
                  type: AppButtonType.secondary,
                  fontSize: 13.rsp,
                  onPressed: _selected == null
                      ? null
                      : () {
                          // TODO: appeler l'API avec widget.employee.id et _selected!.id
                          widget.onClose();
                        },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Tab 2 : Créer un nouveau produit ────────────────────────────────────────

class _CreateProductTab extends StatefulWidget {
  final EmployeeModel employee;
  final ProductsCubit productsCubit;
  final VoidCallback onClose;

  const _CreateProductTab({
    required this.employee,
    required this.productsCubit,
    required this.onClose,
  });

  @override
  State<_CreateProductTab> createState() => _CreateProductTabState();
}

class _CreateProductTabState extends State<_CreateProductTab> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  final Map<int, TextEditingController> _quotaControllers = {};

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descController = TextEditingController();
    _initControllers();
    widget.productsCubit.fetchWallets().then((_) {
      if (mounted) {
        _initControllers();
        setState(() {});
      }
    });
  }

  void _initControllers() {
    for (final wallet in widget.productsCubit.wallets) {
      final id = wallet.id;
      if (id == null || _quotaControllers.containsKey(id)) continue;
      _quotaControllers[id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    for (final c in _quotaControllers.values) { c.dispose(); }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final quotas = widget.productsCubit.wallets
        .where((w) => w.id != null)
        .map((w) {
          final text = _quotaControllers[w.id!]?.text.trim() ?? '';
          final val = double.tryParse(text);
          if (val == null || val <= 0) return null;
          return {'wallet_id': w.id!, 'quota': val};
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    if (quotas.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Veuillez renseigner au moins un quota.'),
        backgroundColor: AppColors.error,
      ));
      return;
    }

    await widget.productsCubit.createProductsBulk(
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      quotas: quotas,
    );

    // TODO: appeler l'API d'approvisionnement avec le nouvel ID et widget.employee.id
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.rh),
                  AppText('INFORMATIONS PRODUIT',
                      fontSize: 11.rsp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted),
                  SizedBox(height: 12.rh),
                  AppInput(
                    controller: _nameController,
                    labelText: 'Nom',
                    hintText: 'Ex: SELFCARE VOICE XNET',
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'Champ obligatoire' : null,
                  ),
                  SizedBox(height: 14.rh),
                  AppInput(
                    controller: _descController,
                    labelText: 'Description (optionnel)',
                    hintText: 'Ex: Forfait voix entreprise',
                  ),
                  SizedBox(height: 24.rh),
                  AppText('WALLETS & QUOTAS',
                      fontSize: 11.rsp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted),
                  SizedBox(height: 12.rh),
                  BlocBuilder<ProductsCubit, ProductsState>(
                    bloc: widget.productsCubit,
                    buildWhen: (_, state) => state.maybeWhen(
                      walletsLoaded: () => true,
                      walletsLoading: () => true,
                      orElse: () => false,
                    ),
                    builder: (context, state) {
                      if (widget.productsCubit.wallets.isEmpty) {
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.rw,
                          mainAxisSpacing: 12.rh,
                          mainAxisExtent: 100.rh,
                        ),
                        itemCount: widget.productsCubit.wallets.length,
                        itemBuilder: (_, i) {
                          final wallet = widget.productsCubit.wallets[i];
                          final id = wallet.id;
                          if (id == null) return const SizedBox();
                          return AppInput(
                            controller: _quotaControllers[id],
                            labelText: wallet.name ?? '—',
                            hintText: '0',
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
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

          // Footer
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.gray)),
            ),
            child: BlocBuilder<ProductsCubit, ProductsState>(
              bloc: widget.productsCubit,
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
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Annuler',
                        type: AppButtonType.outline,
                        fontSize: 14.rsp,
                        onPressed: isLoading ? null : widget.onClose,
                      ),
                    ),
                    SizedBox(width: 12.rw),
                    Expanded(
                      flex: 2,
                      child: AppButton(
                        text: isLoading ? 'Chargement...' : '+ Créer et approvisionner',
                        type: AppButtonType.secondary,
                        fontSize: 13.rsp,
                        onPressed: isLoading ? null : _submit,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
