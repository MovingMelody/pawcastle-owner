import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';

class FirestoreApi {
  final _log = getLogger("FirestoreService");

  final _uiAssetsRef = FirebaseFirestore.instance.collection('uiassets');
  final _userService = locator<UserService>();

  final _pharmacyOrdersRef = FirebaseFirestore.instance
      .collection(kMedicineOrders)
      .withConverter<MedicineOrder>(
        fromFirestore: (snapshot, _) => MedicineOrder.fromSnapshot(snapshot),
        toFirestore: (voicecall, _) => voicecall.toMap(),
      );

  final StreamController<List<MedicineOrder>> _pharmacyOrdersController =
      StreamController<List<MedicineOrder>>.broadcast();

  final StreamController<MedicineOrder> _medicineOrderStream =
      StreamController<MedicineOrder>.broadcast();

  Future fetchHomePageBanners() async {
    _log.i('fetching homepage banners');
    try {
      var homepageBanners = await _uiAssetsRef.doc("--home-page-banners").get();

      if (homepageBanners.exists) return homepageBanners['banners'];

      return [];
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }

  Future fetchAnimalCategories() async {
    _log.i('fetching animal categories');
    try {
      var speciesGroups = await _uiAssetsRef.doc("--animal-categories").get();

      if (speciesGroups.exists) return speciesGroups['categories'];

      return [];
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new user',
        devDetails: '$error',
      );
    }
  }

  Stream getPaymentOrders() {
    _fetchPharmacyOrders();
    return _pharmacyOrdersController.stream;
  }

  Stream getMedicineOrder({required String caseId}) {
    _fetchMedicineOrder(caseId);
    return _medicineOrderStream.stream;
  }

  void _fetchMedicineOrder(String caseId) {
    _pharmacyOrdersRef
        .where("caseId", isEqualTo: caseId)
        .limit(1)
        .snapshots()
        .listen((ordersSnapshot) {
      if (ordersSnapshot.docs.isEmpty) {
        _log.i("No such medicine order found");
        _medicineOrderStream.addError("No Medicine Found");
      } else if (ordersSnapshot.docs.isNotEmpty) {
        var orders =
            ordersSnapshot.docs.map((snapshot) => snapshot.data()).toList();

        _medicineOrderStream.add(orders.first);
      }
    });
  }

  void _fetchPharmacyOrders() {
    var user = _userService.currentUser;
    _pharmacyOrdersRef
        // .where(
        //   "status",
        //   whereIn: [
        //     MedicineOrderStatus.awaitingPayment.value,
        //     MedicineOrderStatus.dispatched.value,
        //     MedicineOrderStatus.paid.value
        //   ],
        // )
        .where("customer.id", isEqualTo: user.id)
        .snapshots()
        .listen((ordersSnapshot) {
      if (ordersSnapshot.docs.isEmpty) {
        _log.i("No orders found to this pharmacy");
      } else if (ordersSnapshot.docs.isNotEmpty) {
        var orders = ordersSnapshot.docs
            .map((snapshot) =>
                snapshot.data().copyWith(reference: snapshot.reference))
            .toList()
            .where((element) => element.status != MedicineOrderStatus.paid)
            .toList()
            .where((element) => element.status.toString() != "closed")
            .toList();
        // closed medicineOrders need not to show again in homescreen
        // closed enum isn't added, so hardcoded it

        _pharmacyOrdersController.add(orders);
      }
    });
  }
}
