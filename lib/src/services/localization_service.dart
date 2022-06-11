import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/services/key_storage_service.dart';
import 'package:petowner/src/localization/l10n.dart';
import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  final _log = getLogger("LanguageProvider");
  final _sharedPrefs = locator<KeyStorageService>();

  Locale _locale = L10n.allLocales[1];
  Locale get locale => _locale;

  void setLocale(String code) {
    _log.v('updating locale to $code');
    _sharedPrefs.save("language", code);

    // safety check 🔒
    if (code.isEmpty || !L10n.allLocales.contains(code)) {
      code = _sharedPrefs.get("language");
    }

    var selectedLocale =
        L10n.allLocales.firstWhere((element) => element.languageCode == code);
    _locale = selectedLocale;
    notifyListeners();

    _log.i('locale updated to ${_locale.languageCode}');
  }
}
