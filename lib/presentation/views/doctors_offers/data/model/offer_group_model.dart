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
  final List<DoctorOffer>? doctorOffers;

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
      doctorOffers: (json['doctor_offers'] as List<dynamic>?)
          ?.map((e) => DoctorOffer.fromJson(e))
          .toList(),
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

class DoctorOffer extends Equatable {
  final String id;
  final String title;
  final String infoAboutOffer;
  final String details;
  final String priceBeforeDiscount;
  final String discount;
  final String fromDay;
  final String toDay;
  final int isActive;
  final String doctorId;
  final String offerGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<DoctorOfferImage> images;

  const DoctorOffer({
    required this.id,
    required this.title,
    required this.infoAboutOffer,
    required this.details,
    required this.priceBeforeDiscount,
    required this.discount,
    required this.fromDay,
    required this.toDay,
    required this.isActive,
    required this.doctorId,
    required this.offerGroupId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory DoctorOffer.fromJson(Map<String, dynamic> json) {
    return DoctorOffer(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      infoAboutOffer: json['info_about_offer'] ?? '',
      details: json['details'] ?? '',
      priceBeforeDiscount: json['price_before_discount'] ?? '',
      discount: json['discount'] ?? '',
      fromDay: json['from_day'] ?? '',
      toDay: json['to_day'] ?? '',
      isActive: json['is_active'] ?? 0,
      doctorId: json['doctor_id'] ?? '',
      offerGroupId: json['offer_group_id'] ?? '',
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt:
          DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => DoctorOfferImage.fromJson(e))
              .toList() ??
          [],
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        infoAboutOffer,
        details,
        priceBeforeDiscount,
        discount,
        fromDay,
        toDay,
        isActive,
        doctorId,
        offerGroupId,
        createdAt,
        updatedAt,
        images,
      ];
}

class DoctorOfferImage extends Equatable {
  final String id;
  final String image;
  final String doctorOfferId;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DoctorOfferImage({
    required this.id,
    required this.image,
    required this.doctorOfferId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DoctorOfferImage.fromJson(Map<String, dynamic> json) {
    return DoctorOfferImage(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      doctorOfferId: json['doctor_offer_id'] ?? '',
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
      updatedAt:
          DateTime.parse(json['updated_at'] ?? DateTime.now().toString()),
    );
  }

  @override
  List<Object> get props => [id, image, doctorOfferId, createdAt, updatedAt];
}
