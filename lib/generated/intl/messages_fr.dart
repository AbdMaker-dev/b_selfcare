// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'fr';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "appName": MessageLookupByLibrary.simpleMessage("B-Selfcare"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Une erreur est survenue",
    ),
    "featureUnderDevelopment": MessageLookupByLibrary.simpleMessage(
      "Fonctionnalité en développement",
    ),
    "loading": MessageLookupByLibrary.simpleMessage("Chargement..."),
    "login": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "loginContinue": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour continuer",
    ),
    "otpSentTo": MessageLookupByLibrary.simpleMessage(
      "Veuillez saisir le code envoyé au",
    ),
    "phoneNumber": MessageLookupByLibrary.simpleMessage("Numéro de téléphone"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Renvoyer le code"),
    "verification": MessageLookupByLibrary.simpleMessage("Vérification"),
    "verify": MessageLookupByLibrary.simpleMessage("Vérifier"),
    "welcome": MessageLookupByLibrary.simpleMessage("Bienvenue"),
  };
}
