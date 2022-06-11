import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/utils/snackbar_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:petowner/src/modules/user/views/login_view.form.dart';

class LoginViewModel extends FormViewModel with SnackbarHelper {
  final _navigationService = locator<NavigationService>();

  String errorText = "Please enter valid number";

  void navigateToVerify() {
    if (errorText.isEmpty || !hasPhone) return showError(error: errorText);

    if (hasPhone)
      _navigationService.navigateTo(Routes.verifyPhoneView,
          arguments: VerifyPhoneViewArguments(phoneNumber: phoneValue!));
  }

  @override
  void setFormStatus() => errorText = validatePhoneNo(phoneValue!);

  String validatePhoneNo(String phone) {
    RegExp regex = new RegExp(r"^[0-9]{10}$");
    if (phone.isEmpty) {
      return "Please enter correct details";
    } else if (!regex.hasMatch(phone)) {
      return "Please enter a valid number";
    } else {
      return "";
    }
  }
}
