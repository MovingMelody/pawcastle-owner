import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class ToolbarButton extends StatelessWidget {
  final double radius;
  final Icon icon;
  final VoidCallback onTap;
  final Color color;
  final String? label;

  const ToolbarButton(
      {Key? key,
      this.radius = 50.0,
      required this.icon,
      required this.onTap,
      this.label,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          borderRadius: BorderRadius.circular(radius),
          color: color,
          child: InkWell(
            borderRadius: BorderRadius.circular(radius),
            onTap: onTap,
            child: Container(padding: EdgeInsets.all(20.0), child: icon),
          ),
        ),
        if (label != null)
          UIText.paragraph(
            "\n$label",
            color: kTextSecondaryLightColor,
          )
      ],
    );
  }
}
