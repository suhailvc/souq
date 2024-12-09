import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/driver_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.orderId,
    this.orderStatus,
    this.orderPlacedBy,
    this.orderPlacedByName,
    this.paymentMode,
    this.subtotal,
    this.tax,
    this.discount,
    this.promoDiscount,
    this.total,
    this.items,
    this.created,
    this.currency,
    this.driver,
    this.vendorName,
    this.invoiceUrl,
    this.subOrders,
    this.coverImage,
    this.cancelReason,
  });

  OrderDetailsModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    if (json['order_status'] != null) {
      orderStatus = OrderStatus.values.firstWhereOrNull(
          (final OrderStatus status) => status.value == json['order_status']);
    }
    orderPlacedBy = json['order_placed_by'] == null
        ? null
        : OrderPlacedBy.fromJson(json['order_placed_by']);
    orderPlacedByName = json['order_placed_by_name'];
    paymentMode = json['payment_mode'];
    subtotal = json['subtotal'];
    if (json['old_subtotal'] != null) {
      oldSubTotal = double.parse(json['old_subtotal'].toString());
    }

    tax = json['tax'];
    discount = json['discount'];
    promoDiscount = json['promo_discount'];
    total = json['total'];
    items = json['items'] == null
        ? <OrderedItem>[]
        : List<OrderedItem>.from(json['items']!.map((final dynamic x) =>
            OrderedItem.fromJson(
                x, json['currency'] ?? AppConstants.defaultCurrency)));
    created = json['created'] == null ? null : DateTime.parse(json['created']);
    currency = json['currency'] ?? AppConstants.defaultCurrency;
    driver = json['driver'] == null ? null : Driver.fromJson(json['driver']);
    subOrders = json['sub_orders'] == null
        ? <OrderDetailsModel>[]
        : List<OrderDetailsModel>.from(
            json['sub_orders']!.map(
              (final dynamic subOrder) => OrderDetailsModel.fromJson(subOrder),
            ),
          );
    invoiceUrl = json['download_invoice_url'];
    vendorName = json['vendor_name'];

    billingAddress = json['billing_address'] == null
        ? null
        : OrderBillingAddress.fromJson(json['billing_address']);
    cancelReason = json['cancel_reason'];
    deliveryCharge = json['delivery_charge'];
    extraAmount = json['extra_amount'] == null
        ? null
        : double.parse(json['extra_amount'].toString());
  }
  int? id;
  String? orderId;
  OrderStatus? orderStatus;
  OrderPlacedBy? orderPlacedBy;
  String? orderPlacedByName;
  String? paymentMode;
  String? subtotal;
  double? oldSubTotal;
  String? tax;
  String? discount;
  String? promoDiscount;
  String? total;
  List<OrderedItem>? items;
  DateTime? created;
  String? currency;
  Driver? driver;
  Images? coverImage;
  String? invoiceUrl;

  List<OrderDetailsModel>? subOrders;
  String? vendorName;

  OrderBillingAddress? billingAddress;
  String? cancelReason;

  String? deliveryCharge;
  double? extraAmount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'order_id': orderId,
        'order_status': orderStatus?.value,
        'order_placed_by': orderPlacedBy?.toJson(),
        'order_placed_by_name': orderPlacedByName,
        'payment_mode': paymentMode,
        'subtotal': subtotal,
        'old_subtotal': oldSubTotal.toString(),
        'tax': tax,
        'discount': discount,
        'promo_discount': promoDiscount,
        'total': total,
        'items': items == null
            ? <dynamic>[]
            : List<dynamic>.from(
                items!.map((final OrderedItem x) => x.toJson())),
        'created': created?.toIso8601String(),
        'currency': currency,
        'driver': driver,
        'cover_image': this.coverImage,
        'sub_orders': subOrders == null
            ? <dynamic>[]
            : List<dynamic>.from(subOrders!
                .map((final OrderDetailsModel subOrder) => subOrder.toJson())),
        'download_invoice_url': this.invoiceUrl,
        'vendor_name': vendorName,
        'billing_address': billingAddress?.toJson(),
        'cancel_reason': cancelReason,
        'delivery_charge': deliveryCharge,
        'extra_amount': extraAmount,
      };
  @override
  String toString() {
    return toJson().toString();
  }

  String getStoreName() {
    return items.isNotNullOrEmpty()
        ? (items?.first.metadata?.storeName ?? '')
        : '';
  }

  OrderedItem? getFirstItemFromSubOrders() {
    return ((subOrders ?? <OrderDetailsModel>[]).isNotEmpty)
        ? ((subOrders?.first.items ?? <OrderedItem>[]).isNotEmpty
            ? subOrders?.first.items?.first
            : null)
        : null;
  }

  int getItemCountFromSubOrders() {
    int items = 0;
    for (int i = 0; i < (subOrders ?? <OrderDetailsModel>[]).length; i++) {
      final OrderDetailsModel? subOrder = subOrders?[i];

      items += (subOrder?.items ?? <OrderedItem>[]).length;
    }

    return items;
  }

  OrderedItem? getFirstItemFromItems() {
    return ((items ?? <OrderDetailsModel>[]).isNotEmpty) ? items?.first : null;
  }

  String getSubTotalWithCurrency() {
    final double newPrice = double.parse(subtotal ?? '0.00');
    final double oldPrice = oldSubTotal ?? 0;
    final double finalPrice = (extraAmount ?? 0) > 0 ? oldPrice : newPrice;
    return '${finalPrice.toStringAsFixed(2)} $currency';
  }

  String getOrderTaxWithCurrency() {
    final double newPrice = double.parse(tax ?? '0.00');
    return '${newPrice.toStringAsFixed(2)} $currency ';
  }

  String getOrderDiscountWithCurrency() {
    final double newPrice = double.parse(discount ?? '0.00');
    return '${newPrice.toStringAsFixed(2)} $currency ';
  }

  String getOrderPromoDiscountWithCurrency() {
    final double newPrice = double.parse(promoDiscount ?? '0.00');
    return '${newPrice.toStringAsFixed(2)} $currency';
  }

  String getOrderDeliverChargeWithCurrency() {
    final double newPrice = double.parse(deliveryCharge ?? '0.00');
    return '${newPrice.toStringAsFixed(2)} $currency ';
  }

  String getOrderTotalWithCurrency() {
    final double newPrice = double.parse(total ?? '0.00');
    return '${newPrice.toStringAsFixed(2)} $currency';
  }

  String getExtraAmountWithCurrency() {
    return '${(extraAmount ?? 0.00).toStringAsFixed(2)} $currency';
  }
}

