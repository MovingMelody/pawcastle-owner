class TreatmentRating {
  final double rating;
  final String caseId;
  final String patientId;
  final String doctorId;
  final String timestamp;
  final String? comments;

  TreatmentRating({
    required this.rating,
    required this.caseId,
    required this.patientId,
    required this.doctorId,
    required this.timestamp,
    this.comments,
  });

  Map<String, dynamic> toMap() {
    return {
      'rating': rating,
      'case_id': caseId,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'timestamp': timestamp,
      'comments': comments,
    };
  }

  factory TreatmentRating.fromMap(Map<String, dynamic> map) {
    return TreatmentRating(
      rating: map['rating'],
      caseId: map['case_id'],
      patientId: map['patient_id'],
      doctorId: map['doctor_id'],
      timestamp: map['timestamp'],
      comments: map['comments'] != null ? map['comments'] : null,
    );
  }
}
