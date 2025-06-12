class LaboratoryRatingModel {
  final String? review;
  final int ratingValue;
  final String userId;
  final String laboratoryId;
  final double avgRate;

  LaboratoryRatingModel({
    required this.review,
    required this.ratingValue,
    required this.userId,
    required this.laboratoryId,
    required this.avgRate,
  });

  Map<String, dynamic> toJson() {
    return {
      'review': review,
      'rating_value': ratingValue,
      'user_id': userId,
      'laboratory_id': laboratoryId,
      'avg_rate': avgRate,
    };
  }

  factory LaboratoryRatingModel.fromJson(Map<String, dynamic> json) {
    try {
      return LaboratoryRatingModel(
        review: json['review'] as String?,
        ratingValue: json['rating_value'] as int? ?? 0,
        userId: json['user_id'] as String? ?? '',
        laboratoryId: json['laboratory_id'] as String? ?? '',
        avgRate: (json['avg_rate'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw FormatException('Failed to parse LaboratoryRatingModel: $e');
    }
  }
}
