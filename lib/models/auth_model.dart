class AuthModel {
  String? message;
  bool? status;
  User? user;

  AuthModel({this.message, this.status, this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? emailOtp;
  String? roleName;
  String? createdAt;
  String? updatedAt;
  String? token;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.emailOtp,
      this.roleName,
      this.createdAt,
      this.updatedAt,
      this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    emailOtp = json['email_otp'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['email_otp'] = emailOtp;
    data['role_name'] = roleName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['token'] = token;
    return data;
  }
}
