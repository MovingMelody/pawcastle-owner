class FirestoreApiException implements Exception {
  final String message;
  final String? devDetails;
  final String? prettyDetails;

  FirestoreApiException({
    this.message = 'something went wrong',
    this.devDetails,
    this.prettyDetails,
  });

  @override
  String toString() {
    return 'FirestoreApiException: $message ${devDetails != null ? '- $devDetails' : ''}';
  }
}
