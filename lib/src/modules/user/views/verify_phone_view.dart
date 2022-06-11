import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/modules/user/viewmodels/verify_phone_viewmodel.dart';
import 'package:petowner/src/modules/user/views/verify_phone_view.form.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:petowner/src/widgets/help_menu.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@FormView(fields: [FormTextField(name: "verification")])
class VerifyPhoneView extends StatelessWidget with $VerifyPhoneView {
  final String phoneNumber;

  VerifyPhoneView({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyPhoneViewModel>.reactive(
      onModelReady: (model) {
        model.initPhoneAuth(phoneNumber);
        listenToFormUpdated(model);
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: () => model.showOtpExitDialog(),
        child: model.isBusy
            ? BusyLoader()
            : Scaffold(
                backgroundColor: kBackgroundColor,
                appBar: AppBar(
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: const AppbarLogo(
                    centerTitle: true,
                    logoImage: kAppIcon,
                  ),
                  actions: const [
                    HelpPopMenuWidget(),
                  ],
                  elevation: 0,
                  backgroundColor: kBackgroundColor,
                ),
                body: ListView(padding: EdgeInsets.all(15.0), children: [
                  verticalSpaceMedium,
                  UIText.heading(
                    AppLocalizations.of(context)!.headingVerify,
                  ),
                  verticalSpaceTiny,
                  UIText.paragraph(
                    AppLocalizations.of(context)!.subheadingVerify +
                        " +91$phoneNumber",
                    size: TxtSize.Small,
                    color: kTextSecondaryLightColor,
                  ),
                  UIInput(
                      placeholder: AppLocalizations.of(context)!.inputCode,
                      leading: Icon(Icons.keyboard),
                      inputType: TextInputType.number,
                      controller: verificationController),
                  Container(
                    alignment: Alignment.centerRight,
                    child: !model.timeOut
                        ? StreamBuilder<int>(
                            stream: model.ticker(30),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return LinearProgressIndicator();
                              return UIText.paragraph(
                                  "Auto-capturing code in 00:${snapshot.data}");
                            })
                        : UIButton.tertiary(
                            AppLocalizations.of(context)!.buttonResendCode,
                            onTap: () => model.resendCode(phoneNumber),
                          ),
                  ),
                ]),
                bottomSheet: model.isBusy
                    ? BusyLoader()
                    : AnimatedContainer(
                        width: double.infinity,
                        height: 110,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30.0),
                        duration: Duration(milliseconds: 500),
                        child: !model.timeOut
                            ? BusyLoader()
                            : UIButton.primary(
                                AppLocalizations.of(context)!.buttonContinue,
                                disabled: model.isButtonDisabled,
                                onTap: () => model.verify()),
                      ),
              ),
      ),
      viewModelBuilder: () => VerifyPhoneViewModel(
          updateTextField: (String text) => verificationController.text = text),
    );
  }
}
