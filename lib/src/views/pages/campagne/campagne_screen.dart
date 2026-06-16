import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/detail_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_execution_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_provisioning_logs.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CampagneScreen extends StatefulWidget {
  const CampagneScreen({super.key});
  @override
  State<CampagneScreen> createState() => _CampagneScreenState();
}

class _CampagneScreenState extends State<CampagneScreen> with TickerProviderStateMixin {
  final campagne = getIt<CampagneCubit>();
  late final TabController _tabController;
  final _campagnesTotal = ValueNotifier<int>(0);
  final _logsTotal = ValueNotifier<int>(0);
  final _executionsTotal = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _campagnesTotal.dispose();
    _logsTotal.dispose();
    _executionsTotal.dispose();
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
          listenable: Listenable.merge([_tabController, _campagnesTotal, _logsTotal, _executionsTotal]),
          builder: (context, _) {
            final current = _tabController.index;
            final totals = [_campagnesTotal.value, _logsTotal.value, _executionsTotal.value];
            final titles    = ['Mes Campagnes', 'Provisioning', 'Exécutions'];
            final highlights = ['Campagnes', 'Provisioning', 'Exécutions'];
            final labels    = ['CAMPAGNES', 'LOGS', 'EXÉCUTIONS'];
            final total = totals[current];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.textHighlight(
                  titles[current],
                  highlight: highlights[current],
                  fontSize: 24.rsp,
                  highlightColor: AppColors.warning,
                  fontFamily: FontFamily.montserrat,
                  fontWeight: FontWeight.w400,
                  highlightFontSize: 24.rsp,
                ),
                SizedBox(height: 8.rh),
                AppText(
                  total > 0 ? '$total ${labels[current]}' : '...',
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
                  label: s.myCampagne,
                  icon: Icons.campaign_outlined,
                  isActive: current == 0,
                  onTap: () => _tabController.animateTo(0),
                ),
                SizedBox(width: 10.rw),
                _PillTab(
                  label: 'Provisioning',
                  icon: Icons.sync_alt_outlined,
                  isActive: current == 1,
                  onTap: () => _tabController.animateTo(1),
                ),
                SizedBox(width: 10.rw),
                _PillTab(
                  label: 'Exécutions',
                  icon: Icons.play_circle_outline,
                  isActive: current == 2,
                  onTap: () => _tabController.animateTo(2),
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
              _CampagnesTab(
                cubit: campagne,
                onTotalChanged: (v) => _campagnesTotal.value = v,
              ),
              _ProvisioningTab(
                cubit: campagne,
                onTotalChanged: (v) => _logsTotal.value = v,
              ),
              _ExecutionsTab(
                cubit: campagne,
                onTotalChanged: (v) => _executionsTotal.value = v,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Tab Campagnes ────────────────────────────────────────────────────────────

class _CampagnesTab extends StatefulWidget {
  final CampagneCubit cubit;
  final void Function(int) onTotalChanged;
  const _CampagnesTab({required this.cubit, required this.onTotalChanged});

  @override
  State<_CampagnesTab> createState() => _CampagnesTabState();
}

class _CampagnesTabState extends State<_CampagnesTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  int _currentPage = 1;
  String _searchQuery = '';
  String? _statusFilter;
  DataCampaignResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    widget.cubit.getCampaigns(data: {'page': _currentPage});
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
    final value = _searchController.text;
    if (value == _searchQuery) return;
    setState(() { _searchQuery = value; _currentPage = 1; });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.cubit.getCampaigns(data: _buildParams(page: 1));
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
    widget.cubit.getCampaigns(data: _buildParams(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampagneCubit, CampagneState>(
      bloc: widget.cubit,
      listener: (context, state) {
        state.maybeWhen(
          getCampaignsFailed: (_) {},
          executeCampaignsLoaded: (_) => WidgetsBinding.instance.addPostFrameCallback(
            (_) { if (mounted) widget.cubit.getCampaigns(data: _buildParams()); },
          ),
          executeCampaignsFailed: (_) {},
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetCampaignsLoaded) _cachedData = state.data;

        final isLoading = state is GetCampaignsLoading || state is ExecuteCampaignsLoading;
        final campaigns = _cachedData?.data?.campaigns ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        WidgetsBinding.instance.addPostFrameCallback((_) => widget.onTotalChanged(total));

        final options = meta?.availableStatusesOptions?.isNotEmpty == true
            ? meta!.availableStatusesOptions!
            : meta?.availableStatuses ?? [];
        final statusTabs = options
            .map((s) => FilterTab(label: s.label ?? s.value ?? '', value: s.value))
            .toList();

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            AppSearchInput(controller: _searchController),
            SizedBox(height: 20.rh),
            _FilterRow(
              tabs: [const FilterTab(label: 'Tous'), ...statusTabs],
              onTabChanged: (tab) {
                setState(() { _statusFilter = tab.value; _currentPage = 1; });
                widget.cubit.getCampaigns(data: _buildParams(page: 1));
              },
            ),
            SizedBox(height: 20.rh),
            if (isLoading && campaigns.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else
              AppTable(
                title: 'Mes Campagnes',
                source: SourceCampagne(
                  rows: campaigns,
                  onDetail: (campaign) => DetailCampagne.show(
                    context,
                    campaign: campaign,
                    campagneCubit: widget.cubit,
                  ),
                  onExecute: (campaign, execute) {
                    if (campaign.id == null) return;
                    widget.cubit.executeCampaigns(id: campaign.id!, execute: execute);
                  },
                ),
                currentPage: _currentPage,
                totalCount: total,
                activePreviousClicked: _currentPage > 1,
                activeNextClicked: _currentPage < lastPage,
                onPreviousClicked: _currentPage > 1 ? () => _fetchPage(_currentPage - 1) : null,
                onNextClicked: _currentPage < lastPage ? () => _fetchPage(_currentPage + 1) : null,
              ),
          ],
        );
      },
    );
  }
}

// ─── Tab Provisioning ─────────────────────────────────────────────────────────

class _ProvisioningTab extends StatefulWidget {
  final CampagneCubit cubit;
  final void Function(int) onTotalChanged;
  const _ProvisioningTab({required this.cubit, required this.onTotalChanged});

  @override
  State<_ProvisioningTab> createState() => _ProvisioningTabState();
}

class _ProvisioningTabState extends State<_ProvisioningTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  int _currentPage = 1;
  String _searchQuery = '';
  String? _statusFilter;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetch();
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
    final value = _searchController.text;
    if (value == _searchQuery) return;
    setState(() { _searchQuery = value; _currentPage = 1; });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => _fetch(page: 1));
  }

