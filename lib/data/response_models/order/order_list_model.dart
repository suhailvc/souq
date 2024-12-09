import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';

class OrderListModel {
  OrderListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  OrderListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] == null
        ? <OrderDetailsModel>[]
        : List<OrderDetailsModel>.from(json['results']!
            .map((final dynamic x) => OrderDetailsModel.fromJson(x)));
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<OrderDetailsModel>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <OrderDetailsModel>[]
            : List<dynamic>.from(
                results!.map((final OrderDetailsModel x) => x.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
