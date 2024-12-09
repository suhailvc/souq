import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';

class CommonStoreModel {
  CommonStoreModel({this.count, this.next, this.previous, this.results});

  CommonStoreModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <StoreModel>[];
      json['results'].forEach((final dynamic v) {
        results!.add(
          new StoreModel.fromJson(v),
        );
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<StoreModel>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] =
          this.results!.map((final StoreModel v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
