import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';

class InventoryListResponseModel {
  InventoryListResponseModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  factory InventoryListResponseModel.fromJson(
          final Map<String, dynamic> json) =>
      InventoryListResponseModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'] == null
            ? <StoreModel>[]
            : List<StoreModel>.from(
                json['results']!.map(
                  (final dynamic x) => StoreModel.fromJson(x),
                ),
              ),
      );
  int? count;
  dynamic next;
  dynamic previous;
  List<StoreModel>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <StoreModel>[]
            : List<dynamic>.from(
                results!.map(
                  (final StoreModel x) => x.toJson(),
                ),
              ),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
