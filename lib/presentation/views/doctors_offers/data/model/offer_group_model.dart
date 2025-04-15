import 'package:equatable/equatable.dart';

class OfferGroupResponse {
  final bool success;
  final String message;
  final List<OfferGroup> data;

  OfferGroupResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OfferGroupResponse.fromJson(Map<String, dynamic> json) {
    return OfferGroupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => OfferGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class OfferGroupDetailsResponse {
  final bool success;
  final String message;
  final OfferGroup data;

  OfferGroupDetailsResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory OfferGroupDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OfferGroupDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: OfferGroup.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class OfferGroup extends Equatable {
  final String id;
  final String image;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? doctorOffersCount;
  final List<dynamic>? doctorOffers;

  const OfferGroup({
    required this.id,
    required this.image,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.doctorOffersCount,
    this.doctorOffers,
  });

  factory OfferGroup.fromJson(Map<String, dynamic> json) {
    return OfferGroup(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt:
          DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
      doctorOffersCount: json['doctor_offers_count'],
      doctorOffers: json['doctor_offers'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        image,
        title,
        createdAt,
        updatedAt,
        doctorOffersCount,
        doctorOffers,
      ];
}
