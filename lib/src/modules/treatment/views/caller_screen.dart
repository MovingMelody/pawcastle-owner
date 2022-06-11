import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:petowner/src/modules/treatment/widgets/toolbar_button.dart';
import 'package:stacked/stacked.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import '../viewmodels/caller_screen_viewmodel.dart';

class CallerScreen extends StatelessWidget {
  final Voicecall voicecall;

  const CallerScreen({Key? key, required this.voicecall}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CallerScreenViewModel>.reactive(
        viewModelBuilder: () => CallerScreenViewModel(),
        onModelReady: (model) =>
            model.listenToCallStream(voicecall.details.channelId),
        builder: (context, model, child) => WillPopScope(
              onWillPop: () =>
                  model.showCallExit(exitCall: () => model.disconnect()),
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  bottom: PreferredSize(
                      preferredSize: Size(double.infinity, 4),
                      child: model.isBusy
                          ? LinearProgressIndicator(
                              color: kCoreColor,
                            )
                          : Container()),
                ),
                body: ListView(
                  children: [
                    verticalSpaceMedium,
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        voicecall.doctor.image,
                      ),
                      radius: 50,
                    ),
                    verticalSpaceMedium,
                    UIText.heading(
                      "${voicecall.doctor.name}",
                      textAlign: TextAlign.center,
                      size: TxtSize.Small,
                    ),
                    if (!model.isTimeOut)
                      UIText(
                        model.status,
                        textAlign: TextAlign.center,
                      )
                  ],
                ),
                bottomNavigationBar: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
                  child: model.isTimeOut
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                              ToolbarButton(
                                  label: "Cancel",
                                  icon: Icon(Icons.close),
                                  onTap: () => model.cancelCall()),
                              ToolbarButton(
                                color: Colors.green,
                                label: "Retry",
                                icon: Icon(
                                  Icons.phone,
                                  color: kTextPrimaryDarkColor,
                                ),
                                onTap: () => model.callAgain(),
                              ),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ToolbarButton(
                                color: model.mute
                                    ? kCoreColor
                                    : Colors.transparent,
                                icon: Icon(
                                  Icons.mic_off,
                                  color: model.mute
                                      ? kTextPrimaryDarkColor
                                      : kTextPrimaryLightColor,
                                ),
                                onTap: () => model.toggleMute()),
                            ToolbarButton(
                                color: kErrorColor,
                                icon: Icon(
                                  Icons.call_end,
                                  color: kTextPrimaryDarkColor,
                                  size: 40,
                                ),
                                onTap: () => model.disconnect()),
                            ToolbarButton(
                                color: model.speaker
                                    ? kCoreColor
                                    : Colors.transparent,
                                icon: Icon(
                                  Icons.volume_up,
                                  color: model.speaker
                                      ? kTextPrimaryDarkColor
                                      : kTextPrimaryLightColor,
                                ),
                                onTap: () => model.toggleSpeaker()),
                          ],
                        ),
                ),
              ),
            ));
  }
}
