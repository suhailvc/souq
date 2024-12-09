import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:get/get.dart';

class InventoryDetailsModel {
  InventoryDetailsModel({
    this.id,
    this.uuid,
    this.name,
    this.logo,
    this.backgroundImage,
    this.owner,
    this.categories,
    this.status,
    this.url,
    this.description,
    this.isFamous,
    this.isPromoted,
    this.cashbackType,
    this.cashback,
    this.isCashbackEnabled,
    this.productsCount,
    this.feeDetail,
    this.howToShop,
    this.cashbackToken,
    this.ordersCount,
    this.products,
  });

  InventoryDetailsModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    logo = json['logo'];
    backgroundImage = json['background_image'];
    owner = json['owner'] == null ? null : Owner.fromJson(json['owner']);
    categories = json['categories'] == null
        ? <Category>[]
        : List<Category>.from(
            json['categories']!.map((final x) => Category.fromJson(x)));
    if (json['status'] != null) {
      status = ProductApprovalStatus.values.firstWhereOrNull(
              (final ProductApprovalStatus statusTemp) =>
                  statusTemp.key == json['status']!) ??
          ProductApprovalStatus.inReview;
    } else {
      status = ProductApprovalStatus.inReview;
    }
    url = json['url'];
    description = json['description'];
    isFamous = json['is_famous'];
    isPromoted = json['is_promoted'];
    cashbackType = json['cashback_type'];
    cashback = json['cashback'];
    isCashbackEnabled = json['is_cashback_enabled'];
    productsCount = json['products_count'];
    feeDetail = json['fee_detail'];
    howToShop = json['how_to_shop'] == null
        ? null
        : HowToShop.fromJson(json['how_to_shop']);
    cashbackToken = json['cashback_token'];
    ordersCount = json['orders_count'];
    products = json['products'] == null
        ? <InventoryProduct>[]
        : List<InventoryProduct>.from(
            json['products']!.map((final x) => InventoryProduct.fromJson(x)));
  }
  int? id;
  String? uuid;
  String? name;
  String? logo;
  String? backgroundImage;
  Owner? owner;
  List<Category>? categories;
  ProductApprovalStatus? status;
  String? url;
  String? description;
  bool? isFamous;
  bool? isPromoted;
  String? cashbackType;
  double? cashback;
  bool? isCashbackEnabled;
  int? productsCount;
  String? feeDetail;
  HowToShop? howToShop;
  String? cashbackToken;
  int? ordersCount;
  List<InventoryProduct>? products;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'uuid': uuid,
        'name': name,
        'logo': logo,
        'background_image': backgroundImage,
        'owner': owner?.toJson(),
        'categories': categories == null
            ? <Category>[]
            : List<dynamic>.from(
                categories!.map((final Category x) => x.toJson())),
        'status': status?.key,
        'url': url,
        'description': description,
        'is_famous': isFamous,
        'is_promoted': isPromoted,
        'cashback_type': cashbackType,
        'cashback': cashback,
        'is_cashback_enabled': isCashbackEnabled,
        'products_count': productsCount,
        'fee_detail': feeDetail,
        'how_to_shop': howToShop?.toJson(),
        'cashback_token': cashbackToken,
        'orders_count': ordersCount,
        'products': products == null
            ? <InventoryProduct>[]
            : List<dynamic>.from(
                products!.map((final InventoryProduct x) => x.toJson())),
      };
}

class InventoryProduct {
  InventoryProduct({
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
    this.currency,
    this.isActive,
    this.coverImage,
  });

  InventoryProduct.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    owner = json['owner'] == null ? null : Owner.fromJson(json['owner']);
    quantity = json['quantity'];
    minimumOrderAmount = json['minimum_order_amount'].toString();
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
    images = json['images'] == null
        ? <Images>[]
        : List<Images>.from(
            json['images']!.map((final dynamic x) => Images.fromJson(x)));
    currency = json['currency'];
    isActive = json['is_active'];
    coverImage = images?.firstWhereOrNull(
            (final Images image) => image.isCoverImage == true) ??
        ((images ?? <Images>[]).isNotEmpty ? images!.first : null);
  }
  int? id;
  String? title;
  String? description;
  Owner? owner;
  int? quantity;
  String? minimumOrderAmount;
  String? price;
  String? uuid;
  ProductApprovalStatus? status;
  List<Images>? images;
  String? currency;
  bool? isActive;
  Images? coverImage;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'owner': owner?.toJson(),
        'quantity': quantity,
        'minimum_order_amount': minimumOrderAmount,
        'price': price,
        'uuid': uuid,
        'status': status?.key,
        'images': images == null
            ? <Images>[]
            : List<dynamic>.from(images!.map((final Images x) => x.toJson())),
        'currency': currency,
        'is_active': isActive,
        'cover_image': coverImage
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
