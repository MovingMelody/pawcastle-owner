import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/constants/strings.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final _log = getLogger("StartUpViewModel");
  final _navigationService = locator<NavigationService>();
  final _snackbarService = locator<SnackbarService>();
  final _userService = locator<UserService>();

  Future<void> runStartupLogic() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_userService.hasLoggedInUser) {
      _log.v('We have a user session on disk. Sync the user profile ...');

      try {
        await _userService.syncUserAccount();
      } on FirestoreApiException catch (e) {
        _log.e(e);

        return _snackbarService.showSnackbar(
            title: kDefaultErrorTitle,
            message: kDefaultErrorMessage,
            mainButtonTitle: "Try again",
            onMainButtonTapped: () => runStartupLogic());
      }

      if (!_userService.hasProfile) {
        _navigationService.replaceWith(Routes.createProfileView);
      } else {
        _log.v('We have a user profile, navigate to the HomeView');
        return _navigationService.replaceWith(Routes.mainView);
      }
    } else {
      _log.v('No user on disk, navigate to the LoginView');
      return _navigationService.replaceWith(Routes.onboardingView);
    }
  }
}
