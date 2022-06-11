import 'dart:async';
import 'dart:math';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/utils/extensions.dart';
import 'package:petowner/src/utils/timestamp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';

class TreatmentService {
  final _userService = locator<UserService>();
  final _log = getLogger("TreatmentService");

  final _treatmentsRef = FirebaseFirestore.instance
      .collection(kTreatmentsFirestoreKey)
      .withConverter<Treatment>(
        fromFirestore: (snapshot, _) => Treatment.fromSnapshot(snapshot),
        toFirestore: (treatment, _) => treatment.toMap(),
      );

  final _doctorsRef = FirebaseFirestore.instance
      .collection(kDoctorsFirestoreKey)
      .withConverter<Doctor>(
        fromFirestore: (snapshot, _) => Doctor.fromSnapshot(snapshot),
        toFirestore: (doctor, _) => doctor.toMap(),
      );

  final StreamController<List<Doctor>> _doctorsController =
      StreamController<List<Doctor>>.broadcast();

  final StreamController<Treatment> _treatmentDetailsStream =
      StreamController<Treatment>.broadcast();

  Stream getAvailableDoctors() {
    _requestDoctorsList();
    return _doctorsController.stream;
  }

  void _requestDoctorsList() {
    _doctorsRef
        .where("online", isEqualTo: true)
        .where("verified", isEqualTo: VerificationStatus.approved.value)
        .snapshots()
        .listen((postsSnapshot) {
      if (postsSnapshot.docs.length == 0) {
        print("No doctors found rn");
      } else if (postsSnapshot.docs.isNotEmpty) {
        var posts =
            postsSnapshot.docs.map((snapshot) => snapshot.data()).toList();

        _doctorsController.add(posts);
      }
    });
  }

  /// creates a new treatment with auto generated [caseId]
  Future<Treatment?> createTreatment(
      Doctor doctor, String selectedSpecies) async {
    bool isFreeTreatment = selectedSpecies.isFarmAnimals;

    var patient = TreatmentPatient.fromUser(_userService.currentUser)
        .copyWith(species: selectedSpecies);
    var caseId = _generateCase();

    var treatment = Treatment(
        id: caseId,
        timestamp: DateTime.now().timestamp,
        status:
            isFreeTreatment ? TreatmentStatus.open : TreatmentStatus.created,
        doctor: TreatmentDoctor.fromDoctor(doctor),
        patient: patient,
        images: [],
        call: null,
        medicines: []);

    _log.i("Creating new treatment: $treatment ");

    try {
      await _treatmentsRef.doc(caseId).set(treatment);
      _log.v("Treatment created at $caseId");

      return treatment;
    } catch (error) {
      _log.e(error);
      throw FirestoreApiException(
          message: "Failed to create treatment", devDetails: "$error");
    }
  }

  Future<List<Treatment>> fetchTreatments(String userId) async {
    try {
      var treatmentDocumentSnapshot = await _treatmentsRef
          .where("patient.id", isEqualTo: userId)
          .orderBy("timestamp", descending: true)
          .get();

      List<Treatment> list = [];

      if (treatmentDocumentSnapshot.docs.isNotEmpty) {
        treatmentDocumentSnapshot.docs
            .forEach((snapshot) => list.add(snapshot.data()));
        return list;
      }

      return [];
    } catch (error) {
      _log.e(error);
      throw FirestoreApiException(message: "$error");
    }
  }

  Stream getTreatment({required String caseId}) {
    _fetchTreatmentDetails(caseId);
    return _treatmentDetailsStream.stream;
  }

  void _fetchTreatmentDetails(String caseId) {
    _treatmentsRef.doc(caseId).snapshots().listen((event) {
      if (!event.exists) _treatmentDetailsStream.addError("No Treatment found");
      _treatmentDetailsStream.add(event.data()!);
    });
  }

  String _generateCase() {
    var r = Random();
    var caseId =
        String.fromCharCodes(List.generate(7, (index) => r.nextInt(9) + 49));
    return "VMC$caseId";
  }
}
