import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/group/data_group_response_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/confirm_delete_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/detail_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_edit_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/form_groupe.dart';
import 'package:b_selfcare/src/views/pages/groupe/widgets/source_groupe.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyGroupeScreen extends StatefulWidget {
  const MyGroupeScreen({super.key});

  @override
  State<MyGroupeScreen> createState() => _MyGroupeScreenState();
}

class _MyGroupeScreenState extends State<MyGroupeScreen> {
  final groupCubit = getIt<GroupCubit>();
  final _searchController = TextEditingController();
  Timer? _debounce;
  bool _skipSearchListener = false;

  int _currentPage = 1;
  String _searchQuery = '';
  DataGroupResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    groupCubit.getGroups(data: {'page': _currentPage});
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
      groupCubit.getGroups(data: _buildParams(page: 1));
    });
  }

  Map<String, dynamic> _buildParams({int? page}) {
    final params = <String, dynamic>{'page': page ?? _currentPage};
    if (_searchQuery.isNotEmpty) params['search'] = _searchQuery;
    return params;
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    groupCubit.getGroups(data: _buildParams(page: page));
  }

  void _resetFilters() {
    _debounce?.cancel();
    _skipSearchListener = true;
    setState(() {
      _searchQuery = '';
      _currentPage = 1;
    });
    _searchController.clear();
    _skipSearchListener = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          getGroupsFailed: (message) {},
          updateGroupeLoaded: (_) {
            groupCubit.getGroups(data: _buildParams());
          },
          updateGroupeFailed: (message) {},
          deleteGroupeLoaded: (_) {
            _resetFilters();
            groupCubit.getGroups(data: {'page': 1});
          },
          deleteGroupeFailed: (message) {},
          configNotifGroupeLoaded: (_) {
            groupCubit.getGroups(data: _buildParams());
          },
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
                      fontSize: 24.rsp,
                      highlightColor: AppColors.warning,
                      fontFamily: FontFamily.montserrat,
                      // fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      highlightFontSize: 24.rsp,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0
                      ? '$total groupes · Gestion des groupes d\'employés'
                      : 'Organisez vos employés par groupes et produits',
                      fontSize: 16.rsp,
                      color: AppColors.inputBorderLight,
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: 'Groupe',
                  icon: Icons.add_circle_outline,
                  type: AppButtonType.secondary,
                  width: 140.rw,
                  height: 60.rh,
                  fontSize: 15.rsp,
                  onPressed: () => FormGroupe.show(
                    context,
                    groupCubit: groupCubit,
                    onCreated: () => groupCubit.getGroups(data: _buildParams()),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            AppSearchInput(
              controller: _searchController,
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
                source: SourceGroupe(
                  rows: groups,
                  onDetail: (groupe) => DetailGroupe.show(
                    context,
                    groupe: groupe,
                    groupCubit: groupCubit,
                  ),
                  onEdit: (groupe) => FormEditGroupe.show(
                    context,
                    groupe: groupe,
                    groupCubit: groupCubit,
                  ),
                  onDelete: (groupe) => ConfirmDeleteGroupe.show(
                    context,
                    groupe: groupe,
                    groupCubit: groupCubit,
                  ),
                  onToggleNotification: (groupe) {
                    final id = groupe.id;
                    if (id == null) return;
                    groupCubit.configurationNotificationGroupe(
                      id: id,
                      data: {
                        'sms_notification_enabled':
                            !(groupe.smsNotificationEnabled ?? false),
                        'sms_notification_template':
                            groupe.smsNotificationTemplate ?? '',
                      },
                    );
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
          ],
        );
      },
    );
  }
}
