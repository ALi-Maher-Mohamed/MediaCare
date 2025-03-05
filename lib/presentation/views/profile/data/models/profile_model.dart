class UserModel {
  String? id;
  Null googleId;
  Null avatar;
  String? name;
  String? email;
  String? emailVerifiedAt;
  Null verificationTokenExpiresAt;
  String? phone;
  String? address;
  String? birthDate;
  String? role;
  int? points;
  String? lastVisit;
  String? createdAt;
  String? updatedAt;

  UserModel(
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

  UserModel.fromJson(Map<String, dynamic> json) {
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
}
