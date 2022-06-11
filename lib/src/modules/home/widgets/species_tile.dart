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
          height: MediaQuery.of(context).size.height / 7,
          margin: EdgeInsets.only(bottom: 4),
          child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 2,
              child: FadeInImage.assetNetwork(
                placeholder: animalPlaceHolder,
                image: species.image,
                fit: BoxFit.cover,
              )),
        ),
        UIText.paragraph(
          getAnimalName(context, species.name).toUpperCase(),
          size: TxtSize.Tiny,
        )
      ],
    );
  }
}
