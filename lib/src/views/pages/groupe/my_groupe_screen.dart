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
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MyGroupeScreen extends StatefulWidget {
  const MyGroupeScreen({super.key});

  @override
  State<MyGroupeScreen> createState() => _MyGroupeScreenState();
}

class _MyGroupeScreenState extends State<MyGroupeScreen> {
  final groupCubit = getIt<GroupCubit>();

  int _currentPage = 1;
  DataGroupResponseModel? _cachedData;

  @override
  void initState() {
    super.initState();
    groupCubit.getGroups(data: {'page': _currentPage});
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    groupCubit.getGroups(data: {'page': page});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GroupCubit, GroupState>(
      bloc: groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          getGroupsFailed: (message){},
          updateGroupeLoaded: (_) {
            groupCubit.getGroups(data: {'page': _currentPage});
          },
          updateGroupeFailed: (message) {},
          deleteGroupeLoaded: (_) {
            groupCubit.getGroups(data: {'page': _currentPage});
          },
          deleteGroupeFailed: (message) {},
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
                      fontSize: 22.rsp,
                      highlightColor: AppColors.warning,
                      fontFamily: FontFamily.syne,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0
                      ? '$total groupes · Gestion des groupes d\'employés'
                      : 'Organisez vos employés par groupes et produits',
                      fontSize: 14.rsp,
                      color: AppColors.textMuted,
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
                    onCreated: () => groupCubit.getGroups(data: {'page': _currentPage}),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.rh),
            AppSearchInput(
              onChanged: (value){
                groupCubit.getGroups(data: {'search': value});
              },
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
