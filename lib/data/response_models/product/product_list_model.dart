import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';

class ProductListModel {
  ProductListModel({this.count, this.next, this.previous, this.results});

  ProductListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <ProductDetailsModel>[];
      json['results'].forEach((final dynamic v) {
        results!.add(new ProductDetailsModel.fromJson(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<ProductDetailsModel>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this
          .results!
          .map((final ProductDetailsModel v) => v.toJson())
          .toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Images {
  Images({this.id, this.name, this.image, this.isCoverImage});

  Images.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    isCoverImage = json['is_cover_image'];
  }
  int? id;
  String? name;
  String? image;
  bool? isCoverImage;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['is_cover_image'] = this.isCoverImage;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
