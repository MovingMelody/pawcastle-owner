import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/utils/iconpack.dart';
import 'package:petowner/src/widgets/busy_overlay.dart';
import 'package:petowner/src/widgets/appbar_logo.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../viewmodels/create_profile_viewmodel.dart';
import 'package:petowner/src/modules/user/views/create_profile_view.form.dart';

@FormView(fields: [
  FormTextField(name: "name"),
  FormTextField(name: "cityName"),
  FormTextField(name: "placeOrBuildingName"),
  FormTextField(name: "landmark")
])
class CreateProfileView extends StatelessWidget with $CreateProfileView {
  CreateProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateProfileViewModel>.reactive(
      onModelReady: (model) {
        listenToFormUpdated(model);
        model.getFutureAddress();
      },
      builder: (context, model, child) => BusyOverlay(
        isBusy: model.isBusy,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: const [],
            elevation: 0,
            centerTitle: true,
            title: const AppbarLogo(
              centerTitle: true,
              logoImage: kAppIcon,
            ),
            backgroundColor: kBackgroundColor,
            iconTheme: const IconThemeData(color: kTextPrimaryLightColor),
          ),
          body: ListView(
            padding: const EdgeInsets.all(15.0),
            children: [
              UIText.heading(
                AppLocalizations.of(context)!.headingProfile,
              ),
              UIInput(
                  label: AppLocalizations.of(context)!.labelName,
                  placeholder: AppLocalizations.of(context)!.inputName,
                  leading: const Icon(IconPack.person),
                  controller: nameController),
              UIInput(
                  bottomPadding: 4,
                  label: AppLocalizations.of(context)!.labelLandmark,
                  placeholder: AppLocalizations.of(context)!.inputLandmark,
                  leading: const Icon(IconPack.pin),
                  helper: AppLocalizations.of(context)!.helperMedicines,
                  controller: cityNameController),
              verticalSpaceMedium,
              if (model.isAddressWrong)
                Column(
                  children: [
                    TextFormField(
                      controller: placeOrBuildingNameController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "House / Building Name",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide:
                              const BorderSide(color: kCoreColor, width: 1.6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: kOutlineColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                      minLines: 2,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    verticalSpaceSmall,
                    TextFormField(
                      controller: landmarkController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "Landmark",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide:
                              const BorderSide(color: kCoreColor, width: 1.6),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0),
                          borderSide: const BorderSide(
                            color: kOutlineColor,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  isThreeLine: true,
                  title: const UIText.label("Detected Address"),
                  subtitle: UIText(
                    model.detectedAddress,
                  ),
                ),
              verticalSpaceSmall,
            ],
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 50,
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
            child: model.isBusy
                ? BusyLoader(color: kCoreColor)
                : UIButton.primary(
                    AppLocalizations.of(context)!.buttonGetStarted,
                    leadingIcon: Icons.security_outlined,
                    onTap: () => model.createProfile(),
                  ),
          ),
        ),
      ),
      viewModelBuilder: () => CreateProfileViewModel(
          changeStreet: (text) => cityNameController.text = text),
    );
  }
}
