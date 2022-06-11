import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petowner/src/constants/keys.dart';
import 'package:petowner/src/modules/treatment/models/treatment_rating.dart';
import 'package:petowner/src/exceptions/firestore_exception.dart';

class TreatmentRatingService {
  final CollectionReference ratingsCollection = FirebaseFirestore.instance
      .collection(kRatingsFirestoreKey)
      .withConverter<TreatmentRating>(
        fromFirestore: (snapshot, _) =>
            TreatmentRating.fromMap(snapshot.data()!),
        toFirestore: (rating, _) => rating.toMap(),
      );

  Future<void> addRating({required TreatmentRating rating}) async {
    try {
      await ratingsCollection.add(rating);
    } catch (error) {
      throw FirestoreApiException(
        message: 'Failed to add Rating',
        devDetails: '$error',
      );
    }
  }
}
