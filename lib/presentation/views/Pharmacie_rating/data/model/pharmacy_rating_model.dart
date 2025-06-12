class PharmacyRatingModel {
  final String? review;
  final int ratingValue;
  final String userId;
  final String pharmacyId;
  final double avgRate;

  PharmacyRatingModel({
    required this.review,
    required this.ratingValue,
    required this.userId,
    required this.pharmacyId,
    required this.avgRate,
  });

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating_value': ratingValue,
      'user_id': userId,
      'pharmacy_id': pharmacyId,
      'avg_rate': avgRate,
    };
  }

  factory PharmacyRatingModel.fromJson(Map<String, dynamic> json) {
    try {
      return PharmacyRatingModel(
        review: json['review'] as String?,
        ratingValue: json['rating_value'] as int? ?? 0,
        userId: json['user_id'] as String? ?? '',
        pharmacyId: json['pharmacy_id'] as String? ?? '',
        avgRate: (json['avg_rate'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw FormatException('Failed to parse PharmacyRatingModel: $e');
    }
  }
}
