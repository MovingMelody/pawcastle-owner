import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:petowner/src/modules/payments/models/payment.dart';
import 'package:petowner/src/modules/user/services/user_service.dart';
import 'package:petowner/src/utils/timestamp.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';

class PaymentService {
  final _log = getLogger("PaymentService");

  final _userService = locator<UserService>();

  final _paymentsRef = FirebaseFirestore.instance
      .collection(kPaymentsFirestoreKey)
      .withConverter<Payment>(
        fromFirestore: (snapshot, _) => Payment.fromMap(snapshot.data()!),
        toFirestore: (payment, _) => payment.toMap(),
      );

  final _orderRef =
      FirebaseFirestore.instance.collection(kShopOrdersFirestoreKey);

  final _treatmentsRef = FirebaseFirestore.instance.collection(kTreatments);

  Future<void> handlePaymentSuccess(
      {required String paymentId,
      required String orderId,
      required double amount,
      required String ref,
      String type = "SHOP"}) {
    _log.i('capturing payment $type');

    final userId = _userService.currentUser.id;

    final paymentRef = _paymentsRef.doc(paymentId);

    final orderRef =
        type == "TREATMENT" ? _treatmentsRef.doc(ref) : _orderRef.doc(ref);

    /// The reason why I chose Batched writes is that
    /// they execute even when the user's device is offline.

    var batch = FirebaseFirestore.instance.batch();

    batch.set<Payment>(
        paymentRef,
        Payment(
            paymentId: paymentId,
            orderId: orderId,
            timestamp: DateTime.now().timestamp,
            type: type,
            userId: userId,
            amount: amount,
            reference: ref));

    if (type == "SHOP")
      batch.set(
          orderRef,
          {
            'status': 'paid',
            'order': {'payment_id': paymentId}
          },
          SetOptions(merge: true));

    if (type == "TREATMENT")
      batch.set(
          orderRef,
          {
            'status': TreatmentStatus.open.value,
            'payment': {'paymentId': paymentId}
          },
          SetOptions(merge: true));

    try {
      return batch.commit();
    } catch (error) {
      _log.e(error);
      throw FirestoreApiException(
          message: 'Failed to capture payment', devDetails: '$error');
    }
  }
}
