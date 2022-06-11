import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/modules/onboarding/viewmodels/onboarding_view_model.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              kOnboardingAsset,
              fit: BoxFit.cover,
              color: Colors.black38,
              colorBlendMode: BlendMode.darken,
            ),
            ListView(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.symmetric(vertical: 60.0, horizontal: 15.0),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    AppbarLogo(
                      title: "PawCastle",
                      titleColor: kSurfaceColor,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UIButton(
                      title: AppLocalizations.of(context)!.buttonContinue,
                      onTap: () => model.navigateToLogin(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}
