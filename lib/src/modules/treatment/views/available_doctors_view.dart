import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/modules/treatment/data/animals.dart';
import 'package:petowner/src/modules/treatment/viewmodels/available_doctors_viewmodel.dart';
import 'package:petowner/src/modules/treatment/widgets/doctor_tile.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@LazySingleton()
class AvailableDoctorsView extends StatelessWidget {
  final String userSelectedSpeciesType;
  const AvailableDoctorsView({Key? key, required this.userSelectedSpeciesType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AvailableDoctorsViewModel>.reactive(
      viewModelBuilder: () => AvailableDoctorsViewModel(),
      onModelReady: (model) {
        model.setSpecies(userSelectedSpeciesType);
        model.getDoctors();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kBackgroundColor,
          title: UIText.heading(
            AppLocalizations.of(context)!.headingAvailableDoctors,
            size: TxtSize.Tiny,
          ),
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : model.availableDoctors.isEmpty
                ? const Center(
                    child: UIText.paragraph("No Doctors found"),
                  )
                : ListView(children: [
                    ...model.availableDoctors
                        .map((doctor) => DoctorTile(
                              doctor: doctor,
                              showFee: !model.getFreeTreatments,
                              callDoctor: () => model.callDoctor(doctor),
                            ))
                        .toList(),
                  ]),
      ),
    );
  }

  Widget getLanguageWidget(String lan) {
    return Container(
      width: 36.0,
      height: 36.0,
      child: Center(
        child: UIText.paragraph(
          lan.toString(),
          size: TxtSize.Small,
          color: kTextPrimaryLightColor,
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: kOutlineColor,
        ),
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
}

