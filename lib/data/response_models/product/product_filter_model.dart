import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';

class ProductFilter {
  ProductFilter({this.categories, this.priceRangeData});

  ProductFilter.fromJson(final Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((final v) {
        categories!.add(new Category.fromJson(v));
      });
    }
    priceRangeData = json['price_range_data'] != null
        ? new PriceRangeData.fromJson(json['price_range_data'])
        : null;
  }
  List<Category>? categories;
  PriceRangeData? priceRangeData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] =
          this.categories!.map((final v) => v.toJson()).toList();
    }
    if (this.priceRangeData != null) {
      data['price_range_data'] = this.priceRangeData!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class PriceRangeData {
  PriceRangeData(
      {this.minPrice, this.maxPrice, this.currencyCode, this.currencySymbol});

  PriceRangeData.fromJson(final Map<String, dynamic> json) {
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    totalMinPrice = json['total_min'];
    totalMaxPrice = json['total_max'];
    currencySymbol = json['currency_symbol'];
    currencyCode = json['currency_code'];
  }
  String? minPrice;
  String? maxPrice;
  String? totalMinPrice;
  String? totalMaxPrice;
  String? currencySymbol;
  String? currencyCode;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['total_min'] = this.totalMinPrice;
    data['total_max'] = this.totalMaxPrice;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_code'] = this.currencyCode;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
