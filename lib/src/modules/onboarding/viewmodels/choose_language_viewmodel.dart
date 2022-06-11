import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/modules/onboarding/models/language.dart';
import 'package:petowner/src/services/key_storage_service.dart';
import 'package:petowner/src/config/languages.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChooseLanguageViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _sharedPrefs = locator<KeyStorageService>();
  final _log = getLogger("LanguageSelectionViewModel");

  String selectedLanguage = "en";
  String selectedLanguageFullName = "English";

  List<Language> languages = [];

  void getLanguages() {
    languages = appLanguages
        .map((e) =>
            e.languageId == selectedLanguage ? e.copyWith(isSelected: true) : e)
        .toList();
  }

  void selectLanguage(int index) {
    languages[index] = languages[index].copyWith(isSelected: true);
    _sharedPrefs.save("language", languages[index].languageId);

    for (var i = 0; i < languages.length; i++) {
      if (i != index) languages[i] = languages[i].copyWith(isSelected: false);
      if (languages[i].isSelected) selectedLanguage = languages[i].languageId;
      if (languages[i].isSelected)
        selectedLanguageFullName = languageName(languages[i].name);
    }
    _log.v('Seleted language : ${languages[index].languageId}');
    notifyListeners();
  }

  navigateToOnBoarding() =>
      _navigationService.replaceWith(Routes.onboardingView);

  String languageName(String id) {
    switch (id) {
      case "English":
        return id;
      default:
        return "తెలుగు";
    }
  }
}
