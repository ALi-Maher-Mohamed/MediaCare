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
  final bool deliveryOption;
  final bool insurance;
  final double avgRate;

  PharmacyModel({
    required this.id,
    required this.title,
    required this.service,
    required this.image,
    required this.phone,
    required this.city,
    required this.area,
    required this.locationUrl,
    required this.whatsappLink,
    required this.deliveryOption,
    required this.insurance,
    required this.avgRate,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'],
      title: json['title'],
      service: json['service'],
      image: json['image'],
      phone: json['phone'],
      city: json['city'],
      area: json['area'],
      locationUrl: json['locationUrl'],
      whatsappLink: json['whatsappLink'],
      deliveryOption: json['deliveryOption'] == 1,
      insurance: json['insurence'] == 1,
      avgRate: double.tryParse(json['avg_rate'].toString()) ?? 0.0,
    );
  }
}
