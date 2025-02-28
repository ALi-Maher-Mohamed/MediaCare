class LoginModel {
  String? message;
  String? accessToken;
  int? points;
  String? lastVisit;
  User? user;

  LoginModel(
      {this.message, this.accessToken, this.points, this.lastVisit, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    points = json['points'];
    lastVisit = json['last_visit'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['access_token'] = this.accessToken;
    data['points'] = this.points;
    data['last_visit'] = this.lastVisit;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  Null? googleId;
  Null? avatar;
  String? name;
  String? email;
  String? emailVerifiedAt;
  Null? verificationTokenExpiresAt;
  String? phone;
  String? address;
  String? birthDate;
  String? role;
  int? points;
  String? lastVisit;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
        this.googleId,
        this.avatar,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.verificationTokenExpiresAt,
        this.phone,
        this.address,
        this.birthDate,
        this.role,
        this.points,
        this.lastVisit,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleId = json['google_id'];
    avatar = json['avatar'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    verificationTokenExpiresAt = json['verification_token_expires_at'];
    phone = json['phone'];
    address = json['address'];
    birthDate = json['birth_date'];
    role = json['role'];
    points = json['points'];
    lastVisit = json['last_visit'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['google_id'] = this.googleId;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['verification_token_expires_at'] = this.verificationTokenExpiresAt;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['birth_date'] = this.birthDate;
    data['role'] = this.role;
    data['points'] = this.points;
    data['last_visit'] = this.lastVisit;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}