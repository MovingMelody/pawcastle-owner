import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class PrescriptionPending extends StatelessWidget {
  const PrescriptionPending({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSurfaceColor,
          border: Border.all(color: kOutlineColor),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText.label("MEDICINES",
              size: TxtSize.Tiny, color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          UIText.paragraph("Prescription is pending",
              size: TxtSize.Small, color: kInfoColor),
          verticalSpaceSmall,
          UIText.paragraph(
              "Doctor is still analyzing your inputs. Your prescription will be generated in a while.",
              size: TxtSize.Small),
        ],
      ),
    );
  }
}
