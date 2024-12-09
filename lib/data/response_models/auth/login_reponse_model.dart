import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';

class LoginUserResponse {
  LoginUserResponse({this.expiry, this.token, this.user});

  LoginUserResponse.fromJson(final Map<String, dynamic> json) {
    expiry = json['expiry'];
    token = json['token'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
  String? expiry;
  String? token;
  UserModel? user;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['expiry'] = expiry;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
