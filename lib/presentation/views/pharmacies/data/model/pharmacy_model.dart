// class PharmacyModel {
//   final String title;
//   final String image;

//   PharmacyModel({required this.title, required this.image});
// }
class PharmacyModel {
  final String id;
  final String title;
  final String service;
  final String image;
  final String phone;
  final String city;
  final String area;
  final String locationUrl;
  final String whatsappLink;
  final int deliveryOption;
  final int insurance;
  final String avgRate;

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
      deliveryOption: json['deliveryOption'],
      insurance: json['insurence'],
      avgRate: json['avg_rate'],
    );
  }
}
