import 'package:petowner/src/modules/onboarding/viewmodels/choose_language_viewmodel.dart';
import 'package:petowner/src/modules/onboarding/widgets/language_tile.dart';
import 'package:petowner/src/services/localization_service.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class ChooseLanguageView extends StatelessWidget {
  const ChooseLanguageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);

    return ViewModelBuilder<ChooseLanguageViewModel>.reactive(
      onModelReady: (model) => model.getLanguages(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: AppbarLogo(),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: [
            verticalSpaceMedium,
            UIText.heading(AppLocalizations.of(context)!.headingWelcome),
            verticalSpaceTiny,
            UIText.paragraph(
              AppLocalizations.of(context)!.subheadingWelcome,
              color: kTextPrimaryLightColor,
            ),
            verticalSpaceMedium,
            Container(
                child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runSpacing: 20.0,
              children: model.languages.map((e) {
                int index = model.languages.indexOf(e);
                return LanguageSelectionGridItem(
                    languageName: e.name,
                    languageText: e.text,
                    isSelected: model.languages[index].isSelected,
                    onSelected: () => {
                          model.selectLanguage(index),
                          provider.setLocale(e.languageId),
                        });
              }).toList(),
            )),
          ],
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Wrap(children: [
                  UIText.paragraph(
                    AppLocalizations.of(context)!.helperPerferredLanguage,
                    size: TxtSize.Small,
                  ),
                  UIText.paragraph(
                    "${model.selectedLanguageFullName}, ",
                    size: TxtSize.Small,
                    fontWeight: FontWeight.bold,
                  ),
                  UIText.paragraph(
                    AppLocalizations.of(context)!.helperChangeLanguage,
                    size: TxtSize.Small,
                  ),
                ]),
              ),
              verticalSpaceRegular,
              UIButton(
                title: AppLocalizations.of(context)!.buttonContinue,
                onTap: () => model.navigateToOnBoarding(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ChooseLanguageViewModel(),
    );
  }
}
