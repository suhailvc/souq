import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:get/get.dart';

class ProductDetailsModel {
  ProductDetailsModel({
    this.id,
    this.title,
    this.description,
    this.owner,
    this.quantity,
    this.minimumOrderAmount,
    this.price,
    this.uuid,
    this.status,
    this.images,
    this.category,
    this.subCategory,
    this.storeName,
    this.storeUuid,
    this.isActive,
    this.coverImage,
    this.offerPrice,
    this.offerValidTill,
    this.rejectedReason,
    this.arabicTitle,
    this.arabicDescription,
    this.brand,
    this.barcode,
    this.sizeData,
  });

  ProductDetailsModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['owner'] != null) {
      if (json['owner'] is int) {
        owner = Owner(id: json['owner']);
      } else {
        owner = new Owner.fromJson(json['owner']);
      }
    }

    quantity = json['quantity'];
    minimumOrderAmount = Parsing.doubleFrom(json['minimum_order_amount']);
    minimumOrderQuantity = Parsing.intFrom(json['minimum_order_quantity']);
    price = json['price'];
    uuid = json['uuid'];

    if (json['status'] != null) {
      status = ProductApprovalStatus.values.firstWhereOrNull(
              (final ProductApprovalStatus statusTemp) =>
                  statusTemp.key == json['status']!) ??
          ProductApprovalStatus.inReview;
    } else {
      status = ProductApprovalStatus.inReview;
    }
    currency = json['currency'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((final dynamic v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['category'] != null) {
      if (json['category'] is int) {
        category = Category(id: json['category']);
      } else {
        category = Category.fromJson(json['category']);
      }
    }
    if (json['sub_category'] != null) {
      if (json['sub_category'] is int) {
        subCategory = Category(id: json['sub_category']);
      } else {
        subCategory = Category.fromJson(json['sub_category']);
      }
    }
    storeName = json['store_name'];
    storeUuid = json['store_uuid'];
    isActive = json['is_active'];
    offerPrice = json['offer_price'];
    offerValidTill = json['offer_valid_till'];
    coverImage = images?.firstWhereOrNull(
            (final Images image) => image.isCoverImage == true) ??
        ((images ?? <Images>[]).isNotEmpty ? images!.first : null);
    rejectedReason = json['rejected_reason'];
    arabicTitle = json['arabic_title'];
    arabicDescription = json['arabic_description'];
    if (json['brand'] != null) {
      brand = new Brand.fromJson(json['brand']);
    }
    if (json['barcode'] != null) barcode = json['barcode'].toString();

    if (json['size_data'] != null) {
      sizeData = <ProductSizeModel>[];
      json['size_data'].forEach((final dynamic data) {
        sizeData!.add(new ProductSizeModel.fromJson(data));
      });
    }
  }
  int? id;
  String? title;
  String? description;
  Owner? owner;
  int? quantity;
  double? minimumOrderAmount;
  int? minimumOrderQuantity;
  String? price;
  String? uuid;
  ProductApprovalStatus? status;
  String? currency;
  List<Images>? images;
  Category? category;
  Category? subCategory;
  String? storeName;
  String? storeUuid;
  bool? isActive;
  Images? coverImage;
  double? offerPrice;
  String? offerValidTill;
  String? rejectedReason;
  String? arabicTitle;
  String? arabicDescription;
  Brand? brand;
  String? barcode;
  List<ProductSizeModel>? sizeData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['owner'] = this.owner!.toJson();
    data['quantity'] = this.quantity;
    data['minimum_order_amount'] = this.minimumOrderAmount;
    data['minimum_order_quantity'] = this.minimumOrderQuantity;
    data['price'] = this.price;
    data['uuid'] = this.uuid;
    data['status'] = this.status?.key ?? '';
    data['currency'] = this.currency;
    if (this.images != null) {
      data['images'] =
          this.images!.map((final Images v) => v.toJson()).toList();
    }
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['category'] = this.category?.toJson();
    data['sub_category'] = this.subCategory?.toJson();
    data['store_name'] = this.storeName;
    data['store_uuid'] = this.storeUuid;
    data['is_active'] = this.isActive;
    data['cover_image'] = this.coverImage;
    data['offer_price'] = this.offerPrice;
    data['offer_valid_till'] = this.offerValidTill;
    data['rejected_reason'] = this.rejectedReason;
    data['arabic_title'] = this.arabicTitle;
    data['arabic_description'] = this.arabicDescription;
    data['brand'] = this.brand?.toJson();
    data['barcode'] = this.barcode;
    if (this.sizeData != null) {
      data['size_data'] = this
          .sizeData!
          .map((final ProductSizeModel data) => data.toJson())
          .toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }

  String getProductTitle() {
    if (Get.find<SharedPreferenceHelper>().getLanguageCode ==
        AppConstants.arabicLangCode) {
      return arabicTitle.isNotNullAndEmpty() ? arabicTitle! : title ?? '-';
    }
    return title ?? '-';
  }

  String getProductDescription() {
    if (Get.find<SharedPreferenceHelper>().getLanguageCode ==
        AppConstants.arabicLangCode) {
      return arabicDescription.isNotNullAndEmpty()
          ? arabicDescription!
          : description ?? '-';
    }
    return description ?? '-';
  }

  String getPrice() {
    final String newPrice =
        (offerPrice ?? double.parse(this.price ?? '0.00')).toStringAsFixed(2);
    return '$newPrice ${currency ?? AppConstants.defaultCurrency}';
  }

  String getActualPrice() {
    return '${price ?? '0.00'} ${currency ?? AppConstants.defaultCurrency}';
  }

  String getMinimumOrderAmount() {
    return '${minimumOrderAmount ?? '0.00'} ${currency ?? AppConstants.defaultCurrency}';
  }
}
