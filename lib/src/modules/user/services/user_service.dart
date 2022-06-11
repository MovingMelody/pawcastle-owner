import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/services/fcm_service.dart';
import 'package:petowner/src/utils/timestamp.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';
import 'package:pawcastle_phoneauth/pawcastle_phoneauth.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/app/setup.locator.dart';

class UserService {
  final _log = getLogger("UserService");
  final _fcmService = locator<FcmService>();

  final _firebaseAuthApi = locator<FirebaseAuthApi>();

  final _customersCollection = FirebaseFirestore.instance
      .collection(kCustomersFirestoreKey)
      .withConverter<Customer>(
        fromFirestore: (snapshot, _) => Customer.fromSnapshot(snapshot),
        toFirestore: (customer, _) => customer.toMap(),
      );
  final _topicsRef = FirebaseFirestore.instance
      .collection(kTopicsFirestoreKey)
      .doc(kCustomersFirestoreKey);

  Customer? _currentUser;
  Address? _currentSelectedUserAddress;

  Customer get currentUser => _currentUser!;
  Address get getCurrentUserSelectedAddress => _currentSelectedUserAddress!;

  bool get hasLoggedInUser => _firebaseAuthApi.hasAuthUser;

  bool get hasProfile => _currentUser != null;

  void setUserAddress(Address address) => _currentSelectedUserAddress = address;

  Future<void> addNewUserAddress(Address e) async {
    if (hasProfile)
      try {
        await _customersCollection.doc(_currentUser!.id).update({
          'addresses': FieldValue.arrayUnion([e.toMap()])
        });

        _log.v('added new address ${e.zipcode} to ${currentUser.id}');
      } catch (error) {
        throw FirestoreApiException(
            message: 'Failed to add address to firestore',
            devDetails: '$error');
      }
  }

  Future<void> syncUserAccount() async {
    var customerId = _firebaseAuthApi.authUser!.uid;

    _log.i("Syncing user $customerId");

    final userAccount = await _getCustomer(customerId);

    if (userAccount != null) {
      _log.v('User account exists. Save as _currentUser');
      _currentSelectedUserAddress = userAccount.addresses[0];
      _currentUser = userAccount;
      updateToken();
      _subscribeToRegion();
    }
  }

  Future<void> createAndSyncUserAccount({required Customer customer}) async {
    if (_currentUser == null) {
      _log.v('We have no user account. Create a new user ...');
      var token = await _fcmService.generateToken();
      await _createCustomer(customer: customer.copyWith(fcmToken: token));
      _currentUser = customer;
      _currentSelectedUserAddress = customer.addresses[0];
      _subscribeToRegion();
      _log.v('_currentUser has been saved');
      _log.v(customer);
    }
  }

  /// Creates a new [Customer] document with customerId as documentId
  /// and inside the /customers collection
  Future<void> _createCustomer({required Customer customer}) async {
    try {
      final customerDoc = _customersCollection.doc(customer.id);
      await customerDoc.set(customer);
      await customerDoc.update({
        '_metadata': {'created': DateTime.now().timestamp}
      });

      _log.v('Customer created at ${customerDoc.path}');
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to create new customer',
        devDetails: '$error',
      );
    }
  }

  Future _subscribeToRegion() async {
    List regions = [];

    var topics = await _topicsRef.get();

    if (topics.data() != null) {
      regions = topics.data()?['regions'] ?? [];
    }

    var region = currentUser.addresses.first.district?.topic ?? "";
    if (region.isNotEmpty)
      _fcmService.subscribeTopic(topic: region, userId: currentUser.id);

    if (!regions.contains(region)) {
      if (region.isNotEmpty) regions.add(region);
      await _topicsRef
          .set({"regions": regions}, SetOptions(mergeFields: ['regions']));
    } else {
      _log.v("topic already exists on firebase");
    }

    _log.v('Customer subscribe to $region');
  }

  Future<Customer?> _getCustomer(String customerId) async {
    try {
      final customerDoc = await _customersCollection.doc(customerId).get();

      if (!customerDoc.exists) {
        _log.v('We have no user with id $customerId in our database');
        return null;
      }

      final userData = customerDoc.data();
      _log.v('User found. Data: $userData');

      return userData;
    } catch (error) {
      throw FirestoreApiException(
          message: 'Failed to get customer from firestore',
          devDetails: '$error');
    }
  }

  Future updateToken() async {
    var updatedToken = await _fcmService.getUpdatedToken(currentUser.fcmToken);

    if (updatedToken != null) {
      _log.i('updating fcm token');
      _currentUser = _currentUser?.copyWith(fcmToken: updatedToken);
      await currentUser.reference?.update({'_notification': updatedToken});
    }
  }
}

extension TopicParser on String {
  String get topic => this.split(" ").map((str) => str.toLowerCase()).join("_");
}
