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

  /// `E-mail`
  String get email {
    return Intl.message('E-mail', name: 'email', desc: '', args: []);
  }

  /// `Se connecter`
  String get login {
    return Intl.message('Se connecter', name: 'login', desc: '', args: []);
  }

  /// `Changer le Mot de passe`
  String get resetPwd {
    return Intl.message(
      'Changer le Mot de passe',
      name: 'resetPwd',
      desc: '',
      args: [],
    );
  }

  /// `Changement de votre`
  String get titlereset {
    return Intl.message(
      'Changement de votre',
      name: 'titlereset',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get pwd {
    return Intl.message('Mot de passe', name: 'pwd', desc: '', args: []);
  }

  /// `Mot de passe`
  String get newPwd {
    return Intl.message('Mot de passe', name: 'newPwd', desc: '', args: []);
  }

  /// `Nouveau mot de passe`
  String get newPassword {
    return Intl.message(
      'Nouveau mot de passe',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer le mot de passe`
  String get confirmPassword {
    return Intl.message(
      'Confirmer le mot de passe',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirmer`
  String get confirm {
    return Intl.message('Confirmer', name: 'confirm', desc: '', args: []);
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

  /// `Connexion à votre \nespace`
  String get loginTitle {
    return Intl.message(
      'Connexion à votre \nespace',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `espace`
  String get loginTitleHighlight {
    return Intl.message(
      'espace',
      name: 'loginTitleHighlight',
      desc: '',
      args: [],
    );
  }

  /// `Mot de passe`
  String get password {
    return Intl.message('Mot de passe', name: 'password', desc: '', args: []);
  }

  /// `Mot de passe oublié`
  String get forgotPassword {
    return Intl.message(
      'Mot de passe oublié',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Rester connecté`
  String get stayConnected {
    return Intl.message(
      'Rester connecté',
      name: 'stayConnected',
      desc: '',
      args: [],
    );
  }

  /// `OU`
  String get or {
    return Intl.message('OU', name: 'or', desc: '', args: []);
  }

  /// `Connexion SSO Entreprise`
  String get ssoLogin {
    return Intl.message(
      'Connexion SSO Entreprise',
      name: 'ssoLogin',
      desc: '',
      args: [],
    );
  }

  /// `Besoin d'aide ?`
  String get needHelp {
    return Intl.message(
      'Besoin d\'aide ?',
      name: 'needHelp',
      desc: '',
      args: [],
    );
  }

  /// `Contactez le support YAS`
  String get contactSupport {
    return Intl.message(
      'Contactez le support YAS',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Votre santé, notre priorité`
  String get appTagline {
    return Intl.message(
      'Votre santé, notre priorité',
      name: 'appTagline',
      desc: '',
      args: [],
    );
  }

  /// `Identifiants`
  String get stepCredentials {
    return Intl.message(
      'Identifiants',
      name: 'stepCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Accès`
  String get stepAccess {
    return Intl.message('Accès', name: 'stepAccess', desc: '', args: []);
  }

  /// `Vérification OTP`
  String get otpTitle {
    return Intl.message(
      'Vérification OTP',
      name: 'otpTitle',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otpTitleHighlight {
    return Intl.message('OTP', name: 'otpTitleHighlight', desc: '', args: []);
  }

  /// `Saisissez le code à 6 chiffres envoyé à l'adresse e-mail enregistrée`
  String get otpSubtitle {
    return Intl.message(
      'Saisissez le code à 6 chiffres envoyé à l\'adresse e-mail enregistrée',
      name: 'otpSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Vous n'avez pas reçu le code ?`
  String get otpNotReceived {
    return Intl.message(
      'Vous n\'avez pas reçu le code ?',
      name: 'otpNotReceived',
      desc: '',
      args: [],
    );
  }

  /// `Renvoyer`
  String get resend {
    return Intl.message('Renvoyer', name: 'resend', desc: '', args: []);
  }

  /// `Vérifier le code`
  String get verifyCode {
    return Intl.message(
      'Vérifier le code',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `← Retour à la connexion`
  String get backToLogin {
    return Intl.message(
      '← Retour à la connexion',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Votre entreprise,\nVotre flotte,\nVotre contrôle.`
  String get authPanelTitle {
    return Intl.message(
      'Votre entreprise,\nVotre flotte,\nVotre contrôle.',
      name: 'authPanelTitle',
      desc: '',
      args: [],
    );
  }

  /// `flotte`
  String get authPanelTitleHighlight {
    return Intl.message(
      'flotte',
      name: 'authPanelTitleHighlight',
      desc: '',
      args: [],
    );
  }

  /// `Gérez vos lignes mobiles, programmez vos dotations et\nsuivez vos dépenses directement depuis votre espace.`
  String get authPanelSubtitle {
    return Intl.message(
      'Gérez vos lignes mobiles, programmez vos dotations et\nsuivez vos dépenses directement depuis votre espace.',
      name: 'authPanelSubtitle',
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
