import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/treatment/services/treatment_service.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TreatmentsViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _firestoreApi = locator<TreatmentService>();
  final _log = getLogger("TreatmentsViewModel");
  final _navigationService = locator<NavigationService>();

  List<Treatment> _userTreatments = [];
  List<Treatment> get allUserTreatments => _userTreatments;

  Customer get currentUser => _userService.currentUser;

  String get userId => _userService.currentUser.id;

  void getTreatments() async {
    setBusy(true);

    try {
      _userTreatments = await _firestoreApi.fetchTreatments(userId);
      _log.i("Treatements Fetched");
    } on FirestoreApiException catch (e) {
      _log.e(e);
    } finally {
      setBusy(false);
    }
  }

  void shareMedicines(Treatment treatment) {
    if (treatment.medicines.isEmpty) return;

    String mediShare = "";

    treatment.medicines.forEach((element) {
      mediShare += element.name + "  -  " + element.quantity.toString() + "x\n";
    });

    try {
      Share.share(mediShare, subject: "Medicines Prescribed By VetRemedi");
    } catch (e) {
      _log.e(e);
    }
  }

  
}
