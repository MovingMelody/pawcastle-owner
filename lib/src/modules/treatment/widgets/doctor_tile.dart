import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class DoctorTile extends StatelessWidget {
  final Doctor doctor;
  final bool showFee;
  final VoidCallback? callDoctor;

  const DoctorTile(
      {Key? key, required this.doctor, this.showFee = true, this.callDoctor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: kSurfaceColor,
        elevation: 2,
        child: InkWell(
            onTap: () => callDoctor?.call(),
            child: ListTile(
              leading: Container(
                margin: const EdgeInsets.only(bottom: 2),
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(doctor.image),
                  ),
                ),
              ),
              title: UIText.label(
                doctor.name,
                size: TxtSize.Medium,
                fontWeight: FontWeight.w600,
              ),
              subtitle: UIText.paragraph(
                "${doctor.profile.designation}\n${doctor.profile.languages.join(',')}",
                size: TxtSize.Tiny,
                color: kTextSecondaryLightColor,
              ),
              isThreeLine: true,
            )),
      ),
    );
  }
}

class RatingTile extends StatelessWidget {
  final int? rating;
  const RatingTile({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kCoreColor,
      padding: const EdgeInsets.all(2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star,
            size: 14,
            color: kSurfaceColor,
          ),
          Text(
            " ${rating ?? "3"} ",
            style: const TextStyle(color: kSurfaceColor),
          )
        ],
      ),
    );
  }
}
