class DoctorDetailsModel {
  bool? success;
  String? message;
  Data? data;

  DoctorDetailsModel({this.success, this.message, this.data});

  factory DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    return DoctorDetailsModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class Data {
  String? id;
  String? fName;
  String? lName;
  String? gender;
  String? birthDate;
  String? phone;
  String? image;
  String? whatsappLink;
  String? facebookLink;
  String? title;
  String? infoAboutDoctor;
  String? appPrice;
  int? homeOption;
  String? avgRate;
  String? email;
  String? role;
  String? departmentId;
  int? status;
  String? createdAt;
  Department? department;
  List<Specialization>? specializations;
  List<Clinic>? clinics;
  List<Appointment>? appointments;
  Map<String, List<Appointment>>? appointmentsGroupedByDate;

  Data({
    this.id,
    this.fName,
    this.lName,
    this.gender,
    this.birthDate,
    this.phone,
    this.image,
    this.whatsappLink,
    this.facebookLink,
    this.title,
    this.infoAboutDoctor,
    this.appPrice,
    this.homeOption,
    this.avgRate,
    this.email,
    this.role,
    this.departmentId,
    this.status,
    this.createdAt,
    this.department,
    this.specializations,
    this.clinics,
    this.appointments,
    this.appointmentsGroupedByDate,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['fName'];
    lName = json['lName'];
    gender = json['gender'];
    birthDate = json['birthDate'];
    phone = json['phone'];
    image = json['image'];
    whatsappLink = json['whatsappLink'];
    facebookLink = json['facebookLink'];
    title = json['title'];
    infoAboutDoctor = json['infoAboutDoctor'];
    appPrice = json['app_price'];
    homeOption = json['homeOption'];
    avgRate = json['avg_rate'];
    email = json['email'];
    role = json['role'];
    departmentId = json['department_id'];
    status = json['status'];
    createdAt = json['created_at'];
    department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;

    if (json['specializations'] != null) {
      specializations = (json['specializations'] as List)
          .map((e) => Specialization.fromJson(e))
          .toList();
    }

    if (json['clinics'] != null) {
      clinics =
          (json['clinics'] as List).map((e) => Clinic.fromJson(e)).toList();
    }

    if (json['appointments'] != null) {
      appointments = (json['appointments'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList();
    }

    if (json['appointmentsGroupedByDate'] != null &&
        json['appointmentsGroupedByDate'] is Map) {
      appointmentsGroupedByDate = {};
      (json['appointmentsGroupedByDate'] as Map<String, dynamic>)
          .forEach((key, value) {
        if (value is List) {
          // Ensure value is a List before mapping
          appointmentsGroupedByDate![key] =
              value.map((e) => Appointment.fromJson(e)).toList();
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fName': fName,
      'lName': lName,
      'gender': gender,
      'birthDate': birthDate,
      'phone': phone,
      'image': image,
      'whatsappLink': whatsappLink,
      'facebookLink': facebookLink,
      'title': title,
      'infoAboutDoctor': infoAboutDoctor,
      'app_price': appPrice,
      'homeOption': homeOption,
      'avg_rate': avgRate,
      'email': email,
      'role': role,
      'department_id': departmentId,
      'status': status,
      'created_at': createdAt,
      'department': department?.toJson(),
      'specializations': specializations?.map((e) => e.toJson()).toList(),
      'clinics': clinics?.map((e) => e.toJson()).toList(),
      'appointments': appointments?.map((e) => e.toJson()).toList(),
      'appointmentsGroupedByDate': appointmentsGroupedByDate?.map(
          (key, value) => MapEntry(key, value.map((e) => e.toJson()).toList())),
    };
  }
}

class Department {
  String? id;
  String? title;
  String? description;
  String? icon;

  Department({this.id, this.title, this.description, this.icon});

  Department.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'icon': icon,
    };
  }
}

class Specialization {
  String? id;
  String? title;
  String? createdAt;
  String? updatedAt;

  Specialization({this.id, this.title, this.createdAt, this.updatedAt});

  Specialization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Clinic {
  String? id;
  String? title;
  String? description;
  String? address;
  String? locationUrl;
  String? phone;

  Clinic(
      {this.id,
      this.title,
      this.description,
      this.address,
      this.locationUrl,
      this.phone});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    locationUrl = json['locationUrl'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'address': address,
      'locationUrl': locationUrl,
      'phone': phone,
    };
  }
}

class Appointment {
  String? id;
  String? day;
  String? startAt;
  String? endAt;
  int? duration;
  int? isBooked;
  String? doctorId;
  String? clinicId;

  Appointment(
      {this.id,
      this.day,
      this.startAt,
      this.endAt,
      this.duration,
      this.isBooked,
      this.doctorId,
      this.clinicId});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    duration = json['duration'];
    isBooked = json['is_booked'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'start_at': startAt,
      'end_at': endAt,
      'duration': duration,
      'is_booked': isBooked,
      'doctor_id': doctorId,
      'clinic_id': clinicId,
    };
  }
}
