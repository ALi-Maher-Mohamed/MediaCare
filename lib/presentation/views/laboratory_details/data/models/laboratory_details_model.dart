import 'package:equatable/equatable.dart';

class Laboratory extends Equatable {
  final String id;
  final String title;
  final String service;
  final String image;
  final String phone;
  final String city;
  final String area;
  final String locationUrl;
  final String whatsappLink;
  final int insurance;
  final String startAt;
  final String endAt;
  final String avgRate;
  final String? chainLaboratoryId;
  final String createdAt;
  final String updatedAt;
  final List<User> users;
  final List<InsuranceCompany> insuranceCompanies;

  const Laboratory({
    required this.id,
    required this.title,
    required this.service,
    required this.image,
    required this.phone,
    required this.city,
    required this.area,
    required this.locationUrl,
    required this.whatsappLink,
    required this.insurance,
    required this.startAt,
    required this.endAt,
    required this.avgRate,
    this.chainLaboratoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
    required this.insuranceCompanies,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        service,
        image,
        phone,
        city,
        area,
        locationUrl,
        whatsappLink,
        insurance,
        startAt,
        endAt,
        avgRate,
        chainLaboratoryId,
        createdAt,
        updatedAt,
        users,
        insuranceCompanies,
      ];
}

class User extends Equatable {
  final String id;
  final String name;
  final String? review;
  final String? rating;

  const User({
    required this.id,
    required this.name,
    this.review,
    this.rating,
  });

  @override
  List<Object?> get props => [id, name, review, rating];
}

class InsuranceCompany extends Equatable {
  final String id;
  final String name;

  const InsuranceCompany({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
