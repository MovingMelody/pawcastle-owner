import 'package:avatar_glow/avatar_glow.dart';
import 'package:petowner/src/widgets/pin_clipper.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class BusyOverlay extends StatelessWidget {
  final bool isBusy;
  final Widget child;

  const BusyOverlay({Key? key, this.isBusy = false, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          child,
          if (isBusy)
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // CircularProgressIndicator(),

                  Column(
                    children: [
                      AvatarGlow(
                        endRadius: 80.0,
                        glowColor: Color(0xaa356EAC),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 56.0),
                          child: SizedBox(
                            height: 70,
                            width: 60,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                SizedBox(
                                  height: 70,
                                  width: 60,
                                  child: ClipPath(
                                    clipper: PinClipper(),
                                    child: Container(color: Color(0xff356EAC)),
                                  ),
                                ),
                                Center(
                                  child: SizedBox(
                                    height: 60,
                                    width: 50,
                                    child: ClipPath(
                                      clipper: PinClipper(),
                                      child: Image.asset(
                                        "assets/images/2.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      // UIText.paragraph(
                      //   "Fetching Current Location",
                      //   color: kTextPrimaryLightColor,
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
