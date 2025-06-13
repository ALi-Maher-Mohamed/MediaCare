class PharmacyResponse {
  final bool success;
  final String message;
  final PharmacyData data;

  PharmacyResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PharmacyResponse.fromJson(Map<String, dynamic> json) {
    return PharmacyResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: PharmacyData.fromJson(json['data'] ?? {}),
    );
  }
}

class PharmacyData {
  final String id;
  final String title;
  final String service;
  final String? image;
  final String phone;
  final String city;
  final String area;
  final String locationUrl;
  final String whatsappLink;
  final int deliveryOption;
  final int insurance;
  final String startAt;
  final String endAt;
  final String avgRate;
  final String? chainPharmacyId;
  final String createdAt;
  final String updatedAt;
  final List<User> users;
  final List<dynamic> insuranceCompanies;

  PharmacyData({
    required this.id,
    required this.title,
    required this.service,
    this.image,
    required this.phone,
    required this.city,
    required this.area,
    required this.locationUrl,
    required this.whatsappLink,
    required this.deliveryOption,
    required this.insurance,
    required this.startAt,
    required this.endAt,
    required this.avgRate,
    this.chainPharmacyId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.insuranceCompanies,
  });

  factory PharmacyData.fromJson(Map<String, dynamic> json) {
    return PharmacyData(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      service: json['service'] ?? '',
      image: json['image'],
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      locationUrl: json['locationUrl'] ?? '',
      whatsappLink: json['whatsappLink'] ?? '',
      deliveryOption: json['deliveryOption'] ?? 0,
      insurance: json['insurence'] ?? 0,
      startAt: json['start_at'] ?? '',
      endAt: json['end_at'] ?? '',
      avgRate: json['avg_rate'] ?? '0.0',
      chainPharmacyId: json['chain_pharmacy_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      users: (json['users'] as List<dynamic>?)
              ?.map((user) => User.fromJson(user))
              .toList() ??
          [],
      insuranceCompanies: json['insurance_companies'] ?? [],
    );
  }
}

class User {
  final String id;
  final String? googleId;
  final String? avatar;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? verificationTokenExpiresAt;
  final String? resetToken;
  final String? resetTokenExpiresAt;
  final String phone;
  final String address;
  final String birthDate;
  final String role;
  final int points;
  final String lastVisit;
  final String createdAt;
  final String updatedAt;
  final Pivot pivot;

  User({
    required this.id,
    this.googleId,
    this.avatar,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.verificationTokenExpiresAt,
    this.resetToken,
    this.resetTokenExpiresAt,
    required this.phone,
    required this.address,
    required this.birthDate,
    required this.role,
    required this.points,
    required this.lastVisit,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      googleId: json['google_id'],
      avatar: json['avatar'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      verificationTokenExpiresAt: json['verification_token_expires_at'],
      resetToken: json['reset_token'],
      resetTokenExpiresAt: json['reset_token_expires_at'],
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      birthDate: json['birth_date'] ?? '',
      role: json['role'] ?? '',
      points: json['points'] ?? 0,
      lastVisit: json['last_visit'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      pivot: Pivot.fromJson(json['pivot'] ?? {}),
    );
  }
}

class Pivot {
  final String pharmacyId;
  final String userId;
  final String review;
  final int ratingValue;
  final String createdAt;
  final String updatedAt;

  Pivot({
    required this.pharmacyId,
    required this.userId,
    required this.review,
    required this.ratingValue,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      pharmacyId: json['pharmacy_id'] ?? '',
      userId: json['user_id'] ?? '',
      review: json['review'] ?? '',
      ratingValue: json['rating_value'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
