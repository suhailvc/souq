import 'package:atobuy_vendor_flutter/controller/product/search/search_product_list_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/purhcase/cart_item_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/qty_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseProductDetailsController extends GetxController {
  PurchaseProductDetailsController({
    required this.productRepo,
  });
  final ProductRepo productRepo;
  String productUUID = '';
  String productID = '';
  ProductDetailsModel? productDetails;
  List<ProductDetailsModel> arrSimilarProducts = <ProductDetailsModel>[];

  int itemQty = 1;
  bool isIncrementEnable = true;
  bool isDecrementEnable = false;
  bool isLoading = true;
  ProductSizeModel? selectedSize;

  @override
  void onInit() {
    super.onInit();
    debugPrint('onInit');
    initialise();
  }

  void initialise() {
    productUUID = '';
    productDetails = null;
    if (Get.arguments != null) {
      if (Get.arguments['uuid'] != null) {
        productUUID = Get.arguments['uuid'];
      }
    }
    if (Get.arguments != null) {
      if (Get.arguments['product_id'] != null) {
        productID = Get.arguments['product_id'].toString();
      }
    }
    if (productUUID.isNotEmpty && productID.isNotEmpty) {
      getProductDetails();
    }
    getMoreProductList(page: 1);
  }

  Future<void> refreshDetails() async {
    if (productUUID.isNotEmpty && productID.isNotEmpty) {
      getProductDetails();
    }
    getMoreProductList(page: 1);
  }

  Future<void> getProductDetails() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final Map<String, dynamic> queryParams = <String, dynamic>{
        if (productID.isNotNullAndEmpty()) 'id': productID
      };
      Loader.load(true);
      await productRepo
          .getProductDetails(
              productUUID: productUUID.toString(), params: queryParams)
          .then((final ProductDetailsModel value) {
        Loader.load(false);
        productDetails = value;
        if ((productDetails?.images ?? <Images>[]).isNotEmpty) {
          if ((productDetails?.images ?? <Images>[]).length > 1) {
            if (productDetails?.coverImage != null) {
              productDetails?.images?.removeWhere(
                  (final Images image) => image.isCoverImage == true);
              productDetails?.images?.insert(0, productDetails!.coverImage!);
            }
          }
        }

        itemQty = productDetails?.minimumOrderQuantity ?? 1;
        if (itemQty == (productDetails?.quantity ?? 0)) {
          isIncrementEnable = false;
        }
        isLoading = false;
        update();
      });
    } catch (e) {
      Loader.load(false);
      isLoading = false;
      update();
      if (Get.previousRoute == RouteHelper.searchProductList) {
        Get.find<SearchProductListController>().applyFilterRefresh();
      } else if (Get.previousRoute == RouteHelper.storeProductList) {
        Get.find<StoreProductController>().refreshStoreProductList();
      }
    }
  }

  void onTapIncreaseQty() {
    if (selectedSize != null) {
      itemQty = itemQty + 1;
      isDecrementEnable = true;
      update();
      return;
    }

    if (itemQty < (productDetails?.quantity ?? 0)) {
      itemQty = itemQty + 1;
      isDecrementEnable = true;
      if (itemQty == (productDetails?.quantity ?? 0)) {
        isIncrementEnable = false;
        showCustomSnackBar(message: 'Maximum quantity reached'.tr);
      }
      update();
    } else {
      isIncrementEnable = false;
      update();
    }
  }

  void onTapDecreaseQty() {
    if (selectedSize != null) {
      itemQty = itemQty - 1;
      if (itemQty == 1) {
        isDecrementEnable = false;
      }
      update();
      return;
    }

    if (itemQty > (productDetails?.minimumOrderQuantity ?? 1)) {
      isIncrementEnable = true;
      itemQty = itemQty - 1;
      if (itemQty == (productDetails?.minimumOrderQuantity ?? 1)) {
        isDecrementEnable = false;
      }
      update();
    }
  }

  String getTotalPrice() {
    if (selectedSize != null) {
      final double productPrice = double.parse(selectedSize?.price ?? '0.0');
      final String total = (productPrice * itemQty).toStringAsFixed(2);
      return '$total ${productDetails?.currency ?? AppConstants.defaultCurrency}';
    }
    final double productPrice = productDetails?.offerPrice ??
        double.parse(productDetails?.price ?? '0.0');
    final String total = (productPrice * itemQty).toStringAsFixed(2);
    return '$total ${productDetails?.currency ?? AppConstants.defaultCurrency}';
  }

  Future<void> getMoreProductList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final Map<String, dynamic> params = <String, dynamic>{
        'page': page,
        'ordering': SortOptions.newestFirst.value,
      };
      final ProductListModel value = await productRepo.getVendorsProduct(
          params: params, productUUID: productUUID);
      arrSimilarProducts = value.results ?? <ProductDetailsModel>[];
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addProductsToCart() async {
    if (!Get.find<SharedPreferenceHelper>().isLoggedIn) {
      Get.toNamed(RouteHelper.login);
      return;
    }
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> params = <String, dynamic>{
        'product': productDetails?.id,
        'qty': itemQty,
        if (selectedSize != null) 'size': selectedSize?.id ?? ''
      };
      final CartItemModel cart =
          await productRepo.addProductToCart(params: params);
      Loader.load(false);
      if (cart.id != null) {
        itemQty = 1;
        update();
        Get.toNamed(RouteHelper.cart);
        selectedSize = null;
        getProductDetails();
      }

      update();
    } catch (e) {
      Loader.load(false);
    }
  }

  void openQtyUpdateDialog() {
    Get.dialog(
      Dialog(
        elevation: 0,
        child: SizedBox(
          height: Get.height * .35,
          width: Get.width,
          child: QtyUpdateWidget(
            itemMaximumQty:
                selectedSize == null ? productDetails?.quantity ?? 0 : null,
            itemMinimumQty: selectedSize == null
                ? productDetails?.minimumOrderQuantity ?? 0
                : 1,
            onSubmit: (final int qty) {
              if (qty > 0) {
                if (selectedSize != null) {
                  isIncrementEnable = true;
                  if (qty > 1) {
                    isDecrementEnable = true;
                  } else {
                    isDecrementEnable = false;
                  }
                } else {
                  if (qty == (productDetails?.quantity ?? 1)) {
                    isIncrementEnable = false;
                  } else {
                    isIncrementEnable = true;
                  }
                  if (qty <= (productDetails?.minimumOrderQuantity ?? 1)) {
                    isDecrementEnable = false;
                  } else {
                    isDecrementEnable = true;
                  }
                }
                itemQty = qty;
                update();
                Get.back();
              }
            },
            itemQty: itemQty,
          ),
        ),
      ),
    );
  }

  void onSelectSize(final ProductSizeModel? size) {
    selectedSize = size;
    isDecrementEnable = false;
    if (size != null) {
      itemQty = 1;
      isIncrementEnable = true;
    } else {
      itemQty = productDetails?.minimumOrderQuantity ?? 1;
      if (itemQty == (productDetails?.quantity ?? 0)) {
        isIncrementEnable = false;
      }
    }
    update();
  }
}
