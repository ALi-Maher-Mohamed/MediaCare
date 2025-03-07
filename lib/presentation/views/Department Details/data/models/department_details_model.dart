import 'package:media_care/presentation/views/Department/data/models/department_model.dart';

class DepartmentDetailsModel {
  final bool success;
  final String message;
  final DepartmentDetails data;

  DepartmentDetailsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DepartmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return DepartmentDetailsModel(
      success: json['success'],
      message: json['message'],
      data: DepartmentDetails.fromJson(json['data']),
    );
  }
}

class DepartmentDetails {
  final Department department;
  final int hospitalsCount;
  final int careCentersCount;
  final int doctorsCount;
  final List<Hospital> hospitals;
  final List<Doctor> doctors;
  final List<Tip> tips;

  DepartmentDetails({
    required this.department,
    required this.hospitalsCount,
    required this.careCentersCount,
    required this.doctorsCount,
    required this.hospitals,
    required this.doctors,
    required this.tips,
  });

  factory DepartmentDetails.fromJson(Map<String, dynamic> json) {
    return DepartmentDetails(
      department: Department.fromJson(json['department']),
      hospitalsCount: json['hospitals_count'],
      careCentersCount: json['care_centers_count'],
      doctorsCount: json['doctors_count'],
      hospitals: (json['hospitals']['data'] as List)
          .map((item) => Hospital.fromJson(item))
          .toList(),
      doctors: (json['doctors']['data'] as List)
          .map((item) => Doctor.fromJson(item))
          .toList(),
      tips: (json['tips'] as List).map((item) => Tip.fromJson(item)).toList(),
    );
  }
}

class Hospital {
  final String id;
  final String title;
  final String service;
  final String? image;
  final String phone;
  final String address;
  final String locationUrl;
  final String startAt;
  final String endAt;
  final String appPrice;

  Hospital({
    required this.id,
    required this.title,
    required this.service,
    this.image,
    required this.phone,
    required this.address,
    required this.locationUrl,
    required this.startAt,
    required this.endAt,
    required this.appPrice,
  });

  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['id'],
      title: json['title'],
      service: json['service'],
      image: json['image'],
      phone: json['phone'],
      address: json['address'],
      locationUrl: json['locationUrl'],
      startAt: json['pivot']['start_at'],
      endAt: json['pivot']['end_at'],
      appPrice: json['pivot']['app_price'],
    );
  }
}

class Doctor {
  final String id;
  final String fName;
  final String lName;
  final String gender;
  final String birthDate;
  final String phone;
  final String? image;
  final String whatsappLink;
  final String facebookLink;
  final String title;
  final String infoAboutDoctor;
  final String appPrice;
  final bool homeOption;
  final String avgRate;
  final String email;

  Doctor({
    required this.id,
    required this.fName,
    required this.lName,
    required this.gender,
    required this.birthDate,
    required this.phone,
    this.image,
    required this.whatsappLink,
    required this.facebookLink,
    required this.title,
    required this.infoAboutDoctor,
    required this.appPrice,
    required this.homeOption,
    required this.avgRate,
    required this.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      fName: json['fName'],
      lName: json['lName'],
      gender: json['gender'],
      birthDate: json['birthDate'],
      phone: json['phone'],
      image: json['image'],
      whatsappLink: json['whatsappLink'],
      facebookLink: json['facebookLink'],
      title: json['title'],
      infoAboutDoctor: json['infoAboutDoctor'],
      appPrice: json['app_price'],
      homeOption: json['homeOption'] == 1,
      avgRate: json['avg_rate'],
      email: json['email'],
    );
  }
}

class Tip {
  final String id;
  final String question;
  final String answer;

  Tip({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
