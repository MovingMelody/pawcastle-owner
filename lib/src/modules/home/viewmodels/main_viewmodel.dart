import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/utils/dialog_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MainViewModel extends IndexTrackingViewModel with DialogHelper {
  final _navigationService = locator<NavigationService>();

}
