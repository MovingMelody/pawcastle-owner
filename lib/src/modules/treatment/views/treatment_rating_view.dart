import 'package:petowner/src/modules/treatment/viewmodels/treatment_rating_viewmodel.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:stacked/stacked.dart';

class TreatmentRatingView extends StatelessWidget {
  final String doctorId;
  final String caseId;

  const TreatmentRatingView(
      {Key? key, required this.caseId, required this.doctorId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TreatmentRatingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: kBackgroundColor,
          actions: [
            IconButton(
                onPressed: () => model.navigateToHome(),
                icon: Icon(Icons.close))
          ],
        ),
        backgroundColor: kBackgroundColor,
        body: Container(
          width: double.infinity,
          color: kBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UIText("Rate your experience 😊"),
                  verticalSpaceMedium,
                  Center(
                    child: RatingStars(
                      value: model.getRating,
                      onValueChanged: (v) {
                        model.setRating(v);
                      },
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        size: 24.0,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 28,
                      valueLabelColor: Color(0xff9b9b9b),
                      valueLabelTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                      valueLabelRadius: 10,
                      maxValue: 5,
                      starSpacing: 1,
                      maxValueVisibility: true,
                      valueLabelVisibility: true,
                      animationDuration: Duration(milliseconds: 1000),
                      valueLabelPadding:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      valueLabelMargin: EdgeInsets.only(right: 8),
                      starOffColor: Color(0xffe7e8ea),
                      starColor: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          width: double.infinity,
          color: kBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              UIButton.primary(
                model.isBusy ? "Submitting..." : "Submit",
                disabled: model.getRating == 0.0,
                onTap: () => model.submitTreatmentRating(
                    caseId: caseId, doctorId: doctorId),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => TreatmentRatingViewModel(),
    );
  }
}
