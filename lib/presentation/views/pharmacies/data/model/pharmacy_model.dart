class PharmacyModel {
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
  final int insurence;
  final String startAt;
  final String endAt;
  final String avgRate;
  final String? chainPharmacyId;
  final String createdAt;
  final String updatedAt;

  PharmacyModel({
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
    required this.insurence,
    required this.startAt,
    required this.endAt,
    required this.avgRate,
    this.chainPharmacyId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'] as String,
      title: json['title'] as String,
      service: json['service'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String,
      city: json['city'] as String,
      area: json['area'] as String,
      locationUrl: json['locationUrl'] as String,
      whatsappLink: json['whatsappLink'] as String,
      deliveryOption: json['deliveryOption'] as int,
      insurence: json['insurence'] as int,
      startAt: json['start_at'] as String,
      endAt: json['end_at'] as String,
      avgRate: json['avg_rate'] as String,
      chainPharmacyId: json['chain_pharmacy_id'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'service': service,
      'image': image,
      'phone': phone,
      'city': city,
      'area': area,
      'locationUrl': locationUrl,
      'whatsappLink': whatsappLink,
      'deliveryOption': deliveryOption,
      'insurence': insurence,
      'start_at': startAt,
      'end_at': endAt,
      'avg_rate': avgRate,
      'chain_pharmacy_id': chainPharmacyId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
