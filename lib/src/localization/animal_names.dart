import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getAnimalName(BuildContext context, String animalCategory) {
  switch (animalCategory) {
    case "farm animals":
      return AppLocalizations.of(context)!.animalCategoryFarmAnimals;
    case "others":
      return AppLocalizations.of(context)!.titleAnimalOthers;
    case "pets":
      return AppLocalizations.of(context)!.animalCategoryPets;
    case "exotic birds/others":
      return AppLocalizations.of(context)!.animalCategoryBirds;
    case "sheep":
      return AppLocalizations.of(context)!.titleAnimalNameSheep;
    case "dogs":
      return AppLocalizations.of(context)!.titleAnimalNameDogs;
    case "cats":
      return AppLocalizations.of(context)!.titleAnimalNameCats;
    case "buffalo":
      return AppLocalizations.of(context)!.titleAnimalNameBuffalo;
    case "cattle":
      return AppLocalizations.of(context)!.titleAnimalNameCattle;
    case "poultry":
      return AppLocalizations.of(context)!.titleAnimalNamePoultry;
    case "birds":
      return AppLocalizations.of(context)!.titleAnimalNameBird;
    case "goat":
      return AppLocalizations.of(context)!.titleAnimalNameGoat;

    default:
      return AppLocalizations.of(context)!.headingProfile;
  }
}
