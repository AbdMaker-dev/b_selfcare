import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:flutter/material.dart';

class AppSearchInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;

  const AppSearchInput({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 13.rsp,
        fontWeight: FontWeight.w400,
        color: AppColors.textHeading,
      ),
      decoration: InputDecoration(
        hintText: hintText ?? 'Rechercher...',
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 13.rsp,
          color: AppColors.textMuted,
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 16.rsp,
          color: AppColors.textMuted,
        ),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 11.rh),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rr),
          borderSide: BorderSide(color: AppColors.inputBorder, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.rr),
          borderSide: BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
    );
  }
}
