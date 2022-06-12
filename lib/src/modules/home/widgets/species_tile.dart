import 'package:lottie/lottie.dart';
import 'package:petowner/src/constants/assets.dart';
import 'package:petowner/src/localization/animal_names.dart';
import 'package:petowner/src/modules/home/models/species_group.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class SpeciesTile extends StatelessWidget {
  final Species species;

  const SpeciesTile({
    Key? key,
    required this.species,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 5,
          margin: const EdgeInsets.only(bottom: 4),
          child: Card(
              color:
                  getAnimalName(context, species.name).toUpperCase() == "DOGS"
                      ? const Color(0xffffffff)
                      : const Color(0xffffffff),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 1,
              child: LottieBuilder.asset(
                getAnimalName(context, species.name).toUpperCase() == "DOGS"
                    ? "assets/images/dogs.json"
                    : "assets/images/cats.json",
              )),
        ),
        UIText.paragraph(
          getAnimalName(context, species.name).toUpperCase(),
          size: TxtSize.Tiny,
        ),
      ],
    );
  }
}
