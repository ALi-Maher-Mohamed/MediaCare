class HospitalModel {
  bool? success;
  String? message;
  List<Data>? data;

  HospitalModel({this.success, this.message, this.data});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? service;
  Null? image;
  String? phone;
  String? address;
  String? locationUrl;

  Data(
      {this.id,
        this.title,
        this.service,
        this.image,
        this.phone,
        this.address,
        this.locationUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    service = json['service'];
    image = json['image'];
    phone = json['phone'];
    address = json['address'];
    locationUrl = json['locationUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['service'] = this.service;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['locationUrl'] = this.locationUrl;
    return data;
  }
}