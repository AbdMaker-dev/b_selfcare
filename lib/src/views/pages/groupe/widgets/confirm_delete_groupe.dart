import 'package:b_selfcare/src/data/models/group/group_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/group/group_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeleteGroupe extends StatelessWidget {
  final GroupModel groupe;
  final GroupCubit groupCubit;

  const ConfirmDeleteGroupe({
    super.key,
    required this.groupe,
    required this.groupCubit,
  });

  static void show(
    BuildContext context, {
    required GroupModel groupe,
    required GroupCubit groupCubit,
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
          child: ConfirmDeleteGroupe(
            groupe: groupe,
            groupCubit: groupCubit,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupCubit, GroupState>(
      bloc: groupCubit,
      listener: (context, state) {
        state.maybeWhen(
          deleteGroupeLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          deleteGroupeFailed: (message) {
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
                  'Supprimer le groupe',
                  fontSize: 18.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 20.rh),
            AppText(
              'Êtes-vous sûr de vouloir supprimer le groupe',
              fontSize: 16.rsp,
              color: AppColors.textHeading,
            ),
            SizedBox(height: 4.rh),
            AppText(
              '"${groupe.name ?? ''}"',
              fontSize: 16.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            SizedBox(height: 8.rh),
            AppText(
              'Cette action est irréversible. Les employés du groupe ne seront pas supprimés.',
              fontSize: 16.rsp,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 28.rh),
            BlocBuilder<GroupCubit, GroupState>(
              bloc: groupCubit,
              builder: (context, state) {
                final isLoading = state is DeleteGroupeLoading;
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
                            : () => groupCubit.deleteGroupe(id: groupe.id!),
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
