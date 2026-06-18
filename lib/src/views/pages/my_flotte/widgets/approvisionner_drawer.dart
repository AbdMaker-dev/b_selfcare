import 'dart:async';

import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
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
  final _myFlotteCubit = getIt<MyFlotteCubit>();
  late final TabController _tabController;
  int _tab1Key = 0;
  int _tab2Key = 0;
  int _tab3Key = 0;
  int _lastTab = 0;

  // Sélecteur fixe — persiste entre tous les tabs
  FleetNumberModel? _selectedFleetNumber;
  // Produit sélectionné (tabs 1 & 2) — remis à null au changement de tab
  ProductsModel? _selectedProduct;
  // Fonction d'envoi enregistrée par Tab 3 à son montage
  void Function(int)? _tab3SubmitFn;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _productsCubit.fetchProducts();
    _productsCubit.fetchNativeProducts();
    _productsCubit.fetchWallets();
    _tabController.addListener(_onTabChanged);
    _selectedFleetNumber = widget.employee.fleetNumbers?.isNotEmpty == true
        ? widget.employee.fleetNumbers!.first
        : null;
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final newTab = _tabController.index;
    if (newTab == _lastTab) return;
    setState(() {
      if (_lastTab == 0) { _tab1Key++; }
      else if (_lastTab == 1) { _tab2Key++; }
      else { _tab3Key++; _tab3SubmitFn = null; }
      _lastTab = newTab;
      _selectedProduct = null;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _close() => Navigator.of(context, rootNavigator: true).pop();

  bool get _canSubmit {
    if (_selectedFleetNumber == null) return false;
    if (_tabController.index < 2) return _selectedProduct != null;
    return true;
  }

  void _handleSubmit() {
    final fleetId = _selectedFleetNumber?.id;
    if (fleetId == null) return;
    if (_tabController.index < 2) {
      if (_selectedProduct == null) return;
      _myFlotteCubit.manualProvisioning(data: {
        'product_id': _selectedProduct!.id,
        'fleet_number_ids': [fleetId],
      });
    } else {
      _tab3SubmitFn?.call(fleetId);
    }
  }

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
                        padding: EdgeInsets.symmetric(
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
                    Tab(text: 'Produit natif'),
                    Tab(text: 'Partage ponctuel'),
                  ],
                ),
              ],
            ),
          ),

          // ─── Corps (tabs) ─────────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _SelectProductTab(
                  key: ValueKey(_tab1Key),
                  employee: widget.employee,
                  productsCubit: _productsCubit,
                  onProductChanged: (p) => setState(() => _selectedProduct = p),
                ),
                _NativeProductTab(
                  key: ValueKey(_tab2Key),
                  employee: widget.employee,
                  productsCubit: _productsCubit,
                  onProductChanged: (p) => setState(() => _selectedProduct = p),
                ),
                _CreateProductTab(
                  key: ValueKey(_tab3Key),
                  employee: widget.employee,
                  productsCubit: _productsCubit,
                  myFlotteCubit: _myFlotteCubit,
                  onRegisterSubmit: (fn) => _tab3SubmitFn = fn,
                ),
              ],
            ),
          ),

          // ─── Sélecteur de numéro — fixe, commun à tous les tabs ───────────
          _FleetNumberSelector(
            fleetNumbers: widget.employee.fleetNumbers ?? [],
            selected: _selectedFleetNumber,
            onSelected: (f) => setState(() => _selectedFleetNumber = f),
          ),

          // ─── Footer — fixe, commun à tous les tabs ────────────────────────
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 16.rh),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(top: BorderSide(color: AppColors.gray)),
            ),
            child: BlocConsumer<MyFlotteCubit, MyFlotteState>(
              bloc: _myFlotteCubit,
              listener: (context, state) {
                state.maybeWhen(
                  manualProvisioningLoaded: (_) => _close(),
                  orElse: () {},
                );
              },
              builder: (context, state) {
                final isLoading = state.maybeWhen(
                  manualProvisioningLoading: () => true,
                  orElse: () => false,
                );
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Annuler',
                        type: AppButtonType.outline,
                        fontSize: 14.rsp,
                        onPressed: isLoading ? null : _close,
                      ),
                    ),
                    SizedBox(width: 12.rw),
                    Expanded(
                      flex: 2,
                      child: AppButton(
                        text: isLoading ? 'Chargement...' : 'Approvisionner',
                        type: AppButtonType.secondary,
                        fontSize: 13.rsp,
                        onPressed: (!_canSubmit || isLoading) ? null : _handleSubmit,
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

// ─── Tab 1 : Sélectionner un produit existant ─────────────────────────────────

class _SelectProductTab extends StatefulWidget {
  final EmployeeModel employee;
  final ProductsCubit productsCubit;
  final void Function(ProductsModel?) onProductChanged;

  const _SelectProductTab({
    super.key,
    required this.employee,
    required this.productsCubit,
    required this.onProductChanged,
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
        .where(
          (p) => (p.name ?? '').toLowerCase().contains(_searchQuery.toLowerCase()),
        )
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
                setState(() => _searchQuery = v);
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
                    onTap: () {
                      final newSelected = isSelected ? null : p;
                      setState(() => _selected = newSelected);
                      widget.onProductChanged(newSelected);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.rw,
                        vertical: 12.rh,
                      ),
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
                                        .map(
                                          (q) => Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.rw,
                                              vertical: 3.rh,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(6.rr),
                                              border: Border.all(
                                                color: AppColors.inputBorder,
                                              ),
                                            ),
                                            child: AppText(
                                              '${q.name ?? ''}: ${q.quota ?? 0} ${q.unit ?? ''}',
                                              fontSize: 11.rsp,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        )
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
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
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
      ],
    );
  }
}

// ─── Tab 2 : Produits natifs ──────────────────────────────────────────────────

class _NativeProductTab extends StatefulWidget {
  final EmployeeModel employee;
  final ProductsCubit productsCubit;
  final void Function(ProductsModel?) onProductChanged;

  const _NativeProductTab({
    super.key,
    required this.employee,
    required this.productsCubit,
    required this.onProductChanged,
  });

  @override
  State<_NativeProductTab> createState() => _NativeProductTabState();
}

class _NativeProductTabState extends State<_NativeProductTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  String _searchQuery = '';
  ProductsModel? _selected;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productsCubit.nativeProducts.isEmpty) {
      setState(() => _loading = true);
      widget.productsCubit.fetchNativeProducts().then((_) {
        if (mounted) setState(() => _loading = false);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  List<ProductsModel> get _filtered {
    final products =
        widget.productsCubit.nativeProducts.where((p) => p.isActive == true).toList();
    if (_searchQuery.isEmpty) return products;
    return products
        .where(
          (p) => (p.name ?? '').toLowerCase().contains(_searchQuery.toLowerCase()),
        )
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
            hintText: 'Rechercher un produit natif...',
            onChanged: (v) {
              _debounce?.cancel();
              _debounce = Timer(const Duration(milliseconds: 300), () {
                setState(() => _searchQuery = v);
              });
            },
          ),
        ),

        // Liste
        Expanded(
          child: Builder(
            builder: (context) {
              if (_loading) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              final products = _filtered;
              if (products.isEmpty) {
                return Center(
                  child: AppText(
                    'Aucun produit natif trouvé',
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
                    onTap: () {
                      final newSelected = isSelected ? null : p;
                      setState(() => _selected = newSelected);
                      widget.onProductChanged(newSelected);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.rw,
                        vertical: 12.rh,
                      ),
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
                                        .map(
                                          (q) => Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.rw,
                                              vertical: 3.rh,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(6.rr),
                                              border: Border.all(
                                                color: AppColors.inputBorder,
                                              ),
                                            ),
                                            child: AppText(
                                              '${q.quota ?? 0} ${q.unit ?? ''}',
                                              fontSize: 11.rsp,
                                              color: AppColors.textMuted,
                                            ),
                                          ),
                                        )
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
                            isSelected ? Icons.check_circle : Icons.circle_outlined,
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
      ],
    );
  }
}

// ─── Tab 3 : Créer un nouveau produit ────────────────────────────────────────

class _CreateProductTab extends StatefulWidget {
  final EmployeeModel employee;
  final ProductsCubit productsCubit;
  final MyFlotteCubit myFlotteCubit;
  final void Function(void Function(int)?) onRegisterSubmit;

  const _CreateProductTab({
    super.key,
    required this.employee,
    required this.productsCubit,
    required this.myFlotteCubit,
    required this.onRegisterSubmit,
  });

  @override
  State<_CreateProductTab> createState() => _CreateProductTabState();
}

class _CreateProductTabState extends State<_CreateProductTab> {
  final _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _quotaControllers = {};
  final Map<int, String> _unitSelections = {};

  @override
  void initState() {
    super.initState();
    widget.onRegisterSubmit(_submitWithFleetId);
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
      if (id == null) continue;
      if (!_quotaControllers.containsKey(id)) {
        _quotaControllers[id] = TextEditingController();
      }
      if (wallet.unit == 'MB_GB' && !_unitSelections.containsKey(id)) {
        _unitSelections[id] = 'GB';
      }
    }
  }

  @override
  void dispose() {
    widget.onRegisterSubmit(null);
    for (final c in _quotaControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _submitWithFleetId(int fleetNumberId) {
    if (!_formKey.currentState!.validate()) return;

    final resources = widget.productsCubit.wallets
        .where((w) => w.id != null)
        .map((w) {
          final text = _quotaControllers[w.id!]?.text.trim() ?? '';
          final val = double.tryParse(text);
          if (val == null || val <= 0) return null;
          // Pour MB_GB : 'GB' → 'MB_GB', 'MB' → 'MB'. Autres wallets : unit brute.
          final String unit;
          if (w.unit == 'MB_GB') {
            unit = (_unitSelections[w.id!] ?? 'GB') == 'GB' ? 'MB_GB' : 'MB';
          } else {
            unit = w.unit ?? '';
          }
          return {'wallet_id': w.id!, 'quantity': val, 'unit': unit};
        })
        .whereType<Map<String, dynamic>>()
        .toList();

    if (resources.isEmpty) return;

    widget.myFlotteCubit.manualProvisioning(data: {
      'product_id': null,
      'fleet_number_ids': [fleetNumberId],
      'resources': resources,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.rh),
            AppText(
              'WALLETS & QUOTAS',
              fontSize: 11.rsp,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
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
                    final isMbGb = wallet.unit == 'MB_GB';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppInput(
                          controller: _quotaControllers[id],
                          labelText:
                              "${wallet.name ?? '---'} (${(wallet.unit ?? '').replaceAll("_", " ou ")})",
                          hintText: '0',
                          keyboardType:
                              const TextInputType.numberWithOptions(decimal: true),
                          suffixIcon: isMbGb
                              ? _UnitToggle(
                                  selected: _unitSelections[id] ?? 'MB',
                                  onChanged: (unit) =>
                                      setState(() => _unitSelections[id] = unit),
                                )
                              : null,
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 24.rh),
          ],
        ),
      ),
    );
  }
}

// ─── Toggle MB / GB ───────────────────────────────────────────────────────────

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

// ─── Sélecteur de numéro de flotte ────────────────────────────────────────────

class _FleetNumberSelector extends StatelessWidget {
  final List<FleetNumberModel> fleetNumbers;
  final FleetNumberModel? selected;
  final void Function(FleetNumberModel?) onSelected;

  const _FleetNumberSelector({
    required this.fleetNumbers,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    if (fleetNumbers.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
      width: double.infinity,
      height: 100.rh,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Numéro à approvisionner',
            fontSize: 12.rsp,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
          SizedBox(height: 8.rh),
          Wrap(
            spacing: 8.rw,
            runSpacing: 6.rh,
            children: fleetNumbers.map((f) {
              final isSelected = selected?.id == f.id;
              return GestureDetector(
                onTap: () => onSelected(isSelected ? null : f),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.background,
                    borderRadius: BorderRadius.circular(20.rr),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.inputBorder,
                    ),
                  ),
                  child: AppText(
                    f.msisdn ?? '—',
                    fontSize: 12.rsp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.white : AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
