import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/app/setup.logger.dart';
import 'package:petowner/src/constants/keys.dart';

import 'package:petowner/src/exceptions/firestore_exception.dart';
import 'package:pawcastle_datamodels/pawcastle_datamodels.dart';

class CallService {
  final _log = getLogger("TreatmentService");

  final _callsRef = FirebaseFirestore.instance
      .collection(kCallsFirestoreKey)
      .withConverter<Voicecall>(
        fromFirestore: (snapshot, _) => Voicecall.fromSnapshot(snapshot),
        toFirestore: (call, _) => call.toMap(),
      );

  final StreamController<Voicecall> _callStream =
      StreamController<Voicecall>.broadcast();

  Stream listenToCallUpdates(String channelId) {
    _getCallStream(channelId);
    return _callStream.stream;
  }

  Future<Voicecall> initCall(
      {required Treatment treatment, bool followUp = false}) async {
    var call = Voicecall.fromTreatment(treatment, isFollowup: followUp);

    try {
      await _callsRef.doc(call.id).set(call);
      _log.v("Call created at ${call.details.channelId}");

      return call;
    } catch (error) {
      throw FirestoreApiException(
          message: "Failed to init call", devDetails: "$error");
    }
  }

  Future _getCallStream(String channelId) async {
    _callsRef.doc(channelId).snapshots().listen((postsSnapshot) {
      var data = postsSnapshot.data();
      if (data != null) _callStream.add(data);
    });
  }
}
