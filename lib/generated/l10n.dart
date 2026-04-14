// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `B-Selfcare`
  String get appName {
    return Intl.message('B-Selfcare', name: 'appName', desc: '', args: []);
  }

  /// `Bienvenue`
  String get welcome {
    return Intl.message('Bienvenue', name: 'welcome', desc: '', args: []);
  }

  /// `Connectez-vous pour continuer`
  String get loginContinue {
    return Intl.message(
      'Connectez-vous pour continuer',
      name: 'loginContinue',
      desc: '',
      args: [],
    );
  }

  /// `Numéro de téléphone`
  String get phoneNumber {
    return Intl.message(
      'Numéro de téléphone',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Se connecter`
  String get login {
    return Intl.message('Se connecter', name: 'login', desc: '', args: []);
  }

  /// `Vérification`
  String get verification {
    return Intl.message(
      'Vérification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Veuillez saisir le code envoyé au`
  String get otpSentTo {
    return Intl.message(
      'Veuillez saisir le code envoyé au',
      name: 'otpSentTo',
      desc: '',
      args: [],
    );
  }

  /// `Vérifier`
  String get verify {
    return Intl.message('Vérifier', name: 'verify', desc: '', args: []);
  }

  /// `Renvoyer le code`
  String get resendCode {
    return Intl.message(
      'Renvoyer le code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Chargement...`
  String get loading {
    return Intl.message('Chargement...', name: 'loading', desc: '', args: []);
  }

  /// `Une erreur est survenue`
  String get errorOccurred {
    return Intl.message(
      'Une erreur est survenue',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Fonctionnalité en développement`
  String get featureUnderDevelopment {
    return Intl.message(
      'Fonctionnalité en développement',
      name: 'featureUnderDevelopment',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'fr')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
