import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDisableEmploye extends StatelessWidget {
  final EmployeeModel employee;
  final MyFlotteCubit myFlotteCubit;

  const ConfirmDisableEmploye({
    super.key,
    required this.employee,
    required this.myFlotteCubit,
  });

  static void show(
    BuildContext context, {
    required EmployeeModel employee,
    required MyFlotteCubit myFlotteCubit,
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
          child: ConfirmDisableEmploye(
            employee: employee,
            myFlotteCubit: myFlotteCubit,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName =
        '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();

    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          disableEmployeeLoaded: (_) =>
              Navigator.of(context, rootNavigator: true).pop(),
          disableEmployeeFailed: (message) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(message), backgroundColor: AppColors.error),
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
                  child: Icon(Icons.block_outlined,
                      color: AppColors.error, size: 22.rsp),
                ),
                SizedBox(width: 12.rw),
                AppText(
                  'Désactiver l\'employé',
                  fontSize: 18.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 20.rh),
            AppText(
              'Êtes-vous sûr de vouloir désactiver',
              fontSize: 16.rsp,
              color: AppColors.textHeading,
            ),
            SizedBox(height: 4.rh),
            AppText(
              '"${fullName.isNotEmpty ? fullName : employee.email ?? ''}"',
              fontSize: 16.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            SizedBox(height: 8.rh),
            AppText(
              'L\'employé ne pourra plus bénéficier de certains services.',
              fontSize: 16.rsp,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 28.rh),
            BlocBuilder<MyFlotteCubit, MyFlotteState>(
              bloc: myFlotteCubit,
              builder: (context, state) {
                final isLoading = state is DisableEmployeeLoading;
                return Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Annuler',
                        type: AppButtonType.outline,
                        fontSize: 18.rsp,
                        onPressed: isLoading
                            ? null
                            : () => Navigator.of(context, rootNavigator: true)
                                .pop(),
                      ),
                    ),
                    SizedBox(width: 12.rw),
                    Expanded(
                      child: AppButton(
                        text: isLoading ? 'Désactivation...' : 'Désactiver',
                        type: AppButtonType.secondary,
                        fontSize: 18.rsp,
                        onPressed: isLoading
                            ? null
                            : () =>
                                myFlotteCubit.disableEmployee(id: employee.id!),
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
