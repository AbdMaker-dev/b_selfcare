import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/employee/data_employee_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/approvisionner_drawer.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/confirm_disable_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/detail_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/form_edit_employe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/employe_action_dropdown.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/widgets/source_employe.dart';
import 'package:b_selfcare/src/views/pages/numeros/numeros_content.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/cubit/filter_tab_cubit.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/info_flotte_card.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class MyFlotteScreen extends StatefulWidget {
  const MyFlotteScreen({super.key});

  @override
  State<MyFlotteScreen> createState() => _MyFlotteScreenState();
}

class _MyFlotteScreenState extends State<MyFlotteScreen>
    with TickerProviderStateMixin {
  final myFlotte = getIt<MyFlotteCubit>();
  late final TabController _tabController;
  final _employeesTotal = ValueNotifier<int>(0);
  final _numerosTotal = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _employeesTotal.dispose();
    _numerosTotal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Header dynamique ────────────────────────────────────────────
        ListenableBuilder(
          listenable: Listenable.merge([_tabController, _employeesTotal, _numerosTotal]),
          builder: (context, _) {
            final current = _tabController.index;
            final total = current == 0 ? _employeesTotal.value : _numerosTotal.value;
            final title = current == 0 ? s.myFlotte : 'Mes Numéros';
            final highlight = current == 0 ? s.flotte : 'Numéros';
            final label = current == 0 ? 'EMPLOYÉS' : 'NUMÉROS';
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textHighlight(
                  title,
                  highlight: highlight,
                  fontSize: 24.rsp,
                  highlightColor: Colors.green,
                  fontFamily: FontFamily.fraunces,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                  highlightFontSize: 24.rsp,
                ),
                SizedBox(height: 8.rh),
                AppText(
                  total > 0 ? '$total $label' : '...',
                  fontSize: 16.rsp,
                  color: AppColors.inputBorderLight,
                ),
              ],
            );
          },
        ),
        SizedBox(height: 16.rh),

        // ─── Onglets pilules ─────────────────────────────────────────────
        AnimatedBuilder(
          animation: _tabController,
          builder: (context, _) {
            final current = _tabController.index;
            return Row(
              children: [
                _PillTab(
                  label: 'Ma Flotte',
                  icon: Icons.people_outline,
                  isActive: current == 0,
                  onTap: () => _tabController.animateTo(0),
                ),
                SizedBox(width: 10.rw),
                _PillTab(
                  label: 'Mes Numéros',
                  icon: Icons.sim_card_outlined,
                  isActive: current == 1,
                  onTap: () => _tabController.animateTo(1),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 20.rh),

        // ─── Contenu des onglets ─────────────────────────────────────────
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _EmployesTab(
                myFlotte: myFlotte,
                s: s,
                onTotalChanged: (v) => _employeesTotal.value = v,
              ),
              NumerosContent(
                onTotalChanged: (v) => _numerosTotal.value = v,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Onglet Employés ─────────────────────────────────────────────────────────

class _EmployesTab extends StatefulWidget {
  final MyFlotteCubit myFlotte;
  final S s;
  final void Function(int) onTotalChanged;
  const _EmployesTab({required this.myFlotte, required this.s, required this.onTotalChanged});

  @override
  State<_EmployesTab> createState() => _EmployesTabState();
}

class _EmployesTabState extends State<_EmployesTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _skipSearchListener = false;

  int _currentPage = 1;
  String _searchQuery = '';
  String? _statusFilter;
  DataEmployeeResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    widget.myFlotte.getEmployees(data: {'page': _currentPage});
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_skipSearchListener) return;
    final value = _searchController.text;
    if (value == _searchQuery) return;
    setState(() { _searchQuery = value; _currentPage = 1; });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.myFlotte.getEmployees(data: _buildParams(page: 1));
    });
  }

  Map<String, dynamic> _buildParams({int? page}) {
    final params = <String, dynamic>{'page': page ?? _currentPage};
    if (_searchQuery.isNotEmpty) params['search'] = _searchQuery;
    if (_statusFilter != null) params['status'] = _statusFilter;
    return params;
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    widget.myFlotte.getEmployees(data: _buildParams(page: page));
  }

  void _resetFilters() {
    _debounce?.cancel();
    _skipSearchListener = true;
    setState(() {
      _searchQuery = '';
      _statusFilter = null;
      _currentPage = 1;
    });
    _searchController.clear();
    _skipSearchListener = false;
    getIt<FilterTabCubit>().selectTab(0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyFlotteCubit, MyFlotteState>(
      bloc: widget.myFlotte,
      listener: (context, state) {
        state.maybeWhen(
          getEmployeesFailed: (message) {},
          disableEmployeeLoaded: (_) {
            _resetFilters();
            widget.myFlotte.getEmployees(data: {'page': 1});
          },
          disableEmployeeFailed: (message) {},
          removeNumbersLoaded: (_) => widget.myFlotte.getEmployees(data: _buildParams()),
          removeNumbersFailed: (message) {},
          assignNumbersLoaded: (_) => widget.myFlotte.getEmployees(data: _buildParams()),
          assignNumbersFailed: (message) {},
          downloadFileEmployesFailed: (message) {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetEmployeesLoaded) _cachedData = state.data;

        final isLoading = state is GetEmployeesLoading;
        final employees = _cachedData?.data?.employees ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        WidgetsBinding.instance.addPostFrameCallback((_) => widget.onTotalChanged(total));

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Row(
                  children: [
                    EmployeActionDropdown(
                      myFlotteCubit: widget.myFlotte,
                      onCreated: () => widget.myFlotte.getEmployees(data: _buildParams()),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            AppSearchInput(
              controller: _searchController,
            ),
            SizedBox(height: 20.rh),
            FilterTabsWidget(
              tabs: [
                FilterTab(label: 'Tous', count: total > 0 ? total : null),
                const FilterTab(label: 'Active'),
                const FilterTab(label: 'Inactive'),
              ],
              onTabChanged: (model) {
                setState(() {
                  _statusFilter = model.label == 'Tous' ? null : model.label.toUpperCase();
                  _currentPage = 1;
                });
                widget.myFlotte.getEmployees(data: _buildParams(page: 1));
              },
            ),
            SizedBox(height: 20.rh),
            if (isLoading && employees.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else ...[
             /* LayoutBuilder(
                builder: (context, constraints) {
                  final totalWidth = constraints.maxWidth;
                  final crossAxisCount = totalWidth > 900 ? 3 : totalWidth > 550 ? 2 : 1;
                  final spacing = 12.rw;
                  final cardWidth = (totalWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

                  final cards = employees.take(6).map((e) {
                    final name = '${e.firstName ?? ''} ${e.lastName ?? ''}'.trim();
                    return InfoFlotteCard(
                      name: name.isNotEmpty ? name : '-',
                      department: e.position ?? '-',
                      forfait: '${e.fleetNumbersCount ?? 0} numéros',
                      fleetNumbers: e.fleetNumbers?.map((f) => f.msisdn ?? '').toList() ?? [],
                      status: e.status == 'active' || e.status == 'ACTIVE',
                      onTap: () => DetailEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                    );
                  }).toList();

                  if (cards.isEmpty) return const SizedBox.shrink();

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 12.rh,
                    children: cards.map((card) => SizedBox(width: cardWidth, child: card)).toList(),
                  );
                },
              ),
              SizedBox(height: 20.rh),*/
              AppTable(
                title: widget.s.flotteComplete,
                source: SourceEmployes(
                  rows: employees,
                  onDetail: (e) => DetailEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                  onEdit: (e) => FormEditEmploye.show(
                    context,
                    employee: e,
                    myFlotteCubit: widget.myFlotte,
                    onUpdated: () => widget.myFlotte.getEmployees(data: _buildParams()),
                  ),
                  onApprovisionner: (e) => ApprovisionnerDrawer.show(context, employee: e),
                  onDisable: (e) => ConfirmDisableEmploye.show(context, employee: e, myFlotteCubit: widget.myFlotte),
                ),
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

// ─── Onglet Numéros ───────────────────────────────────────────────────────────

// ─── Pilule d'onglet ──────────────────────────────────────────────────────────

class _PillTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _PillTab({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.grayWh,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isActive ? AppColors.primary : AppColors.gray,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.rw, vertical: 10.rh),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16.rsp,
                color: isActive ? AppColors.white : AppColors.textMuted,
              ),
              SizedBox(width: 7.rw),
              AppText(
                label,
                fontSize: 14.rsp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.white : AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
