import 'package:dotted_border/dotted_border.dart';
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
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 2),
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/0.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  UIText.label(
                    doctor.name,
                    size: TxtSize.Medium,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            children: [
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(50),
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                color: kOutlineColor,
                child: UIText.paragraph(
                  doctor.profile.designation,
                  size: TxtSize.Tiny,
                  color: kTextPrimaryLightColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  buildLangAvatar(
                    "తె",
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  buildLangAvatar(
                    "En",
                  ),
                ],
              ),
              SizedBox(
                  width: 132,
                  child: InkWell(
                    onTap: () => callDoctor?.call(),
                    child: Container(
                      child: const Center(
                          child: Text(
                        "Consult",
                        style: TextStyle(color: Colors.white),
                      )),
                      height: 34.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ))
            ],
          )
        ],
      ),
    );

    // Container(
    //   margin: const EdgeInsets.only(bottom: 8),
    //   padding: const EdgeInsets.symmetric(horizontal: 8),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(8),
    //     color: kSurfaceColor,
    //     elevation: 2,
    //     child: InkWell(
    //         onTap: () => callDoctor?.call(),
    //         child: ListTile(
    //           leading: Container(
    //             margin: const EdgeInsets.only(bottom: 2),
    //             height: 48,
    //             width: 48,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(50.0),
    //               image: DecorationImage(
    //                 fit: BoxFit.cover,
    //                 image: NetworkImage(doctor.image),
    //               ),
    //             ),
    //           ),
    //           title: UIText.label(
    //             doctor.name,
    //             size: TxtSize.Medium,
    //             fontWeight: FontWeight.w600,
    //           ),
    //           subtitle: UIText.paragraph(
    //             "${doctor.profile.designation}\n${doctor.profile.languages.join(',')}",
    //             size: TxtSize.Tiny,
    //             color: kTextSecondaryLightColor,
    //           ),
    //           isThreeLine: true,
    //         )),
    //   ),
    // );
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

Widget buildLangAvatar(String lan) {
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
