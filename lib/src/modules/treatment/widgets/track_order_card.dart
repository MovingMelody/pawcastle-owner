import 'package:petowner/src/utils/iconpack.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class TrackMedicineOrderCard extends StatelessWidget {
  final MedicineOrderStatus status;
  final VoidCallback? contactDelivery;

  const TrackMedicineOrderCard(
      {Key? key, this.status = MedicineOrderStatus.paid, this.contactDelivery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: kSurfaceColor,
          border: Border.all(color: kOutlineColor),
          borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.all(14.0),
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIText.label("ORDER",
              size: TxtSize.Tiny, color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          UIText.paragraph(
            status == MedicineOrderStatus.dispatched
                ? "Your order is on the way!"
                : "Your order will be delivered shortly",
            size: TxtSize.Small,
            color: kInfoColor,
          ),
          verticalSpaceSmall,
          UIText.paragraph(
              status == MedicineOrderStatus.dispatched
                  ? "Delivery executive picked up your medicines, will be delivered today."
                  : "A Delivery executive will be assigned to deliver your order",
              size: TxtSize.Small,
              color: kTextSecondaryLightColor),
          verticalSpaceSmall,
          if (status == MedicineOrderStatus.driverAssigned ||
              status == MedicineOrderStatus.dispatched)
            TextButton.icon(
                style: TextButton.styleFrom(primary: kInfoColor),
                onPressed: () => contactDelivery?.call(),
                icon: Icon(
                  IconPack.phone,
                ),
                label: Text(
                  "Contact",
                )),
        ],
      ),
    );
  }
}
