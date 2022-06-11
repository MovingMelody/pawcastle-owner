import 'package:petowner/src/utils/snackbar_helper.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/modules/user/views/create_profile_view.form.dart';
import 'package:petowner/src/services/location_service.dart';

class CreateProfileViewModel extends FormViewModel with SnackbarHelper {
  final Function(String text) changeStreet;

  CreateProfileViewModel({
    required this.changeStreet,
  });

  final _log = getLogger("CreateProfileViewModel");
  final _authApi = locator<FirebaseAuthApi>();
  final _userService = locator<UserService>();
  final _locationService = locator<LocationService>();
  final _navigationService = locator<NavigationService>();

  late Address userAddress;

  bool _hasWrongAddress = false;
  bool get isAddressWrong => _hasWrongAddress;

  String _detectedAddress = "Please wait we're detecting your location...";

  String formatDetectedAddress(Address address) {
    return address.street +
        ", " +
        address.city +
        ", " +
        address.state +
        ", " +
        address.zipcode.toString() +
        ".";
  }

  String get detectedAddress => _detectedAddress;

  Future getFutureAddress() async {
    var authUser = _authApi.authUser!;

    setBusy(true);

    var position = await _locationService.getUserPosition();
    var placemark = await _locationService.getCurrentAddress();

    var detectedAddress = Address(
      name: "TestUser",
      phone: authUser.phoneNumber ?? "TestPhone",
      street: placemark.street ?? "",
      city: placemark.locality ?? "",
      district: placemark.subAdministrativeArea ?? "",
      zipcode: int.parse(placemark.postalCode!),
      position: position,
      state: placemark.administrativeArea ?? "",
    );

    changeStreet(detectedAddress.street);
    _detectedAddress = formatDetectedAddress(detectedAddress);
    userAddress = detectedAddress;

    setBusy(false);
  }

  void wrongAddressDetected() {
    _hasWrongAddress = true;
    userAddress = userAddress.copyWith(directions: "", street: "");
    notifyListeners();
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z_ ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Name should contain only characters';
    }
    return "";
  }

  void createProfile() async {
    if (nameValue == null ||
        cityNameValue == null ||
        nameValue!.isEmpty ||
        cityNameValue!.isEmpty) {
      return showError(error: "Please enter the required fields");
    }

    var nameValidationStatus = validateName(nameValue!);
    if (nameValidationStatus != "")
      return showError(error: nameValidationStatus);

    setBusy(true);

    var authUser = _authApi.authUser!;
    userAddress = _hasWrongAddress
        ? userAddress.copyWith(
            name: nameValue!,
            street: placeOrBuildingNameValue,
            directions: landmarkValue)
        : userAddress.copyWith(name: nameValue!, street: cityNameValue);

    var customer = Customer(
        id: authUser.uid,
        name: nameValue!,
        addresses: [userAddress],
        phone: authUser.phoneNumber!);

    try {
      await _userService.createAndSyncUserAccount(customer: customer);
      navigateToHome();
      setBusy(false);
    } on FirestoreApiException catch (e) {
      _log.e(e);
      setBusy(false);
    }
  }

  void navigateToHome() async {
    // TODO: notify user that account has been created successfully
    _navigationService.replaceWith(Routes.mainView);
  }

  @override
  void setFormStatus() {}
}
