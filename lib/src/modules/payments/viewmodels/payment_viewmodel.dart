import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/services/env_service.dart';
import 'package:petowner/src/utils/snackbar_helper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:stacked/stacked.dart';

abstract class BasePaymentViewModel extends BaseViewModel with SnackbarHelper {
  final _log = getLogger("BasePaymentViewModel");
  final _razorPayInstance = locator<Razorpay>();
  final _envService = locator<EnvironmentService>();
  final userService = locator<UserService>();

  initialiseListeners() {
    _log.i('Setting up listeners');
    _razorPayInstance.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorPayInstance.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
  }

  startPayment() {
    try {
      initialiseListeners();
      _razorPayInstance.open(_getPaymentOptions());
    } catch (error) {
      showError(error: 'Failed to initiate payment');
      _log.e(error);
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    _log.i("payment success for ${response.orderId}");
  }

  void handlePaymentFailure(PaymentFailureResponse response) {
    _log.e("payment failed: ${response.code} ${response.message}");
  }

  /// stores `name`, `amount`, `orderId` and `description`
  Map<String, dynamic> getPaymentMetadata();

  Map<String, dynamic> _getPaymentOptions() {
    _log.i("Generating payment metadata for razorpay");
    var kRazorpayKey = _envService.getValue(kRazorpayId);
    var paymentData = getPaymentMetadata();

    var paymentOptions = {
      'key': kRazorpayKey,
      'timeout': 120,
      'prefill': {'contact': userService.currentUser.phone},
      ...paymentData
    };

    return paymentOptions;
  }
}
