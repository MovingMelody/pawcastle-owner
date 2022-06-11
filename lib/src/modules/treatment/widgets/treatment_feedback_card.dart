import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class TreatmentFeedbackCard extends StatelessWidget {
  final VoidCallback? onRatingPressed;
  const TreatmentFeedbackCard({Key? key, this.onRatingPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSurfaceColor,
          border: Border.all(color: kOutlineColor),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(14.0),
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText.label("FEEDBACK",
              size: TxtSize.Tiny, color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          UIText.paragraph("How was your pet treatment ?", size: TxtSize.Small),
          verticalSpaceSmall,
          UIText.paragraph("Your can share your experience as feedback here.",
              size: TxtSize.Small, color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          TextButton.icon(
              style: TextButton.styleFrom(primary: kInfoColor),
              onPressed: () => onRatingPressed?.call(),
              icon: Icon(
                Icons.star_border_outlined,
              ),
              label: Text(
                "Give Feedback",
              )),
        ],
      ),
    );
  }
}
