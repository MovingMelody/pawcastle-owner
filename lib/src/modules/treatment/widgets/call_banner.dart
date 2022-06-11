import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class CallBanner extends StatelessWidget {
  final VoidCallback? onTap;
  const CallBanner({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSuccessColor,
      child: InkWell(
        onTap: () => onTap?.call(),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 6.0),
          child: Center(
              child: UIText.paragraph(
            "Doctor still on the call. Join here",
            color: Colors.white,
            size: TxtSize.Tiny,
          )),
        ),
      ),
    );
  }
}
