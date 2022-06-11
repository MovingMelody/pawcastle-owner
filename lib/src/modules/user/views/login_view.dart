import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/modules/user/viewmodels/login_viewmodel.dart';
import 'package:petowner/src/modules/user/views/login_view.form.dart';
import 'package:petowner/src/utils/iconpack.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:petowner/src/widgets/help_menu.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@FormView(fields: [FormTextField(name: "phone")])
class LoginView extends StatelessWidget with $LoginView {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: const AppbarLogo(
            centerTitle: true,
            logoImage: kAppIcon,
          ),
          actions: [
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(15.0),
          children: [
            verticalSpaceMedium,
            UIText.heading(
              AppLocalizations.of(context)!.headingLogin,
            ),
            verticalSpaceTiny,
            UIText.paragraph(
              AppLocalizations.of(context)!.subheadingLogin,
              size: TxtSize.Small,
              color: kTextSecondaryLightColor,
            ),
            UIInput(
              placeholder: AppLocalizations.of(context)!.inputPhone,
              leading: const Icon(IconPack.phone),
              controller: phoneController,
              inputType: TextInputType.phone,
              appType: AppType.Core,
            ),
          ],
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: kBackgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: UIText.paragraph(
                  AppLocalizations.of(context)!.titleTermsOfUse,
                  size: TxtSize.Small,
                  color: kTextSecondaryLightColor,
                ),
              ),
              verticalSpaceRegular,
              UIButton.primary(
                AppLocalizations.of(context)!.buttonContinue,
                onTap: () => model.navigateToVerify(),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => listenToFormUpdated(model),
    );
  }
}
