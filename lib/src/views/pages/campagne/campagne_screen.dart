import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/campaign/data_campaign_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/campagne/cubit/campagne_cubit.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/detail_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/form_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_campagne.dart';
import 'package:b_selfcare/src/views/pages/campagne/widgets/source_historique_campagne.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:b_selfcare/src/views/widgets/table/title_table.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CampagneScreen extends StatefulWidget {
  const CampagneScreen({super.key});

  @override
  State<CampagneScreen> createState() => _CampagneScreenState();
}

class _CampagneScreenState extends State<CampagneScreen> {
  final campagne = getIt<CampagneCubit>();

  int _currentPage = 1;
  DataCampaignResponseModel? _cachedData;

  static const _historiqueFilters = <TableFilter>[
    (label: 'Tous',    value: 'tous'),
    (label: 'Actifs',  value: 'active'),
    (label: 'Inactifs',value: 'inactive'),
    (label: 'En pause',value: 'paused'),
  ];

  String _selectedHistoriqueFilter = 'tous';

  @override
  void initState() {
    super.initState();
    campagne.getCampaigns(data: {'page': _currentPage});
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    campagne.getCampaigns(data: {'page': page});
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return BlocConsumer<CampagneCubit, CampagneState>(
      bloc: campagne,
      listener: (context, state) {
        state.maybeWhen(
          getCampaignsFailed: (message) {},
          executeCampaignsLoaded: (_) =>
              WidgetsBinding.instance.addPostFrameCallback(
                (_) { if (mounted) campagne.getCampaigns(data: {'page': _currentPage}); },
              ),
          executeCampaignsFailed: (message){},
          orElse: () {},
        );
      },
      builder: (context, state) {
        if (state is GetCampaignsLoaded) {
          _cachedData = state.data;
        }

        final isLoading = state is GetCampaignsLoading || state is ExecuteCampaignsLoading;
        final campaigns = _cachedData?.data?.campaigns ?? [];
        final meta = _cachedData?.data?.meta;
        final total = meta?.total ?? 0;
        final lastPage = meta?.lastPage ?? 1;

        final filteredHistorique = _selectedHistoriqueFilter == 'tous'
            ? campaigns
            : campaigns.where((c) => c.status?.toLowerCase() == _selectedHistoriqueFilter).toList();

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
                      s.myCampagne,
                      highlight: s.campagne,
                      fontSize: 22.rsp,
                      highlightColor: AppColors.warning,
                      fontFamily: FontFamily.syne,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0
                          ? '$total campagnes · Provisioning automatique CBS'
                          : 'Provisioning automatique - CBS - DAILY / WEEKLY / MONTHLY',
                      fontSize: 11.rsp,
                      color: AppColors.textMuted,
                    ),
                  ],
                ),
/*                const Spacer(),
                AppButton(
                  text: '+ ${s.campagne}',
                  type: AppButtonType.secondary,
                  width: 130.rw,
                  height: 38.rh,
                  fontSize: 13.rsp,
                  onPressed: () {},
                ),*/
              ],
            ),
            SizedBox(height: 30.rh),
            AppSearchInput(
              onChanged: (value){
                campagne.getCampaigns(data: {'search': value});
              },
            ),
            SizedBox(height: 20.rh),
            FilterTabsWidget(
              tabs: [
                FilterTab(label: 'Tous'),
                const FilterTab(label: 'ACTIVE'),
                const FilterTab(label: 'BLOCKED'),
                const FilterTab(label: 'PAUSED'),
                const FilterTab(label: 'CANCELLED'),
                const FilterTab(label: 'COMPLETED'),
              ],
              onTabChanged: (model) {
                model.label == "Tous" ?
                campagne.getCampaigns(data: {'page': _currentPage}):
                campagne.getCampaigns(data: {'status': model.label.toUpperCase()});
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
            else ...[
              AppTable(
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
              ),
/*              SizedBox(height: 30.rh),
              AppTable(
                title: s.historique,
                source: SourceHistoriqueCampagne(rows: filteredHistorique),
                hidePaginator: true,
                filters: _historiqueFilters,
                selectedFilter: _selectedHistoriqueFilter,
                onFilterChanged: (value) => setState(() => _selectedHistoriqueFilter = value),
              ),*/
            ],
          ],
        );
      },
    );
  }
}
