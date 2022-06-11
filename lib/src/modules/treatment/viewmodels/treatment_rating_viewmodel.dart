import 'package:petowner/src/modules/treatment/models/treatment_rating.dart';
import 'package:petowner/src/modules/treatment/services/rating_service.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/utils/timestamp.dart';
import 'package:petowner/src/utils/toast_helper.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TreatmentRatingViewModel extends BaseViewModel with ToastHelper {
  final _authApi = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _treatmentRatingService = locator<TreatmentRatingService>();
  final _log = getLogger("RatingScreenViewModel");

  late double _userRating = 0.0;
  double get getRating => _userRating;

  void setRating(double rating) {
    _userRating = rating;
    _log.v(_userRating);
    notifyListeners();
  }

  void submitTreatmentRating(
      {required String caseId, required String doctorId}) async {
    setBusy(true);
    var authUser = _authApi.currentUser;

    var rating = TreatmentRating(
        rating: _userRating,
        caseId: caseId,
        patientId: authUser.id,
        doctorId: doctorId,
        timestamp: DateTime.now().timestamp);

    try {
      await _treatmentRatingService.addRating(rating: rating);
      setBusy(false);
      navigateToHome();
      showToast("Thank you for rating.");
    } on FirestoreApiException catch (e) {
      _log.e(e);
    }
  }

  void navigateToHome() {
    _navigationService.clearStackAndShow(Routes.mainView);
  }
}
