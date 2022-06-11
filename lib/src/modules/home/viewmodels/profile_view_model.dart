import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/utils/dialog_helper.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:package_info/package_info.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileViewModel extends BaseViewModel with DialogHelper {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _packageService = locator<PackageInfo>();

  String get appVersion => _packageService.version;

  void launchWhatsApp() {
    launch("https://wa.me/${kSupportPhone}/?text=${Uri.parse("message")}");
  }

  Customer get currentUser => _userService.currentUser;
}