  Map<String, dynamic> _buildParams({int? page}) {
    final params = <String, dynamic>{'page': page ?? _currentPage};
    if (_searchQuery.isNotEmpty) params['search'] = _searchQuery;
    if (_statusFilter != null) params['status'] = _statusFilter;
    return params;
  }

  void _fetch({int? page}) {
    if (page != null) setState(() => _currentPage = page);
    setState(() => _loading = true);
    widget.cubit.getProvisioningLogs(params: _buildParams(page: page)).then((_) {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.cubit.provisioningLogsData?.data;
    final items = data?.items ?? [];
    final summary = data?.summary;
    final pagination = data?.pagination;
    final lastPage = pagination?.lastPage ?? 1;
    final isLoading = _loading;
    final total = pagination?.total ?? 0;

        WidgetsBinding.instance.addPostFrameCallback((_) => widget.onTotalChanged(total));

        final statuses = pagination?.availableStatuses ?? [];
        final statusTabs = statuses
            .map((s) => FilterTab(label: s.label ?? s.value ?? '', value: s.value))
            .toList();

        return ListView(
          padding: EdgeInsets.only(bottom: 50.rh),
          children: [
            if (summary != null) ...[
              Row(
                spacing: 10.rw,
                children: [
                  _SummaryChip(label: 'Total', value: '${summary.total ?? 0}', color: AppColors.primary),
                  _SummaryChip(label: 'Succès', value: '${summary.success ?? 0}', color: AppColors.success),
                  _SummaryChip(label: 'Échec', value: '${summary.failed ?? 0}', color: AppColors.error),
                  _SummaryChip(label: 'En attente', value: '${summary.pending ?? 0}', color: AppColors.warning),
                ],
              ),
              SizedBox(height: 20.rh),
            ],
            AppSearchInput(controller: _searchController),
            SizedBox(height: 20.rh),
            _FilterRow(
              tabs: [const FilterTab(label: 'Tous'), ...statusTabs],
              onTabChanged: (tab) {
                setState(() { _statusFilter = tab.value; _currentPage = 1; });
                _fetch(page: 1);
              },
            ),
            SizedBox(height: 20.rh),
            if (isLoading && items.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else
              AppTable(
                title: 'Provisioning',
                source: SourceProvisioningLogs(rows: items),
                currentPage: _currentPage,
                totalCount: total,
                activePreviousClicked: _currentPage > 1,
                activeNextClicked: _currentPage < lastPage,
                onPreviousClicked: _currentPage > 1 ? () => _fetch(page: _currentPage - 1) : null,
                onNextClicked: _currentPage < lastPage ? () => _fetch(page: _currentPage + 1) : null,
              ),
          ],
        );
  }
}

// ─── Tab Exécutions ───────────────────────────────────────────────────────────

class _ExecutionsTab extends StatefulWidget {
  final CampagneCubit cubit;
  final void Function(int) onTotalChanged;
  const _ExecutionsTab({required this.cubit, required this.onTotalChanged});

  @override
  State<_ExecutionsTab> createState() => _ExecutionsTabState();
}

class _ExecutionsTabState extends State<_ExecutionsTab> {
  final _searchController = TextEditingController();
  Timer? _debounce;
  int _currentPage = 1;
  String _searchQuery = '';
  String? _statusFilter;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetch();
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
    final value = _searchController.text;
    if (value == _searchQuery) return;
    setState(() { _searchQuery = value; _currentPage = 1; });
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () => _fetch(page: 1));
  }

  Map<String, dynamic> _buildParams({int? page}) {
    final params = <String, dynamic>{'page': page ?? _currentPage};
    if (_searchQuery.isNotEmpty) params['search'] = _searchQuery;
    if (_statusFilter != null) params['status'] = _statusFilter;
    return params;
  }

  void _fetch({int? page}) {
    if (page != null) setState(() => _currentPage = page);
    setState(() => _loading = true);
    widget.cubit.getExecutions(params: _buildParams(page: page)).then((_) {
      if (mounted) setState(() => _loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.cubit.executionsData?.data;
    final executions = data?.executions ?? [];
    final meta = data?.meta;
    final lastPage = meta?.lastPage ?? 1;
    final total = meta?.total ?? 0;

    WidgetsBinding.instance.addPostFrameCallback((_) => widget.onTotalChanged(total));

    final options = meta?.availableStatusesOptions?.isNotEmpty == true
        ? meta!.availableStatusesOptions!
        : meta?.availableStatuses ?? [];
    final statusTabs = options
        .map((s) => FilterTab(label: s.label ?? s.value ?? '', value: s.value))
        .toList();

    return ListView(
      padding: EdgeInsets.only(bottom: 50.rh),
      children: [
        AppSearchInput(controller: _searchController),
        SizedBox(height: 20.rh),
        _FilterRow(
          tabs: [const FilterTab(label: 'Tous'), ...statusTabs],
          onTabChanged: (tab) {
            setState(() { _statusFilter = tab.value; _currentPage = 1; });
            _fetch(page: 1);
          },
        ),
        SizedBox(height: 20.rh),
        if (_loading && executions.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60.rh),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          )
        else
          AppTable(
            title: 'Exécutions',
            source: SourceExecutionCampagne(rows: executions),
            currentPage: _currentPage,
            totalCount: total,
            activePreviousClicked: _currentPage > 1,
            activeNextClicked: _currentPage < lastPage,
            onPreviousClicked: _currentPage > 1 ? () => _fetch(page: _currentPage - 1) : null,
            onNextClicked: _currentPage < lastPage ? () => _fetch(page: _currentPage + 1) : null,
          ),
      ],
    );
  }
}

// ─── Pilule d'onglet ──────────────────────────────────────────────────────────

class _PillTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _PillTab({required this.label, required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.grayWh,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.gray),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.rw, vertical: 10.rh),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16.rsp, color: isActive ? AppColors.white : AppColors.textMuted),
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

// ─── Filtre local (sans FilterTabCubit global) ────────────────────────────────

class _FilterRow extends StatefulWidget {
  final List<FilterTab> tabs;
  final void Function(FilterTab) onTabChanged;
  const _FilterRow({required this.tabs, required this.onTabChanged});

  @override
  State<_FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<_FilterRow> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 8.rh),
      child: Row(
        children: List.generate(widget.tabs.length, (i) {
          final tab = widget.tabs[i];
          final isSelected = _selectedIndex == i;
          return Padding(
            padding: EdgeInsets.only(right: 8.rw),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedIndex = i);
                widget.onTabChanged(tab);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 6.rh),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                  borderRadius: BorderRadius.circular(999.rr),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.gray,
                    width: isSelected ? 1.5 : 1.2,
                  ),
                ),
                child: Text(
                  tab.count != null ? '${tab.label} (${tab.count})' : tab.label,
                  style: TextStyle(
                    fontSize: 13.rsp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Widgets helpers ──────────────────────────────────────────────────────────

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _SummaryChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 6.rw,
        children: [
          AppText(value, fontSize: 14.rsp, fontWeight: FontWeight.w700, color: color),
          AppText(label, fontSize: 11.rsp, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final String label;
  final bool enabled;
  final VoidCallback onTap;
  const _PageBtn({required this.label, required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 6.rh),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.rr),
          border: Border.all(color: enabled ? AppColors.primary : AppColors.gray),
        ),
        child: AppText(
          label,
          fontSize: 12.rsp,
          fontWeight: FontWeight.w500,
          color: enabled ? AppColors.primary : AppColors.textMuted,
        ),
      ),
    );
  }
}
