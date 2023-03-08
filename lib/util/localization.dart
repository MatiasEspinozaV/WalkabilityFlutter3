import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WalkLocalizations {
  final Locale locale;

  WalkLocalizations(this.locale);

  static WalkLocalizations of(BuildContext context) {
    return Localizations.of<WalkLocalizations>(context, WalkLocalizations);
  }

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }

  static const LocalizationsDelegate<WalkLocalizations> delegate =
      _WalkLocalizationsDelegate();
}

class _WalkLocalizationsDelegate
    extends LocalizationsDelegate<WalkLocalizations> {
  const _WalkLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de', 'es'].contains(locale.languageCode);
  }

  @override
  Future<WalkLocalizations> load(Locale locale) async {
    WalkLocalizations localizations = new WalkLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_WalkLocalizationsDelegate old) => false;
}
