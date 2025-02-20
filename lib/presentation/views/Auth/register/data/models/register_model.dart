class RegisterModel {
  String? message;
  User? user;
  String? token;

  RegisterModel({this.message, this.user, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  String? name;
  String? email;
  String? phone;
  String? address;
  String? birthDate;
  String? id;
  String? updatedAt;
  String? createdAt;

  User(
      {this.name,
        this.email,
        this.phone,
        this.address,
        this.birthDate,
        this.id,
        this.updatedAt,
        this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    birthDate = json['birth_date'];
    id = json['id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['birth_date'] = this.birthDate;
    data['id'] = this.id;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
