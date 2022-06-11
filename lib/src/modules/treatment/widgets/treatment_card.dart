import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/utils/dynamic_assets.dart';
import 'package:petowner/src/utils/timestamp.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TreatmentCard extends StatelessWidget with DynamicAssets {
  final Treatment treatment;
  final VoidCallback? shareMedicines;
  const TreatmentCard({Key? key, required this.treatment, this.shareMedicines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: kOutlineColor),
          borderRadius: BorderRadius.circular(8)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (treatment.status == TreatmentStatus.awaitingPayment)
          Material(
            color: kWarningColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: SizedBox(
              width: double.infinity,
              child: UIText.paragraph(
                "Pending Payment",
                size: TxtSize.Tiny,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ListTile(
          title: UIText.label("ID : #" + treatment.id, size: TxtSize.Medium),
          subtitle: UIText.paragraph(
            DateConverter.getDate(epochString: treatment.timestamp).date,
            size: TxtSize.Tiny,
            color: kTextSecondaryLightColor,
          ),
          isThreeLine: true,
          trailing: DottedBorder(
            borderType: BorderType.RRect,
            dashPattern: [8.0, 6.0],
            strokeWidth: 1.5,
            strokeCap: StrokeCap.round,
            radius: Radius.circular(50),
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            color: kOutlineColor,
            child: Image.asset(
              getAsset(treatment.patient.species),
              width: 28.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (treatment.medicines.isNotEmpty)
                ...treatment.medicines
                    .map((eachMedicine) => Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: UIText.paragraph(
                                eachMedicine.quantity.toString() + "x",
                                size: TxtSize.Small,
                                color: kTextSecondaryLightColor,
                              ),
                            ),
                            horizontalSpaceSmall,
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: UIText.paragraph(
                                eachMedicine.name,
                                size: TxtSize.Small,
                                color: kTextSecondaryLightColor,
                              ),
                            ),
                          ],
                        ))
                    .toList(),
            ],
          ),
        ),
        Divider(
          color: kOutlineColor,
          thickness: 1.0,
        ),
        ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            leading: TextButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    primary: kTextPrimaryLightColor,
                    splashFactory: NoSplash.splashFactory),
                icon: Container(
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(treatment.doctor.image),
                    ),
                  ),
                ),
                label: UIText("${treatment.doctor.name}")),
            trailing: ButtonBar(
              buttonPadding: EdgeInsets.zero,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    String url =
                        "https://wa.me/${kSupportPhone}/?text=Hello, I need help with treatment with case id: ${treatment.id}";
                    var encoded = Uri.encodeFull(url);
                    launch(encoded);
                  },
                  child: UIText.paragraph(
                    "Need Help?",
                    color: kCoreColor,
                    size: TxtSize.Small,
                  ),
                ),
                if (treatment.medicines.isNotEmpty)
                  IconButton(
                    onPressed: () => shareMedicines?.call(),
                    icon: Icon(
                      Icons.share_outlined,
                      size: 22.0,
                      color: kTextSecondaryLightColor,
                    ),
                  ),
              ],
            )),
      ]),
    );
  }
}
