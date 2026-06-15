import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/data/models/meta_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/detail_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_campagne.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CampagneScreen extends StatefulWidget {
  const CampagneScreen({super.key});

  @override
  State<CampagneScreen> createState() => _CampagneScreenState();
}

class _CampagneScreenState extends State<CampagneScreen> {
  final campagne = getIt<CampagneCubit>();
  final _searchController = TextEditingController();
  Timer? _debounce;

  int _currentPage = 1;
  String _searchQuery = '';
  String? _statusFilter;
  DataCampaignResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    campagne.getCampaigns(data: {'page': _currentPage});
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
      campagne.getCampaigns(data: _buildParams(page: 1));
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
    campagne.getCampaigns(data: _buildParams(page: page));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampagneCubit, CampagneState>(
      bloc: campagne,
      listener: _onStateChanged,
      builder: _buildContent,
    );
  }

  void _onStateChanged(BuildContext context, CampagneState state) {
    state.maybeWhen(
      getCampaignsFailed: (_) {},
      executeCampaignsLoaded: (_) => WidgetsBinding.instance.addPostFrameCallback(
        (_) { if (mounted) campagne.getCampaigns(data: _buildParams()); },
      ),
      executeCampaignsFailed: (_) {},
      orElse: () {},
    );
  }

  Widget _buildContent(BuildContext context, CampagneState state) {
    if (state is GetCampaignsLoaded) _cachedData = state.data;

    final isLoading = state is GetCampaignsLoading || state is ExecuteCampaignsLoading;
    final campaigns = _cachedData?.data?.campaigns ?? [];
    final meta = _cachedData?.data?.meta;
    final total = meta?.total ?? 0;
    final lastPage = meta?.lastPage ?? 1;

    return ListView(
      padding: EdgeInsets.only(bottom: 50.rh),
      children: [
        _buildHeader(context, total),
        SizedBox(height: 30.rh),
        AppSearchInput(
          controller: _searchController,
        ),
        SizedBox(height: 20.rh),
        _buildFilterTabs(meta),
        SizedBox(height: 20.rh),
        if (isLoading && campaigns.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 60.rh),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          )
        else
          _buildTable(context, campaigns, total, lastPage),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, int total) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.textHighlight(
          s.myCampagne,
          highlight: s.campagne,
          fontSize: 24.rsp,
          highlightColor: AppColors.warning,
          fontFamily: FontFamily.montserrat,
          //fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          highlightFontSize: 24.rsp,
        ),
        SizedBox(height: 8.rh),
        AppText(
          total > 0
          ? '$total campagnes · Provisioning automatique CBS'
          : 'Provisioning automatique - CBS - DAILY / WEEKLY / MONTHLY',
          fontSize: 16.rsp,
          color: AppColors.inputBorderLight,
        ),
      ],
    );
  }

  Widget _buildFilterTabs(MetaModel? meta) {
    final options = meta?.availableStatusesOptions?.isNotEmpty == true
        ? meta!.availableStatusesOptions!
        : meta?.availableStatuses ?? [];

    final statusTabs = options
        .map((s) => FilterTab(label: s.label ?? s.value ?? '', value: s.value))
        .toList();

    return FilterTabsWidget(
      tabs: [const FilterTab(label: 'Tous'), ...statusTabs],
      onTabChanged: (tab) {
        setState(() { _statusFilter = tab.value; _currentPage = 1; });
        campagne.getCampaigns(data: _buildParams(page: 1));
      },
    );
  }

  Widget _buildTable(BuildContext context, List<CampaignModel> campaigns, int total, int lastPage) {
    final s = S.of(context);
    return AppTable(
      title: s.myCampagne,
      source: SourceCampagne(
        rows: campaigns,
        onDetail: (campaign) => DetailCampagne.show(
          context,
          campaign: campaign,
          campagneCubit: campagne,
        ),
        onExecute: (campaign, execute) {
          if (campaign.id == null) return;
          campagne.executeCampaigns(id: campaign.id!, execute: execute);
        },
      ),
      currentPage: _currentPage,
      totalCount: total,
      activePreviousClicked: _currentPage > 1,
      activeNextClicked: _currentPage < lastPage,
      onPreviousClicked: _currentPage > 1 ? () => _fetchPage(_currentPage - 1) : null,
      onNextClicked: _currentPage < lastPage ? () => _fetchPage(_currentPage + 1) : null,
    );
  }
}
