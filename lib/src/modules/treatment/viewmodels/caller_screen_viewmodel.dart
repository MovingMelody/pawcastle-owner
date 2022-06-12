import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/enums/call_status.dart';

import 'package:petowner/src/modules/treatment/services/call_service.dart';
import 'package:petowner/src/utils/dialog_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:stacked_services/stacked_services.dart';

class CallerScreenViewModel extends BaseViewModel with DialogHelper {
  final _log = getLogger("CallerScreenViewModel");
  final _agoraEngine = locator<RtcEngine>();
  final _callService = locator<CallService>();
  final _navigationService = locator<NavigationService>();

  StreamSubscription? callSub, docSub;

  bool isJoined = false;
  bool isTimeOut = false;
  Voicecall? call;

  bool mute = false;
  bool speaker = false;

  joinChannel(String channelName, String token) async {
    _addListeners();

    await _agoraEngine
        .joinChannel(token, channelName, null, 0)
        .catchError((onError) {
      _log.e('error ${onError.toString()}');
    });
  }

  _addListeners() {
    _agoraEngine.setEventHandler(RtcEngineEventHandler(
      error: (error) {
        _log.e("AgoraCallError: $error");
        // TODO: handle exceptions here
        // _snackBarService.showSnackbar(message: 'Something went wrong');
        // disconnect(error: true);
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        _log.v(
            'joinChannelSuccess $channel $uid $elapsed send farmer notification');
        isJoined = true;
        notifyListeners();
      },
      leaveChannel: (stats) {
        _log.v('leaveChannel ${stats.toJson()}');
        isJoined = false;
        notifyListeners();
      },
    ));
  }

  void listenToCallStream(String channelId) {
    _log.i("Subscribing to call $channelId");

    startTimer();

    setBusy(true);

    callSub = _callService.listenToCallUpdates(channelId).listen((event) {});

    callSub?.onData((data) {
      setBusy(true);

      call = data;

      if (call?.status == "connect") {
        _log.i(
            "Joining call ${call?.details.channelId} token: ${call!.details.token}");

        joinChannel(call!.details.channelId, call!.details.token!);
      }

      if (call?.status == "end") disconnect(update: false);

      setBusy(false);
    });

    setBusy(false);
  }

  startTimer() => Timer(Duration(seconds: 60), setTimeOut);

  void toggleMute() async {
    mute = !mute;
    await _agoraEngine.muteLocalAudioStream(mute);
    notifyListeners();
  }

  void setTimeOut() {
    /// if not joined the call after n mins
    /// the user can end the call or call again
    /// TODO: if the doctor is busy, show the status to petowner as doctor is on another call
    if (!isJoined) {
      isTimeOut = true;
      notifyListeners();
    }
  }

  void callAgain() {
    isTimeOut = false;
    startTimer();
    notifyListeners();
  }

  void toggleSpeaker() async {
    if (!isJoined) return;
    speaker = !speaker;
    await _agoraEngine.setEnableSpeakerphone(speaker);
    notifyListeners();
  }

  String get status => _getStatus();

  String _getStatus() {
    if (call == null) return "Please Wait";

    switch (call?.status) {
      case "dial":
        return "Dailing..";

      case "lift":
        return "Connecting..";

      default:
        return "Connected";
    }
  }

  disconnect({bool update = true, bool error = false}) async {
    var end = CallStatus.End;
    var cancel = CallStatus.Cancel;

    if (isJoined) await _agoraEngine.leaveChannel();
    if (update) {
      await call?.reference
          ?.update({'status': isJoined ? end.status : cancel.status});
      callSub?.cancel();
    }

    _navigationService.back();
  }

  cancelCall() async {
    var callStatus = CallStatus.Cancel;
    await call?.reference?.update({'status': callStatus.status});
    _navigationService.back();
  }

  @override
  void dispose() {
    callSub?.cancel();
    docSub?.cancel();
    super.dispose();
  }
}
