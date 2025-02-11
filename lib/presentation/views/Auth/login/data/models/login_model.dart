class LoginModel {
  final String email;
  final String password;
  final Data? data;
  final int statusCode;

  LoginModel({
    required this.email,
    required this.password,
    this.data,
    required this.statusCode,
  });
}

class Data {
  final String token;

  Data({
    required this.token,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
    );
  }
}
