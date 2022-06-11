import 'dart:io';

import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

mixin DialogHelper {
  final _dialogService = locator<DialogService>();

  Future<bool> showExitDialog() async {
    var response = await _dialogService.showConfirmationDialog(
        title: kConfirmExitTitle,
        description: kConfirmExitMessage,
        cancelTitle: "No",
        confirmationTitle: "Yes");

    if (response != null && response.confirmed) {
      exit(0);
    }

    return false;
  }

  Future<bool> showOtpExitDialog({String title = kConfirmOTPExitTitle}) async {
    var response = await _dialogService.showConfirmationDialog(
        description: title, cancelTitle: "No", confirmationTitle: "Yes");

    return response != null && response.confirmed;
  }

  Future<bool> showCallExit({VoidCallback? exitCall}) async {
    var response = await _dialogService.showConfirmationDialog(
        title: kCallExitTitle,
        description: kCallExitMessage,
        cancelTitle: "No",
        confirmationTitle: "Yes");

    if (response != null && response.confirmed) {
      exitCall?.call();
      return true;
    }

    return false;
  }
}
