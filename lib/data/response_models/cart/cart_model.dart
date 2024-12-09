import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';

class CartModel {
  CartModel({this.count, this.next, this.previous, this.results});

  CartModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((final v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] =
          this.results!.map((final Results v) => v.toJson()).toList();
    }
    return data;
  }

  int getCartId() {
    return results.isNotNullOrEmpty() ? (results!.first.id ?? 0) : 0;
  }

  String getCurrency() {
    return results.isNotNullOrEmpty()
        ? results!.first.currency ?? AppConstants.defaultCurrency
        : AppConstants.defaultCurrency;
  }

  String getTotalPriceWithCurrency() {
    final double price =
        results.isNotNullOrEmpty() ? (results!.first.totalPrice ?? 0.00) : 0.00;

    return '${price.toStringAsFixed(2)} ${getCurrency()}';
  }

  String getOfferPriceWithCurrency() {
    final double price = results.isNotNullOrEmpty()
        ? (results!.first.totalPriceWithOffer ?? 0.00)
        : 0.00;
    return '${price.toStringAsFixed(2)} ${getCurrency()}';
  }

  String getDiscountedPriceWithCurrency() {
    final double price = results.isNotNullOrEmpty()
        ? (results!.first.totalDiscount ?? 0.00)
        : 0.00;

    return '${price.toStringAsFixed(2)} ${getCurrency()}';
  }

  String getTaxAmountWithCurrency() {
    final double price =
        results.isNotNullOrEmpty() ? (results!.first.taxes ?? 0.00) : 0.00;

    return '${price.toStringAsFixed(2)} ${getCurrency()}';
  }

  String getDeliveryChargesWithCurrency() {
    final double price = results.isNotNullOrEmpty()
        ? (results!.first.totalDeliveryCharges ?? 0.00)
        : 0.00;
    return '${price.toStringAsFixed(2)} ${getCurrency()}';
  }

  String getTotalPriceToPay() {
    return getOfferPriceWithCurrency().isNotNullAndEmpty()
        ? getOfferPriceWithCurrency()
        : getTotalPriceWithCurrency();
  }

  int getTotalCartItems() {
    return results.isNotNullOrEmpty() ? (results!.first.totalItems ?? 0) : 0;
  }

  List<VendorModel> getVendorModel() {
    return results.isNotNullOrEmpty()
        ? (results!.first.vendorModel ?? <VendorModel>[])
        : <VendorModel>[];
  }
}

class Results {
  Results(
      {this.id,
      this.user,
      this.currency,
      this.status,
      this.totalItems,
      this.totalPrice,
      this.vendorModel,
      this.totalDeliveryCharges,
      this.totalDiscount});

  Results.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    currency = json['currency'] ?? AppConstants.defaultCurrency;
    status = json['status'];
    totalItems = json['total_items'];
    totalPrice = Parsing.doubleFrom(json['total_price']);
    totalPriceWithOffer = Parsing.doubleFrom(json['total_price_with_offer']);
    totalDeliveryCharges = Parsing.doubleFrom(json['total_delivery_charges']);
    taxes = Parsing.doubleFrom(json['taxes']);
    if (json['items'] != null) {
      vendorModel = <VendorModel>[];
      json['items'].forEach((final dynamic items) {
        vendorModel!.add(VendorModel.fromJson(items, currency!));
      });
    }
    totalDiscount = Parsing.doubleFrom(json['total_discount']);
  }
  int? id;
  int? user;
  String? currency;
  String? status;
  int? totalItems;
  double? totalPrice;
  double? totalPriceWithOffer;
  double? totalDeliveryCharges;
  double? taxes;
  double? totalDiscount;
  List<VendorModel>? vendorModel;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['currency'] = this.currency;
    data['status'] = this.status;
    data['total_items'] = this.totalItems;
    data['total_price'] = this.totalPrice.toString();
    data['total_price_with_offer'] = this.totalPriceWithOffer.toString();
    data['total_delivery_charges'] = this.totalDeliveryCharges.toString();
    data['taxes'] = this.taxes.toString();
    if (this.vendorModel != null) {
      data['items'] =
          this.vendorModel!.map((final VendorModel v) => v.toJson()).toList();
    }
    data['total_discount'] = this.totalDiscount.toString();
    return data;
  }
}

class VendorModel {
  VendorModel(
      {this.vendorName,
      this.items,
      this.minOrderAmt,
      this.deliveryCharges,
      this.storeName,
      this.currency});

  VendorModel.fromJson(final Map<String, dynamic> json, final String currency) {
    vendorName = json['vendor_name'];
    minOrderAmt = Parsing.doubleFrom(json['min_order_amt']);
    deliveryCharges = Parsing.doubleFrom(json['delivery_charge']);
    storeName = json['store_name'];
    this.currency = currency;
    if (json['items'] != null) {
      items = <ProductItem>[];
      json['items'].forEach((final dynamic v) {
        items!.add(ProductItem.fromJson(v, currency));
      });
    }
  }
  String? vendorName;
  String? storeName;
  double? minOrderAmt;
  double? deliveryCharges;
  List<ProductItem>? items;
  // this is local variable not getting from server
  String? currency;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_name'] = this.vendorName;
    data['store_name'] = this.storeName;
    data['min_order_amt'] = this.minOrderAmt;
    data['delivery_charge'] = this.deliveryCharges;
    if (this.items != null) {
      data['items'] =
          this.items!.map((final ProductItem v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItem {
  ProductItem({
    this.id,
    this.product,
    this.qty,
    this.created,
    this.totalPrice,
    this.deliveryCharges,
    this.totalPriceWithOffer,
    this.currency,
  });

  ProductItem.fromJson(final Map<String, dynamic> json, final String currency) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    qty = json['qty'];
    created = json['created'];
    totalPrice = Parsing.doubleFrom(json['total_price']);
    totalPriceWithOffer = Parsing.doubleFrom(json['total_price_with_offer']);
    deliveryCharges = Parsing.doubleFrom(json['delivery_charges']);
    this.currency = currency;
    size =
        json['size'] != null ? ProductSizeModel.fromJson(json['size']) : null;
  }
  int? id;
  Product? product;
  int? qty;
  String? created;
  double? totalPrice;
  double? totalPriceWithOffer;
  double? deliveryCharges;
  // this is local variable not getting from server
  String? currency;
  ProductSizeModel? size;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['qty'] = this.qty;
    data['created'] = this.created;
    data['total_price'] = this.totalPrice;
    data['total_price_with_offer'] = this.totalPrice;
    data['delivery_charges'] = this.deliveryCharges;
    if (this.size != null) {
      data['size'] = this.size!.toJson();
    }
    return data;
  }

  String getProductMainPrice() {
    final String price = (totalPrice ?? 0.0).toStringAsFixed(2);
    return '$price $currency';
  }

  String getProductPrice() {
    final String price =
        (totalPriceWithOffer ?? totalPrice ?? 0.0).toStringAsFixed(2);
    return '$price $currency';
  }
}

class Product {
  Product({this.id, this.title, this.quantity, this.minimumOrderQuantity});

  Product.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    quantity = json['quantity'];
    minimumOrderQuantity = json['minimum_order_quantity'];
  }
  int? id;
  int? quantity;
  int? minimumOrderQuantity;
  String? title;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['minimum_order_quantity'] = this.minimumOrderQuantity;
    return data;
  }
}
