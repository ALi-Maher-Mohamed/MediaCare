class DoctorRatingModel {
  final String? review;
  final int ratingValue;
  final String userId;
  final String doctorId;
  final double avgRate;

  DoctorRatingModel({
    required this.review,
    required this.ratingValue,
    required this.userId,
    required this.doctorId,
    required this.avgRate,
  });

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating_value': ratingValue,
      'user_id': userId,
      'doctor_id': doctorId,
      'avg_rate': avgRate,
    };
  }

  factory DoctorRatingModel.fromJson(Map<String, dynamic> json) {
    try {
      return DoctorRatingModel(
        review: json['review'] as String?,
        ratingValue: json['rating_value'] as int? ?? 0,
        userId: json['user_id'] as String? ?? '',
        doctorId: json['doctor_id'] as String? ?? '',
        avgRate: (json['avg_rate'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw FormatException('Failed to parse DoctorRatingModel: $e');
    }
  }
}
