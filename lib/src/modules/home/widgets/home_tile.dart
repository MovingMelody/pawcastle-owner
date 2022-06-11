import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String title, subtitle, asset;
  final VoidCallback? onTap;

  const HomeTile({
    Key? key,
    required this.asset,
    required this.subtitle,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        width: double.infinity,
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        decoration: BoxDecoration(
            color: kSurfaceColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4)
            ],
            image: DecorationImage(
                alignment: Alignment.bottomRight, image: AssetImage(asset))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            UIText.label(title),
            const Text(
              "\n",
              style: TextStyle(fontSize: 2),
            ),
            UIText.paragraph(
              subtitle,
              size: TxtSize.Tiny,
              color: kTextSecondaryLightColor,
            ),
          ],
        ),
      ),
    );
  }
}
