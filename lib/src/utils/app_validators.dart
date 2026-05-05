import 'package:b_selfcare/generated/l10n.dart';
import 'package:flutter/material.dart';

class AppValidators {
  AppValidators._();

  // ignore: deprecated_member_use
  static final _emailRegex = RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');

  static String? Function(String?) email(BuildContext context) {
    final s = S.of(context);
    return (value) {
      if (value == null || value.trim().isEmpty) return s.validatorEmailRequired;
      if (!_emailRegex.hasMatch(value.trim())) return s.validatorEmailInvalid;
      return null;
    };
  }

  static String? Function(String?) password(BuildContext context) {
    final s = S.of(context);
    return (value) {
      if (value == null || value.isEmpty) return s.validatorPasswordRequired;
      if (value.length < 8) return s.validatorPasswordTooShort;
      return null;
    };
  }
}
