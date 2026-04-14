import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';

enum StepStatus { completed, active, inactive }

class AppStepIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const AppStepIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  StepStatus _statusOf(int index) {
    if (index < currentStep) return StepStatus.completed;
    if (index == currentStep) return StepStatus.active;
    return StepStatus.inactive;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isOdd) {
          final leftStepIndex = i ~/ 2;
          final leftStatus = _statusOf(leftStepIndex);
          return _ConnectorLine(completed: leftStatus == StepStatus.completed);
        }

        final index = i ~/ 2;
        final status = _statusOf(index);
        return _StepItem(
          label: steps[index],
          stepNumber: index + 1,
          status: status,
        );
      }),
    );
  }
}

class _StepItem extends StatelessWidget {
  final String label;
  final int stepNumber;
  final StepStatus status;

  const _StepItem({
    required this.label,
    required this.stepNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepCircle(stepNumber: stepNumber, status: status),
        SizedBox(height: 8.rh),
        Text(
          label,
          style: TextStyle(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w500,
            color: _labelColor(context),
          ),
        ),
      ],
    );
  }

  Color _labelColor(BuildContext context) {
    switch (status) {
      case StepStatus.completed:
        return AppColors.success;
      case StepStatus.active:
        return AppColors.primary;
      case StepStatus.inactive:
        return AppColors.textMuted;
    }
  }
}

class _StepCircle extends StatelessWidget {
  final int stepNumber;
  final StepStatus status;

  const _StepCircle({
    required this.stepNumber,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StepStatus.completed:
        return Container(
          width: 48.rw,
          height: 48.rh,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.success.withValues(alpha: 0.2),
            border: Border.all(color: AppColors.success, width: 1.5.rw),
          ),
          child: Icon(
            Icons.check_rounded,
            color: AppColors.success,
            size: 22.rsp,
          ),
        );

      case StepStatus.active:
        return Container(
          width: 48.rw,
          height: 48.rh,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2D4270),
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.rsp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        );

      case StepStatus.inactive:
        return Container(
          width: 48.rw,
          height: 48.rh,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFFCDD0DC), width: 1.5.rw),
          ),
          child: Center(
            child: Text(
              '$stepNumber',
              style: TextStyle(
                color: Color(0xFFABAFBF),
                fontSize: 18.rsp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
    }
  }
}

class _ConnectorLine extends StatelessWidget {
  final bool completed;

  const _ConnectorLine({required this.completed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 48,
      child: Center(
        child: Container(
          height: 1.5,
          color: completed ? AppColors.success : const Color(0xFFCDD0DC),
        ),
      ),
    );
  }
}