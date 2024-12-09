import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';

class UserResponseModel {
  UserResponseModel({this.count, this.next, this.previous, this.results});

  UserResponseModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <UserModel>[];
      json['results'].forEach((final dynamic v) {
        results!.add(UserModel.fromJson(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<UserModel>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] =
          this.results!.map((final UserModel v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
