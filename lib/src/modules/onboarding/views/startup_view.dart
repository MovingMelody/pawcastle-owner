import 'package:lottie/lottie.dart';
import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/modules/onboarding/viewmodels/startup_viewmodel.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
      onModelReady: (model) =>
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        model.runStartupLogic();
      }),
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: LottieBuilder.asset(
                "assets/images/welcomecat.json",
                height: 220.0,
              ),
            ),
          ],
        ),
        bottomNavigationBar: const AppbarLogo(
          logoImage: kAppIcon,
        ),
      ),
      viewModelBuilder: () => StartUpViewModel(),
    );
  }
}
