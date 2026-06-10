import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateField extends StatefulWidget {
  final String label;
  final bool required;
  final bool optional;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final void Function(DateTime?)? onChanged;

  const AppDateField({
    super.key,
    required this.label,
    this.required = false,
    this.optional = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.onChanged,
  });

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  String get _displayText {
    if (_selectedDate == null) return '';
    return DateFormat('dd/MM/yyyy').format(_selectedDate!);
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate ?? now,
      firstDate: widget.firstDate ?? DateTime(2000),
      lastDate: widget.lastDate ?? DateTime(2200),
      locale: const Locale('fr'),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: AppColors.white,
            surface: AppColors.white,
            onSurface: AppColors.textHeading,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _LabelRow(
          label: widget.label,
          required: widget.required,
          optional: widget.optional,
        ),
        SizedBox(height: 8.rh),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            constraints: const BoxConstraints(minHeight: 48),
            padding: EdgeInsets.symmetric(horizontal: 15.rw),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.rr),
              border: Border.all(color: AppColors.inputBorder, width: 1.6),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _displayText.isEmpty ? 'jj/mm/aaaa' : _displayText,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14.rsp,
                      fontWeight: FontWeight.w500,
                      color: _displayText.isEmpty
                          ? AppColors.textMuted
                          : AppColors.textHeading,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  size: 18.rsp,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LabelRow extends StatelessWidget {
  final String label;
  final bool required;
  final bool optional;

  const _LabelRow({
    required this.label,
    required this.required,
    required this.optional,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          label,
          type: AppTextType.label,
          fontSize: 14.rsp,
          color: AppColors.primary,
          fontWeight: FontWeight.w400,
        ),
        if (required) ...[
          SizedBox(width: 3.rw),
          Text(
            '*',
            style: TextStyle(
              fontSize: 14.rsp,
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
        if (optional) ...[
          SizedBox(width: 6.rw),
          Text(
            'optionnel',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 11.rsp,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
