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
    final msisdn = numbers.isNotEmpty
        ? numbers[selectedNumberIndex].msisdn ?? '---'
        : '---';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.rr),
        border: Border.all(color: AppColors.gray),
      ),
      child: Row(
        children: [
          // Numéro · Nom
          Expanded(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: msisdn,
                    style: TextStyle(
                      fontFamily: FontFamily.syne,
                      fontSize: 13.rsp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  if (_fullName.isNotEmpty)
                    TextSpan(
                      text: '  ·  $_fullName',
                      style: TextStyle(
                        fontSize: 13.rsp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                        fontFamily: FontFamily.syne,
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Navigation entre numéros si plusieurs
          if (numbers.length > 1) ...[
            SizedBox(width: 8.rw),
            GestureDetector(
              onTap: selectedNumberIndex > 0
                  ? () => onSelectNumber(selectedNumberIndex - 1)
                  : null,
              child: Icon(
                Icons.chevron_left,
                size: 18.rsp,
                color: selectedNumberIndex > 0
                    ? AppColors.textMuted
                    : AppColors.gray,
              ),
            ),
            AppText(
              '${selectedNumberIndex + 1}/${numbers.length}',
              fontSize: 11.rsp,
              color: AppColors.textMuted,
            ),
            GestureDetector(
              onTap: selectedNumberIndex < numbers.length - 1
                  ? () => onSelectNumber(selectedNumberIndex + 1)
                  : null,
              child: Icon(
                Icons.chevron_right,
                size: 18.rsp,
                color: selectedNumberIndex < numbers.length - 1
                    ? AppColors.textMuted
                    : AppColors.gray,
              ),
            ),
          ],

          SizedBox(width: 8.rw),
          GestureDetector(
            onTap: onClear,
            child: Icon(Icons.close, size: 16.rsp, color: AppColors.grayAsh),
          ),
        ],
      ),
    );
  }
}
