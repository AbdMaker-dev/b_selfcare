import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmRemoveNumber extends StatelessWidget {
  final EmployeeModel employee;
  final FleetNumberModel fleetNumber;
  final MyFlotteCubit myFlotteCubit;

  const ConfirmRemoveNumber({
    super.key,
    required this.employee,
    required this.fleetNumber,
    required this.myFlotteCubit,
  });

  static void show(
    BuildContext context, {
    required EmployeeModel employee,
    required FleetNumberModel fleetNumber,
    required MyFlotteCubit myFlotteCubit,
  }) {
    showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierColor: AppColors.primary.withValues(alpha: 0.7),
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.rr)),
        child: SizedBox(
          width: 420.rw,
          child: ConfirmRemoveNumber(
            employee: employee,
            fleetNumber: fleetNumber,
            myFlotteCubit: myFlotteCubit,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullName = '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();

    return BlocListener<MyFlotteCubit, MyFlotteState>(
      bloc: myFlotteCubit,
      listener: (context, state) {
        state.maybeWhen(
          removeNumbersLoaded: (_) => Navigator.of(context, rootNavigator: true).pop(),
          removeNumbersFailed: (message) {
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
                  child: Icon(Icons.sim_card_outlined, color: AppColors.error, size: 22.rsp),
                ),
                SizedBox(width: 12.rw),
                AppText(
                  'Retirer le numéro',
                  fontSize: 18.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 20.rh),
            AppText('Retirer le numéro', fontSize: 16.rsp, color: AppColors.textHeading),
            SizedBox(height: 4.rh),
            AppText(
              '"${fleetNumber.msisdn ?? ''}"',
              fontSize: 16.rsp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
            SizedBox(height: 4.rh),
            AppText(
              'de l\'employé ${fullName.isNotEmpty ? fullName : employee.email ?? ''} ?',
              fontSize: 16.rsp,
              color: AppColors.textHeading,
            ),
            SizedBox(height: 28.rh),
            BlocBuilder<MyFlotteCubit, MyFlotteState>(
              bloc: myFlotteCubit,
              builder: (context, state) {
                final isLoading = state is RemoveNumbersLoading;
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
                        text: isLoading ? 'Retrait...' : 'Retirer',
                        type: AppButtonType.secondary,
                        color: AppColors.error,
                        textColor: AppColors.white,
                        fontSize: 18.rsp,
                        onPressed: isLoading
                            ? null
                            : () => myFlotteCubit.removeNumbersForEmploye(
                                  id: employee.id!,
                                  data: {'fleet_number_ids': [fleetNumber.id]},
                                ),
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
