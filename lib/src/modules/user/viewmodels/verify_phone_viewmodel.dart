import 'dart:async';

import 'package:petowner/src/utils/snackbar_helper.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/utils/dialog_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:petowner/src/modules/user/views/verify_phone_view.form.dart';

class VerifyPhoneViewModel extends FormViewModel
    with DialogHelper, SnackbarHelper {
  final Function(String) updateTextField;
  final _firebaseAuthApi = locator<FirebaseAuthApi>();
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _log = getLogger("VerifyPhoneViewModel");

  VerifyPhoneViewModel({required this.updateTextField});

  String? verificationId;
  bool timeOut = kDebugMode;
  bool isButtonDisabled = true;
  StreamSubscription? verifyStream;

  void navigateToEnterMobile() {
    _navigationService.back();
  }

  void initPhoneAuth(String phone) {
    verifyStream = _firebaseAuthApi
        .loginWithPhoneNumber(phone: "+91$phone")
        .listen((event) {});

    verifyStream?.onData((event) {
      AuthResult authResult = event;

      // when firebase auto detects OTP, update the OTP and redirect to home
      if (authResult.hasUser) return _loginSuccess(authResult);

      if (authResult.hasToken) {
        verificationId = authResult.verificationId;
        _log.v(
            "VerificationId to perform manual verification: ${authResult.verificationId}");
      }
    });

    verifyStream?.onError((e) {
      _log.e(e);
      showError(error: "${e?.errorMessage}");
    });

    Timer(const Duration(seconds: 30), () {
      timeOut = true;
      notifyListeners();
    });
  }

  void resendCode(phone) => initPhoneAuth(phone);

  void verify() async {
    if (verificationValue == null) return;

    setBusy(true);

    var authResult = await _firebaseAuthApi.verifyCode(
        verificationId: verificationId!, codeSent: verificationValue!);

    if (authResult.hasUser) return _loginSuccess(authResult);

    setBusy(false);
  }

  _loginSuccess(AuthResult authResult) async {
    _log.v("Auto detected sms code: ${authResult.smsCode}");
    updateTextField(authResult.smsCode!);

    try {
      await _userService.syncUserAccount();
    } catch (e) {
      showError(error: "Something went wrong, please try again");
    }

    /// if user has existing profile, redirect to [home]
    if (_userService.hasProfile) {
      showSuccess(message: "Login Successful");

      return _navigationService.replaceWith(Routes.mainView);
    }

    return _navigationService.replaceWith(Routes.createProfileView);
  }

  Stream<int> ticker(int ticks) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }

  @override
  void setFormStatus() {
    isButtonDisabled =
        verificationValue == null || verificationValue!.length < 6;
  }
}
