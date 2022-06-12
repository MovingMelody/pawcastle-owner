import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class MedicinesListCard extends StatelessWidget {
  final MedicineOrder medicineOrder;
  const MedicinesListCard({Key? key, required this.medicineOrder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kSurfaceColor,
          border: Border.all(color: kOutlineColor),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0))),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UIText.label("MEDICINES",
              size: TxtSize.Tiny, color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          Column(
            children: [
              ...medicineOrder.items
                  .map(
                    (eachMedicine) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: UIText.paragraph(
                                eachMedicine.quantity.toString() + "x",
                                size: TxtSize.Small,
                                color: kTextPrimaryLightColor,
                              ),
                            ),
                            horizontalSpaceSmall,
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: UIText.paragraph(
                                eachMedicine.name +
                                    " • " +
                                    eachMedicine.package,
                                size: TxtSize.Small,
                                color: kTextPrimaryLightColor,
                              ),
                            ),
                          ],
                        ),
                        UIText.paragraph(
                          "₹ ${eachMedicine.price}",
                          size: TxtSize.Small,
                          color: kTextPrimaryLightColor,
                        ),
                      ],
                    ),
                  )
                  .toList(),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const UIText.paragraph(
                    "Total",
                    size: TxtSize.Small,
                    color: kTextPrimaryLightColor,
                  ),
                  UIText.label(
                    "₹ ${(int.parse(medicineOrder.payment?.amount ?? "0") / 100)}",
                    size: TxtSize.Small,
                    color: kTextPrimaryLightColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
