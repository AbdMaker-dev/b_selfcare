import 'package:b_selfcare/src/data/models/user_profile_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/users/cubit/users_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeleteUser extends StatelessWidget {
  final UserProfileModel user;
  final UsersCubit usersCubit;

  const ConfirmDeleteUser({
    super.key,
    required this.user,
    required this.usersCubit,
  });

  static void show(
    BuildContext context, {
    required UserProfileModel user,
    required UsersCubit usersCubit,
  }) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.rr),
        ),
        child: SizedBox(
          width: 420.rw,
          child: ConfirmDeleteUser(user: user, usersCubit: usersCubit),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersCubit, UsersState>(
      bloc: usersCubit,
      listener: (context, state) {
        state.maybeWhen(
          disableUserLoaded: () => Navigator.of(context, rootNavigator: true).pop(),
          disableUserFailed: (message) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message), backgroundColor: AppColors.error),
            );
          },
          orElse: () {},
        );
      },
      child: Padding(
        padding: EdgeInsets.all(24.rw),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.rw),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.rr),
                  ),
                  child: Icon(Icons.delete_outline, color: AppColors.error, size: 22.rsp),
                ),
                SizedBox(width: 12.rw),
                AppText(
                  'Supprimer l\'utilisateur',
                  fontSize: 18.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 20.rh),
            AppText(
              'Êtes-vous sûr de vouloir supprimer',
              fontSize: 16.rsp,
              color: AppColors.textHeading,
            ),
            SizedBox(height: 4.rh),
            AppText(
              '"${user.name ?? user.email ?? ''}"',
              fontSize: 16.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            SizedBox(height: 8.rh),
            AppText(
              'Cette action est irréversible.',
              fontSize: 16.rsp,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 28.rh),
            BlocBuilder<UsersCubit, UsersState>(
              bloc: usersCubit,
              builder: (context, state) {
                final isLoading = state is DisableUserLoading;
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Annuler',
                        type: AppButtonType.outline,
                        fontSize: 18.rsp,
                        onPressed: isLoading
                            ? null
                            : () => Navigator.of(context, rootNavigator: true).pop(),
                      ),
                    ),
                    SizedBox(width: 12.rw),
                    Expanded(
                      child: AppButton(
                        text: isLoading ? 'Suppression...' : 'Supprimer',
                        type: AppButtonType.secondary,
                        fontSize: 18.rsp,
                        onPressed: isLoading
                            ? null
                            : () => usersCubit.disableUser(id: user.id!),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
