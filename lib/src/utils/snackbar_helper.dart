import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/enums/sheet_status.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

const Duration kWaitingTime = Duration(seconds: 2);

mixin SnackbarHelper {
  final _snackbarService = locator<SnackbarService>();

  showSuccess({required String message, VoidCallback? onDone}) async {
    _snackbarService.showCustomSnackBar(
      onTap: () {},
      variant: SnackbarType.success,
      message: message,
      duration: kWaitingTime,
    );

    await Future.delayed(kWaitingTime);

    onDone?.call();
  }

  showError({required String error, VoidCallback? onDone}) async {
    _snackbarService
        .showCustomSnackBar(
            onTap: () {},
            variant: SnackbarType.failure,
            message: error,
            duration: kWaitingTime)!
        .then((_) => {});

    await Future.delayed(kWaitingTime);

    onDone?.call();
  }

  showWarning({required String message, VoidCallback? onDone}) async {
    _snackbarService.showCustomSnackBar(
      onTap: () {},
      variant: SnackbarType.warning,
      message: message,
      duration: kWaitingTime,
    );

    await Future.delayed(kWaitingTime);

    onDone?.call();
  }
}
