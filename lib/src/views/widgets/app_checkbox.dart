import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final Function(bool) onCheck;
  const AppCheckbox({super.key, required this.text, required this.fontSize, required this.fontWeight, required this.color, required this.onCheck,});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
      return Row(
        spacing: 5.rw, 
        children: [
          Icon(isChecked ?Icons.check_box : Icons.check_box_outline_blank, color: !isChecked ? widget.color : AppColors.primary, size: widget.fontSize+5.rsp,),
          AppText(
            widget.text,
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: !isChecked ? widget.color : AppColors.primary,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            fontFamily: 'Montserrat',
            type: AppTextType.body,
            onClick: () {
              setState(() {
                isChecked = !isChecked;
              });
              widget.onCheck(isChecked);
            },
          ),
        ],
      );
  }
}