class OrderedItem {
  OrderedItem({
    this.id,
    this.product,
    this.qty,
    this.price,
    this.metadata,
  });

  OrderedItem.fromJson(final Map<String, dynamic> json, final String currency) {
    id = json['id'];
    product = json['product'] == null
        ? null
        : ProductDetailsModel.fromJson(json['product']);
    qty = json['qty'];
    price = json['price'];
    metadata =
        json['metadata'] == null ? null : Metadata.fromJson(json['metadata']);
    this.currency = currency;
    size =
        json['size'] == null ? null : ProductSizeModel.fromJson(json['size']);
  }
  int? id;
  ProductDetailsModel? product;
  int? qty;
  String? price;
  Metadata? metadata;
  // this parameter not coming from server, managed manually
  String? currency;
  ProductSizeModel? size;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'product': product?.toJson(),
        'qty': qty,
        'price': price,
        'metadata': metadata?.toJson(),
        'size': size?.toJson(),
      };
  @override
  String toString() {
    return toJson().toString();
  }

  String getTotalProductPrice() {
    return '${double.parse((price ?? ' 0.00')).toStringAsFixed(2)} $currency';
  }

  String getProductPriceWithoutOffer() {
    return '${(metadata?.productPrice ?? 0.00).toStringAsFixed(2)} $currency ';
  }

  String getProductPrice() {
    if (size != null) {
      final double? price = double.tryParse(size?.price ?? '0.00');
      return '${(price ?? 0.00).toStringAsFixed(2)} $currency';
    }
    final double? price = (metadata?.offerPrice ?? 0.0) > 0
        ? metadata?.offerPrice
        : metadata?.productPrice;
    return '${(price ?? 0.00).toStringAsFixed(2)} $currency';
  }

  String getVendorProductName() {
    final String name = metadata?.productName ?? '';
    final ProductSizeModel? size = this.size;
    if (size != null) {
      return name + ' (${size.unit}) ';
    }
    return metadata?.productName ?? '';
  }
}

