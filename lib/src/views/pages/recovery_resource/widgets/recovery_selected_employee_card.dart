import 'package:b_selfcare/gen/fonts.gen.dart';
import 'package:b_selfcare/src/data/models/employee/employee_model.dart';
import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class RecoverySelectedEmployeeCard extends StatelessWidget {
  final EmployeeModel employee;
  final List<FleetNumberModel> numbers;
  final int selectedNumberIndex;
  final void Function(int) onSelectNumber;
  final VoidCallback onClear;

  const RecoverySelectedEmployeeCard({
    super.key,
    required this.employee,
    required this.numbers,
    required this.selectedNumberIndex,
    required this.onSelectNumber,
    required this.onClear,
  });

  String get _fullName =>
      '${employee.firstName ?? ''} ${employee.lastName ?? ''}'.trim();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête : nom + bouton fermer
          Row(
            children: [
              Icon(Icons.person_outline_rounded,
                  size: 13.rsp, color: AppColors.primary),
              SizedBox(width: 6.rw),
              Expanded(
                child: AppText(
                  _fullName.isNotEmpty ? _fullName : '---',
                  fontSize: 13.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  fontFamily: FontFamily.syne,
                ),
              ),
              GestureDetector(
                onTap: onClear,
                child:
                    Icon(Icons.close, size: 16.rsp, color: AppColors.grayAsh),
              ),
            ],
          ),

          if (numbers.isNotEmpty) ...[
            SizedBox(height: 10.rh),
            Wrap(
              spacing: 6.rw,
              runSpacing: 6.rh,
              children: List.generate(numbers.length, (i) {
                final n = numbers[i];
                final isSelected = i == selectedNumberIndex;
                return GestureDetector(
                  onTap: () => onSelectNumber(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.rw, vertical: 6.rh),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20.rr),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.primary.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sim_card_outlined,
                          size: 11.rsp,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.primary,
                        ),
                        SizedBox(width: 4.rw),
                        AppText(
                          n.msisdn ?? '---',
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.primary,
                          fontFamily: FontFamily.syne,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}
