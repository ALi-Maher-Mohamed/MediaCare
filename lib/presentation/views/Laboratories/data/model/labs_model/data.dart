class LaboratoryModel {
  final String id;
  final String title;
  final String service;
  final String image;
  final String phone;
  final String city;
  final String area;
  final String locationUrl;
  final String whatsappLink;
  final double avgRate;

  LaboratoryModel({
    required this.id,
    required this.title,
    required this.service,
    required this.image,
    required this.phone,
    required this.city,
    required this.area,
    required this.locationUrl,
    required this.whatsappLink,
    required this.avgRate,
  });
  factory LaboratoryModel.fromJson(Map<String, dynamic> json) {
    return LaboratoryModel(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Unknown',
      service: json['service'] ?? 'No Service Provided',
      image: json['image'] ?? '',
      phone: json['phone'] ?? 'No Phone',
      city: json['city'] ?? 'Unknown City',
      area: json['area'] ?? 'Unknown Area',
      locationUrl: json['locationUrl'] ?? '',
      whatsappLink: json['whatsappLink'] ?? '',
      avgRate: (json['avg_rate'] != null)
          ? double.tryParse(json['avg_rate'].toString()) ?? 0.0
          : 0.0, // تفادي null
    );
  }
}
