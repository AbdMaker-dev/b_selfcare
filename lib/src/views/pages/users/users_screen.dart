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
import 'package:b_selfcare/src/views/widgets/ctrt_dialogs.dart';
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

  @override
  void initState() {
    super.initState();
    _cubit.getUsers(data: {'page': _currentPage});

    // _cubit.fetchRoles();
  }

  void _fetchPage(int page) {
    setState(() => _currentPage = page);
    _cubit.getUsers(data: {'page': page});
  }

  void _showDetail(UserProfileModel user) {
    DetailUser.show(context, userPreview: user, usersCubit: _cubit);
  }

  void _showEdit(UserProfileModel? user) {
    AppDialogs.popup(
      context: context,
      width: 600,
      height: 0.47,
      contents: UserForm(user: user),
    );
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
          disableUserLoaded: () => _cubit.getUsers(data: {'page': _currentPage}),
          createUserLoaded:  () => _cubit.getUsers(data: {'page': _currentPage}),
          updateUserLoaded:  () => _cubit.getUsers(data: {'page': _currentPage}),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final users     = _cubit.users;
        final total     = _cubit.totalCount;
        final lastPage  = _cubit.lastPage;
        final isLoading = state is GetUsersLoading;

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
                      fontSize: 22.rsp,
                      fontFamily: FontFamily.syne,
                      highlightColor: AppColors.warning,
                    ),
                    SizedBox(height: 8.rh),
                    AppText(
                      total > 0 ? '$total utilisateurs enregistrés' : 'Gestion des accès et des rôles',
                      fontSize: 11.rsp,
                      color: AppColors.textMuted,
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
                  height: 40.rh,
                  fontSize: 12.5.rsp,
                ),
              ],
            ),
            SizedBox(height: 24.rh),
            AppSearchInput(
              onChanged: (value) => _cubit.getUsers(data: {'search': value}),
            ),
            SizedBox(height: 16.rh),
            FilterTabsWidget(
              tabs: const [
                FilterTab(label: 'Tous'),
                FilterTab(label: 'Actifs'),
                FilterTab(label: 'Inactifs'),
              ],
              onTabChanged: (tab) {
                tab.label == 'Tous' ? _cubit.getUsers(data: {'page': _currentPage}) : _cubit.getUsers(data: {'status': tab.label.toLowerCase()});
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