class Metadata {
  Metadata({this.productName, this.productPrice});

  Metadata.fromJson(final Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    offerPrice = json['offer_price'];
    storeName = json['store_name'];
  }
  String? productName;
  double? productPrice;
  double? offerPrice;
  String? storeName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'product_name': productName,
        'product_price': productPrice,
        'offer_price': offerPrice,
        'store_name': storeName,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class OrderPlacedBy {
  OrderPlacedBy({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.profileImage,
    this.uuid,
  });

  OrderPlacedBy.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    profileImage = json['profile_image'];
    uuid = json['uuid'];
    fullName = '${firstName ?? ''} ${lastName ?? ''}';
  }
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? profileImage;
  String? uuid;
  String? fullName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'contact_number': contactNumber,
        'profile_image': profileImage,
        'uuid': uuid,
        'full_name': fullName,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class OrderBillingAddress {
  OrderBillingAddress(
      {this.line1,
      this.line2,
      this.line3,
      this.landmark,
      this.postalCode,
      this.cityName,
      this.cityRegion,
      this.countryName});

  OrderBillingAddress.fromJson(final Map<String, dynamic> json) {
    line1 = json['line1'];
    line2 = json['line2'];
    line3 = json['line3'];
    landmark = json['landmark'];
    postalCode = json['postal_code'];
    cityName = json['city_name'];
    cityRegion = json['city_region'];
    countryName = json['country_name'];

    fullAddress = <String>[];
    if ((line1 ?? '').trim().isNotEmpty) {
      fullAddress?.add(line1!);
    }

    if ((line2 ?? '').trim().isNotEmpty) {
      fullAddress?.add(line2!);
    }
    if ((line3 ?? '').trim().isNotEmpty) {
      fullAddress?.add(line3!);
    }

    if ((landmark ?? '').trim().isNotEmpty) {
      fullAddress?.add(landmark!);
    }

    if ((cityName ?? '').trim().isNotEmpty) {
      fullAddress?.add(cityName ?? '');
    }

    if ((cityRegion ?? '').trim().isNotEmpty) {
      fullAddress?.add(cityRegion ?? '');
    }
    if ((countryName ?? '').trim().isNotEmpty) {
      if (!(cityRegion ?? '').contains(countryName ?? '')) {
        fullAddress?.add(countryName ?? '');
      }
    }

    if (postalCode != null) {
      fullAddress?.add(postalCode.toString());
    }
  }
  String? line1;
  String? line2;
  String? line3;
  String? landmark;
  int? postalCode;
  String? cityName;
  String? cityRegion;
  String? countryName;
  // this is not coming from server
  List<String>? fullAddress;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'line1': line1,
        'line2': line2,
        'line3': line3,
        'landmark': landmark,
        'postal_code': postalCode,
        'city_name': cityName,
        'city_region': cityRegion,
        'country_name': countryName,
      };

  @override
  String toString() {
    return toJson().toString();
  }

  String getFullAddress() {
    return fullAddress?.join(', ') ?? '';
  }
}
