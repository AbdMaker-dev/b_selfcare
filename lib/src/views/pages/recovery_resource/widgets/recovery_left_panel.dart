import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/my_flotte/cubit/my_flotte_cubit.dart';
import 'package:b_selfcare/src/views/pages/recovery_resource/widgets/recovery_employee_dropdown.dart';
import 'package:b_selfcare/src/views/pages/recovery_resource/widgets/recovery_selected_employee_card.dart';
import 'package:b_selfcare/src/views/widgets/app_button.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecoveryLeftPanel extends StatelessWidget {
  final MyFlotteCubit cubit;
  final EmployeeModel? selectedEmployee;
  final int selectedNumberIndex;
  final List<FleetNumberModel> numbers;
  final void Function(EmployeeModel) onSelectEmployee;
  final void Function(int) onSelectNumber;
  final VoidCallback onClear;
  final VoidCallback? onLaunch;
  final Widget? resourcePanel;

  const RecoveryLeftPanel({
    super.key,
    required this.cubit,
    required this.selectedEmployee,
    required this.selectedNumberIndex,
    required this.numbers,
    required this.onSelectEmployee,
    required this.onSelectNumber,
    required this.onClear,
    required this.onLaunch,
    this.resourcePanel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('EMPLOYÉ / MSISDN',
            fontSize: 11.rsp,
            fontWeight: FontWeight.w700,
            color: AppColors.textMuted),
        SizedBox(height: 8.rh),

        if (selectedEmployee != null)
          RecoverySelectedEmployeeCard(
            employee: selectedEmployee!,
            numbers: numbers,
            selectedNumberIndex: selectedNumberIndex,
            onSelectNumber: onSelectNumber,
            onClear: onClear,
          )
        else
          RecoveryEmployeeDropdown(
            cubit: cubit,
            onSelect: onSelectEmployee,
          ),

        if (resourcePanel != null) ...[
          SizedBox(height: 12.rh),
          resourcePanel!,
        ],

        SizedBox(height: 16.rh),

        // Avertissement
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
          decoration: BoxDecoration(
            color: AppColors.orangePeach,
            borderRadius: BorderRadius.circular(8.rr),
            border: Border.all(color: AppColors.orangeSalmon),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  size: 14.rsp, color: AppColors.orangeFire),
              SizedBox(width: 8.rw),
              Expanded(
                child: AppText(
                  'Opération irréversible  ·  Annulation du Bundle CBS  ·  Ressources → FCFA solde',
                  fontSize: 11.rsp,
                  color: AppColors.orangeBurnt,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 20.rh),

        // Bouton CTA
        BlocBuilder<MyFlotteCubit, MyFlotteState>(
          bloc: cubit,
          buildWhen: (_, s) => s.maybeWhen(
            recoveryConfirmEmployeeLoading: () => true,
            recoveryConfirmEmployeeLoaded: (_) => true,
            recoveryConfirmEmployeeFailed: (_) => true,
            orElse: () => false,
          ),
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              recoveryConfirmEmployeeLoading: () => true,
              orElse: () => false,
            );
            return SizedBox(
              width: double.infinity,
              child: AppButton(
                text: isLoading ? 'Lancement...' : 'Valider le retrait',
                type: AppButtonType.primary,
                color: AppColors.greenDull,
                icon: Icons.refresh_rounded,
                fontSize: 15.rsp,
                onPressed: (onLaunch == null || isLoading) ? null : onLaunch,
              ),
            );
          },
        ),
      ],
    );
  }
}
