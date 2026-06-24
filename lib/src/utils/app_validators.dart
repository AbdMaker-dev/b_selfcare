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

  // ignore: deprecated_member_use
  static final _upperRegex   = RegExp(r'[A-Z]');
  // ignore: deprecated_member_use
  static final _lowerRegex   = RegExp(r'[a-z]');
  // ignore: deprecated_member_use
  static final _digitRegex   = RegExp(r'[0-9]');
  // ignore: deprecated_member_use
  static final _specialRegex = RegExp(r'[!@#%^&*()\-_=+\[\]{};:,.<>?/|\\]');

  static String? Function(String?) loginPassword(BuildContext context) {
    final s = S.of(context);
    return (value) {
      if (value == null || value.isEmpty) return s.validatorPasswordRequired;
      return null;
    };
  }

  static String? Function(String?) password(BuildContext context) {
    final s = S.of(context);
    return (value) {
      if (value == null || value.isEmpty) return s.validatorPasswordRequired;
      if (value.length < 8)                     return s.validatorPasswordTooShort;
      if (!_upperRegex.hasMatch(value))          return 'Le mot de passe doit contenir au moins une majuscule';
      if (!_lowerRegex.hasMatch(value))          return 'Le mot de passe doit contenir au moins une minuscule';
      if (!_digitRegex.hasMatch(value))          return 'Le mot de passe doit contenir au moins un chiffre';
      if (!_specialRegex.hasMatch(value))        return 'Le mot de passe doit contenir au moins un caractère spécial';
      return null;
    };
  }
}
