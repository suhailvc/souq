import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';

class InvoiceListModel {
  InvoiceListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  InvoiceListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] == null
        ? <Invoice>[]
        : List<Invoice>.from(
            json['results']!.map(
              (final dynamic result) => Invoice.fromJson(result),
            ),
          );
  }
  int? count;
  String? next;
  String? previous;
  List<Invoice>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(
                results!.map((final Invoice invoice) => invoice.toJson())),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Invoice {
  Invoice.fromJson(final Map<String, dynamic> json) {
    orderId = json['order_id'];
    paymentMode = json['payment_mode'];
    paymentStatus = json['payment_status'];
    created = json['created'] == null ? null : DateTime.parse(json['created']);
    if (json['order_status'] != null) {
      orderStatus = OrderStatus.values.firstWhereOrNull(
          (final OrderStatus status) => status.value == json['order_status']);
    }
    downloadInvoiceUrl = json['download_invoice_url'];
  }

  Invoice({
    this.orderId,
    this.paymentMode,
    this.paymentStatus,
    this.created,
    this.orderStatus,
    this.downloadInvoiceUrl,
  });
  String? orderId;
  String? paymentMode;
  String? paymentStatus;
  DateTime? created;
  OrderStatus? orderStatus;
  String? downloadInvoiceUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'order_id': orderId,
        'payment_mode': paymentMode,
        'payment_status': paymentStatus,
        'created': created?.toIso8601String(),
        'order_status': orderStatus?.value,
        'download_invoice_url': downloadInvoiceUrl,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
