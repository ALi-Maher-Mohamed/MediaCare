import 'package:equatable/equatable.dart';

class DeliveryServiceModel extends Equatable {
  final String id;
  final String name;
  final String appLink;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryServiceModel({
    required this.id,
    required this.name,
    required this.appLink,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryServiceModel.fromJson(Map<String, dynamic> json) {
    return DeliveryServiceModel(
      id: json['id'],
      name: json['name'],
      appLink: json['app_link'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'app_link': appLink,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props =>
      [id, name, appLink, description, createdAt, updatedAt];
}
