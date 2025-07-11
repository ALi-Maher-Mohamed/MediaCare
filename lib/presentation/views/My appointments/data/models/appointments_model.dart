class myAppointmentsModel {
  String? message;
  List<Data>? data;

  myAppointmentsModel({this.message, this.data});

  myAppointmentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? doctorId;
  String? clinicId;
  int? appointmentId;
  String? status;
  String? paymentIntentId;
  String? currency;
  String? paymentStatus;
  String? finalPrice;
  Null paymentMethod;
  String? createdAt;
  String? updatedAt;
  Doctor? doctor;
  Clinic? clinic;
  Appointment? appointment;

  Data(
      {this.id,
      this.userId,
      this.doctorId,
      this.clinicId,
      this.appointmentId,
      this.status,
      this.paymentIntentId,
      this.currency,
      this.paymentStatus,
      this.finalPrice,
      this.paymentMethod,
      this.createdAt,
      this.updatedAt,
      this.doctor,
      this.clinic,
      this.appointment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    appointmentId = json['appointment_id'];
    status = json['status'];
    paymentIntentId = json['payment_intent_id'];
    currency = json['currency'];
    paymentStatus = json['payment_status'];
    finalPrice = json['final_price'];
    paymentMethod = json['payment_method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    clinic =
        json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['doctor_id'] = this.doctorId;
    data['clinic_id'] = this.clinicId;
    data['appointment_id'] = this.appointmentId;
    data['status'] = this.status;
    data['payment_intent_id'] = this.paymentIntentId;
    data['currency'] = this.currency;
    data['payment_status'] = this.paymentStatus;
    data['final_price'] = this.finalPrice;
    data['payment_method'] = this.paymentMethod;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    if (this.appointment != null) {
      data['appointment'] = this.appointment!.toJson();
    }
    return data;
  }
}

class Doctor {
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

  Doctor(
      {this.id,
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
      this.createdAt});

  Doctor.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fName'] = this.fName;
    data['lName'] = this.lName;
    data['gender'] = this.gender;
    data['birthDate'] = this.birthDate;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['whatsappLink'] = this.whatsappLink;
    data['facebookLink'] = this.facebookLink;
    data['title'] = this.title;
    data['infoAboutDoctor'] = this.infoAboutDoctor;
    data['app_price'] = this.appPrice;
    data['homeOption'] = this.homeOption;
    data['avg_rate'] = this.avgRate;
    data['email'] = this.email;
    data['role'] = this.role;
    data['department_id'] = this.departmentId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Clinic {
  String? id;
  String? title;
  String? description;
  String? address;
  String? locationUrl;
  String? phone;
  String? createdAt;
  String? updatedAt;

  Clinic(
      {this.id,
      this.title,
      this.description,
      this.address,
      this.locationUrl,
      this.phone,
      this.createdAt,
      this.updatedAt});

  Clinic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    address = json['address'];
    locationUrl = json['locationUrl'];
    phone = json['phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['address'] = this.address;
    data['locationUrl'] = this.locationUrl;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Appointment {
  int? id;
  String? day;
  String? startAt;
  String? endAt;
  int? duration;
  int? isBooked;
  String? doctorId;
  String? clinicId;
  Null createdAt;
  String? updatedAt;

  Appointment(
      {this.id,
      this.day,
      this.startAt,
      this.endAt,
      this.duration,
      this.isBooked,
      this.doctorId,
      this.clinicId,
      this.createdAt,
      this.updatedAt});

  Appointment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    duration = json['duration'];
    isBooked = json['is_booked'];
    doctorId = json['doctor_id'];
    clinicId = json['clinic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['day'] = this.day;
    data['start_at'] = this.startAt;
    data['end_at'] = this.endAt;
    data['duration'] = this.duration;
    data['is_booked'] = this.isBooked;
    data['doctor_id'] = this.doctorId;
    data['clinic_id'] = this.clinicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
