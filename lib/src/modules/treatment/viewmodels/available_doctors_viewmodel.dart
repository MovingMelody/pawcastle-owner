import 'dart:async';

import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.router.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/treatment/services/call_service.dart';
import 'package:petowner/src/modules/treatment/services/treatment_service.dart';
import 'package:petowner/src/utils/extensions.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AvailableDoctorsViewModel extends BaseViewModel {
  final _log = getLogger("DoctorHomeViewModel");
  final _treatmentService = locator<TreatmentService>();
  final _navigationService = locator<NavigationService>();
  final _callService = locator<CallService>();

  List<Doctor> _onlineDoctors = [];
  List<Doctor> get availableDoctors => _onlineDoctors;

  StreamSubscription? docSub;
  bool getFreeTreatments = false;
  String selectedSpecies = "";

  Map<String, dynamic> paymentMetadata = {};
  bool get showFilter => selectedSpecies.isEmpty;

  Treatment? paidTreatment;

  setSpecies(String species) {
    _log.i("selected species: $species");
    selectedSpecies = species;
    getFreeTreatments = selectedSpecies.isFarmAnimals;
    notifyListeners();
  }

  void getDoctors() {
    setBusy(true);

    docSub = _treatmentService.getAvailableDoctors().listen((event) {});

    docSub?.onData((data) {
      setBusy(true);
      if (data == null) {
        _log.i("no available doctors found");
        return setBusy(false);
      }

      List<Doctor> updatedDoctorList = data;

      if (updatedDoctorList.length > 0) {
        _onlineDoctors = updatedDoctorList;
      }

      setBusy(false);
    });

    setBusy(false);
  }

  callDoctor(Doctor selectedDoctor) async {
    setBusy(true);

    try {
      var treatment = await _treatmentService.createTreatment(
          selectedDoctor, selectedSpecies);

      // if (treatment != null) {
        if (treatment!.status == TreatmentStatus.open) {
          var call = await _callService.initCall(treatment: treatment);

          await _navigationService.replaceWith(Routes.callerScreen,
              arguments: CallerScreenArguments(voicecall: call));
        // }
      }
    } on FirestoreApiException catch (e) {
      _log.e(e);
      Fluttertoast.showToast(msg: "Something went wrong, please try again");
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    docSub?.cancel();
    super.dispose();
  }
}
