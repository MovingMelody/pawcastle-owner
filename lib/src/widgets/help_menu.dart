import 'package:petowner/src/constants/keys.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPopMenuWidget extends StatelessWidget {
  const HelpPopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      elevation: 2.0,
      icon: Icon(
        Icons.keyboard_control_rounded,
        color: kTextPrimaryLightColor,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
              onTap: () {
                launch(
                    "https://wa.me/${kSupportPhone}/?text=${Uri.parse("message")}");
              },
              child: Text("Help & Support")),
          value: 1,
        ),
      ],
    );
  }
}
