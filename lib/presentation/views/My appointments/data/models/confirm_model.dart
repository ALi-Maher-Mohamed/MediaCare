class ConfirmModel {
  String? message;
  Data? data;

  ConfirmModel({this.message, this.data});

  ConfirmModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
      this.updatedAt});

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
    return data;
  }
}
