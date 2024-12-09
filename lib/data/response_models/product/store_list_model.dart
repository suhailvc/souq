import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:get/get.dart';

class StoreModel {
  StoreModel({
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
    this.feeDetail,
    this.howToShop,
    this.cashbackToken,
    this.productList,
  });

  StoreModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    logo = json['logo'];
    backgroundImage = json['background_image'];
    owner = json['owner'] == null ? null : Owner.fromJson(json['owner']);
    categories = json['categories'] == null
        ? <Category>[]
        : List<Category>.from(
            json['categories']!.map(
              (final dynamic x) => Category.fromJson(x),
            ),
          );
    if (categories.isNotNullOrEmpty()) {
      categoriesName = List<String>.from(
        json['categories']!.map(
          (final dynamic x) => Category.fromJson(x).name,
        ),
      );
    }
    productList = json['products'] == null
        ? <ProductDetailsModel>[]
        : List<ProductDetailsModel>.from(
            json['products']!.map(
              (final dynamic x) => ProductDetailsModel.fromJson(x),
            ),
          );
    status = json['status'];
    url = json['url'];
    description = json['description'];
    isFamous = json['is_famous'];
    isPromoted = json['is_promoted'];
    cashbackType = json['cashback_type'];
    cashback = json['cashback'];
    isCashbackEnabled = json['is_cashback_enabled'];
    feeDetail = json['fee_detail'];
    howToShop = json['how_to_shop'] == null
        ? null
        : HowToShop.fromJson(json['how_to_shop']);
    cashbackToken = json['cashback_token'];
    productsCount = json['products_count'];
  }
  int? id;
  String? uuid;
  String? name;
  String? logo;
  String? backgroundImage;
  Owner? owner;
  List<Category>? categories;
  List<String>? categoriesName;
  String? status;
  String? url;
  String? description;
  bool? isFamous;
  bool? isPromoted;
  String? cashbackType;
  double? cashback;
  bool? isCashbackEnabled;
  String? feeDetail;
  HowToShop? howToShop;
  String? cashbackToken;
  int? productsCount;
  List<ProductDetailsModel>? productList;

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
        'products': productList == null
            ? <Category>[]
            : List<dynamic>.from(
                productList!.map((final ProductDetailsModel x) => x.toJson())),
        'status': status,
        'url': url,
        'description': description,
        'is_famous': isFamous,
        'is_promoted': isPromoted,
        'cashback_type': cashbackType,
        'cashback': cashback,
        'is_cashback_enabled': isCashbackEnabled,
        'fee_detail': feeDetail,
        'how_to_shop': howToShop?.toJson(),
        'cashback_token': cashbackToken,
        'products_count': productsCount,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Category {
  Category({
    this.id,
    this.name,
    this.icon,
    this.parentCategory,
    this.subCategory,
    this.arabicName,
  });

  Category.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    arabicName = json['arabic_name'];
    icon = json['icon'];
    parentCategory = json['parent_category'] == null
        ? []
        : List<Category>.from(json['parent_category']!
            .map((final dynamic x) => Category.fromJson(x)));
    subCategory = json['children'] == null
        ? <Category>[]
        : List<Category>.from(
            json['children']!.map((final dynamic x) => Category.fromJson(x)));
  }
  int? id;
  String? name;
  String? icon;
  List<Category>? parentCategory;
  List<Category>? subCategory;
  String? arabicName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'icon': icon,
        'parent_category': parentCategory == null
            ? <Category>[]
            : List<dynamic>.from(
                parentCategory!.map((final Category x) => x.toJson())),
        'children': subCategory == null
            ? <Category>[]
            : List<dynamic>.from(
                subCategory!.map((final Category x) => x.toJson())),
        'arabic_name': arabicName,
      };
  @override
  String toString() {
    return toJson().toString();
  }

  String getName() {
    if (Get.find<SharedPreferenceHelper>().getLanguageCode ==
        AppConstants.arabicLangCode) {
      return arabicName.isNotNullAndEmpty() ? arabicName! : name ?? '-';
    }
    return name ?? '-';
  }
}

class HowToShop {
  HowToShop({
    this.title,
    this.steps,
  });

  HowToShop.fromJson(final Map<String, dynamic> json) {
    title = json['title'];
    steps = json['steps'] == null
        ? <Step>[]
        : List<Step>.from(
            json['steps']!.map(
              (final dynamic x) => Step.fromJson(x),
            ),
          );
  }
  String? title;
  List<Step>? steps;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'steps': steps == null
            ? <Step>[]
            : List<dynamic>.from(
                steps!.map(
                  (final Step x) => x.toJson(),
                ),
              ),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class Step {
  Step({
    this.title,
    this.description,
  });

  Step.fromJson(final Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }
  String? title;
  String? description;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'description': description,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Owner {
  Owner({
    this.id,
    this.firstName,
    this.lastName,
    this.uuid,
  });

  Owner.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    uuid = json['uuid'];
    if (firstName != null && lastName != null) {
      fullName = '${firstName ?? ''} ${lastName ?? ''}';
    }
  }
  int? id;
  String? firstName;
  String? lastName;
  String? uuid;
  String? fullName;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'uuid': uuid,
        'full_name': fullName,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
