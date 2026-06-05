import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/users/cubit/users_cubit.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/confirm_delete_user.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/detail_user.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/source_user.dart';
import 'package:b_selfcare/src/views/pages/users/widgets/user_form.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_search_input.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab.dart';
import 'package:b_selfcare/src/views/widgets/filter_tab/filter_tab_widget.dart';
import 'package:b_selfcare/src/views/widgets/table/app_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final _cubit = getIt<UsersCubit>();
  int _currentPage = 1;
  String? _statusFilter;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit.getUsers(data: {'page': _currentPage});

    // _cubit.fetchRoles();
  }

  Map<String, dynamic> _buildParams({int? page}) {
    final params = <String, dynamic>{'page': page ?? _currentPage};
    if (_searchQuery.isNotEmpty) params['search'] = _searchQuery;
    if (_statusFilter != null) params['status'] = _statusFilter;
    return params;
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    _cubit.getUsers(data: _buildParams(page: page));
  }

  void _showDetail(UserProfileModel user) {
    DetailUser.show(context, userPreview: user, usersCubit: _cubit);
  }

  void _showEdit(UserProfileModel? user) {
    UserForm.show(context, user: user);
  }

  void _showDisable(UserProfileModel user) {
    ConfirmDeleteUser.show(context, user: user, usersCubit: _cubit);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      bloc: _cubit,
      listener: (context, state) {
        state.maybeWhen(
          disableUserLoaded: () => _cubit.getUsers(data: _buildParams()),
          createUserLoaded:  () => _cubit.getUsers(data: _buildParams()),
          updateUserLoaded:  () => _cubit.getUsers(data: _buildParams()),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final users      = _cubit.users;
        final total      = _cubit.totalCount;
        final lastPage   = _cubit.lastPage;
        final isLoading  = state is GetUsersLoading;
        final filterTabs = [
          const FilterTab(label: 'Tous'),
          ..._cubit.availableStatuses
              .where((s) => s.label != null && s.value != null)
              .map((s) => FilterTab(label: s.label!, value: s.value)),
        ];

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
                      'Gestion des utilisateurs',
                      highlight: 'utilisateurs',
                      fontSize: 24.rsp,
                      fontFamily: FontFamily.fraunces,
                      fontStyle: FontStyle.italic,
                      highlightColor: AppColors.warning,
                      fontWeight: FontWeight.w400,
                      highlightFontSize: 24.rsp,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0 ? '$total utilisateurs enregistrés' : 'Gestion des accès et des rôles',
                      fontSize: 16.rsp,
                      color: AppColors.inputBorderLight,
                    ),
                  ],
                ),
                const Spacer(),
                AppButton(
                  text: 'Utilisateur',
                  icon: Icons.add_circle_outline,
                  type: AppButtonType.secondary,
                  onPressed: () => _showEdit(null),
                  width: 140.rw,
                  height: 60.rh,
                  fontSize: 15.rsp,
                ),
              ],
            ),
            SizedBox(height: 24.rh),
            AppSearchInput(
              onChanged: (value) {
                setState(() { _searchQuery = value; _currentPage = 1; });
                _cubit.getUsers(data: _buildParams(page: 1));
              },
            ),
            SizedBox(height: 16.rh),
            FilterTabsWidget(
              key: ValueKey(filterTabs.map((t) => t.value).join(',')),
              tabs: filterTabs,
              onTabChanged: (tab) {
                setState(() { _statusFilter = tab.value; _currentPage = 1; });
                _cubit.getUsers(data: _buildParams(page: 1));
              },
            ),
            SizedBox(height: 20.rh),
            if (isLoading && users.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 60.rh),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              )
            else
              AppTable<UserProfileModel>(
                title: 'Utilisateurs',
                source: SourceUsers(
                  rows: users,
                  onDetail:  _showDetail,
                  onEdit:    _showEdit,
                  onDisable: _showDisable,
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


