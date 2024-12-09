import 'package:atobuy_vendor_flutter/controller/inventory/inventory_details_controller.dart';
import 'package:atobuy_vendor_flutter/controller/inventory/inventory_list_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/order_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/offer_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/double_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/delete_product_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/product_details_more_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/success_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController implements GetxService {
  ProductDetailsController({
    required this.productRepo,
    required this.orderRepo,
  });
  final ProductRepo productRepo;
  String productUUID = '';
  ProductDetailsModel? productDetails;
  final OrderRepo orderRepo;
  ProductApprovalStatus? approvalStatus;
  int? productId;

  List<ProductOffer> arrOffers = <ProductOffer>[];

  bool isEditable = true;
  bool isLoading = true;

  // Offer

  final GlobalKey<FormState> formDiscount = GlobalKey<FormState>();
  final GlobalKey<FormState> formPercentage = GlobalKey<FormState>();
  TextEditingController txtDiscountAmount = TextEditingController();
  TextEditingController txtPercentage = TextEditingController();
  TextEditingController txtDates = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  double? discountPercentage;
  double? discountedPrice;

  void initialise() {
    resetData();
    if (Get.arguments != null) {
      if (Get.arguments['come_from'] != null) {
        if (Get.arguments['come_from'] == 'order') {
          isEditable = false;
        }
      }

      if (Get.arguments['product'] != null) {
        if (Get.arguments['product'] is ProductDetailsModel) {
          final ProductDetailsModel product = Get.arguments['product'];
          if (product.uuid != null) {
            productUUID = product.uuid ?? '';
          }
          if (product.status != null) {
            approvalStatus = product.status;
          }
          if (product.id != null) {
            productId = product.id;
          }
        }
        if (Get.arguments['product'] is InventoryProduct) {
          final InventoryProduct product = Get.arguments['product'];
          if (product.uuid != null) {
            productUUID = product.uuid ?? '';
          }
          if (product.status != null) {
            approvalStatus = product.status;
          }
          if (product.id != null) {
            productId = product.id;
          }
        }
      }
    }
    if (productUUID.isNotEmpty) {
      getProductDetails();
    }
  }

  void resetData() {
    isEditable = true;
    arrOffers = <ProductOffer>[];
    productUUID = '';
    productId = null;
    productDetails = null;
    fromDate = null;
    toDate = null;
    discountPercentage = null;
    discountedPrice = null;
  }

  Future<void> toggleProductStatus(final bool value) async {
    productDetails?.isActive = value;
    update();
    await productStatusUpdateAPI(productUUID: productUUID, isActive: value);
  }

  Future<bool> productStatusUpdateAPI(
      {required final String productUUID, required final bool isActive}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return false;
      }
      Loader.load(true);
      final Map<String, dynamic> requestData = <String, dynamic>{
        'is_active': isActive,
      };
      final ProductDetailsModel response =
          await productRepo.updateProductStatus(
        productUUID: productUUID,
        body: requestData,
        queryParams: <String, bool>{'is_vendor': true},
      );
      Loader.load(false);
      productDetails?.isActive = response.isActive ?? false;
      update();
      if (Get.isRegistered<ProductListController>()) {
        Get.find<ProductListController>().changeStatusFormAllRecords(
            productUUID, response.isActive ?? false);
      }
      if (Get.isRegistered<InventoryDetailsController>()) {
        Get.find<InventoryDetailsController>().getInventoryDetails();
      }
      if (Get.isRegistered<InventoryListController>()) {
        Get.find<InventoryListController>().refreshInventoryList();
      }
      return response.isActive ?? false;
    } catch (e) {
      Loader.load(false);
      productDetails?.isActive = !isActive;
      update();
      return false;
    }
  }

  String getProductImage() {
    final Images? image = productDetails?.images?.firstWhereOrNull(
            (final Images image) => image.isCoverImage == true) ??
        ((productDetails?.images ?? <Images>[]).isNotEmpty
            ? productDetails?.images?.first
            : null);

    return image?.image ?? '';
  }

  Future<void> getProductDetails() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> param = <String, dynamic>{
        'is_vendor': true,
        if (productId != null) 'id': productId
      };
      ProductDetailsModel? value;

      value = await productRepo.getProductDetails(
          productUUID: productUUID.toString(), params: param);

      Loader.load(false);
      if (value.id != null) {
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
        getOfferList();
        isLoading = false;
        update();
      }
    } catch (e) {
      Loader.load(false);
      isLoading = false;
      update();
      if (Get.previousRoute == RouteHelper.productList) {
        Get.find<ProductListController>().refreshProductList();
      }
    }
  }

  Future<bool> deleteProduct({required final String productUUID}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return false;
      }
      Loader.load(true);
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'is_vendor': true,
        'id': productId
      };
      final bool isDeleted = await productRepo.deleteProduct(
        productUUID: productUUID,
        queryParams: queryParams,
      );
      Loader.load(false);
      Get.find<ProductListController>()
          .manageDeletedProduct(productID: productId!);
      return isDeleted;
    } catch (e) {
      Loader.load(false);
      return false;
    }
  }

  // offer
  void resetOfferBottomSheet() {
    txtPercentage.text = '';
    txtDiscountAmount.text = '';
    txtDates.text = '';
    fromDate = null;
    toDate = null;
  }

  void onSelectionChanged(final DateTimeRange dateRange) {
    fromDate = dateRange.start;
    toDate = dateRange.end;
    txtDates.text = '${fromDate.formatDDMMYYYY()} - ${toDate.formatDDMMYYYY()}';
    debugPrint('Dates --> ${txtDates.text}');
    update();
  }

  void onChangeDiscountedAmount(final String value) {
    if (!value.isNotNullAndEmpty()) {
      this.discountPercentage = null;
      txtPercentage.text = '';
      return;
    }
    double discount = double.parse(value);
    final double mainPrice = double.parse(productDetails?.price ?? '0.0');

    if (discount > mainPrice) {
      txtDiscountAmount.text = value.toString().removeLastCharacter();
      discount = double.parse(txtDiscountAmount.text);
      txtDiscountAmount.selection = TextSelection.fromPosition(
        TextPosition(offset: txtDiscountAmount.text.length),
      );
    }
    final double percentage = (discount / mainPrice) * 100;

    final String per = percentage.truncateToDecimalPlaces(2).toString();
    txtPercentage.text = '$per%';
    this.discountPercentage = percentage;

    debugPrint('percentage --> ${this.discountPercentage}');
  }

  void onChangePercentageValue(final String value) {
    String strPercentage = value;
    double percentage =
        strPercentage.isNotEmpty ? double.parse(strPercentage) : 0.0;
    final double price = double.parse(productDetails?.price ?? '0.0');
    if (percentage == 0) {
      txtDiscountAmount.text = '';
      return;
    }

    if (percentage > 100) {
      strPercentage = strPercentage.removeLastCharacter();
      percentage = double.parse(strPercentage);
      txtPercentage.selection = TextSelection.fromPosition(
        TextPosition(offset: txtPercentage.text.length),
      );
    }

    final double discountedPrice =
        getDiscountedAmountFromPercentage(percentage: percentage, price: price);

    txtDiscountAmount.text =
        discountedPrice.truncateToDecimalPlaces(2).toString();

    managePercentageFieldData(strPercentage);

    debugPrint('discountedPrice --> ${this.discountedPrice}');
  }

  double getDiscountedAmountFromPercentage(
      {required final double percentage, required final double price}) {
    return ((percentage / 100) * price);
  }

  void managePercentageFieldData(final String value) {
    if (value.isEmpty) {
      txtPercentage.value = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      return;
    }
    this.discountPercentage = double.parse(value);
    // Remove existing percentage sign
    final String text = value.replaceAll('%', '');

    // Set the new text with a percentage sign
    txtPercentage.value = TextEditingValue(
      text: '$text%',
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  Future<void> getOfferList() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final Map<String, dynamic> req = <String, dynamic>{
        'product': productDetails?.id,
        'page_size': 'all'
      };
      await productRepo
          .getOfferList(
        params: req,
      )
          .then((final List<ProductOffer> value) {
        arrOffers = value;
        update();
      });
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> handleDetailsRefresh() async {
    getProductDetails();
    getOfferList();
  }

  void onTapCreateOffer({final int? offerId}) {
    if (discountPercentage == null) {
      showCustomSnackBar(message: 'Please add discount percentage'.tr);
      return;
    }
    if (fromDate == null || toDate == null) {
      showCustomSnackBar(message: 'Please select offer validity dates'.tr);
      return;
    }

    Get.back();
    createOrEditOffer(offerId: offerId);
  }

  Future<void> createOrEditOffer({final int? offerId}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      Loader.load(true);

      final Map<String, dynamic> request = <String, dynamic>{
        'product': productDetails?.id,
        'offer_type': 'percentage',
        'amount': discountPercentage, //txtPercentage.text,
        'from_date': fromDate.formatYYYYMMDD(),
        'to_date': toDate.formatYYYYMMDD(),
      };
      await productRepo.createOrEditOffer(body: request, offerId: offerId).then(
        (final dynamic stores) async {
          Loader.load(false);
          getOfferList();
          SuccessBottomSheet.show(
            title: offerId == null
                ? 'Offer created successfully.'.tr
                : 'Offer edited successfully.'.tr,
            onTapContinue: () {
              handleDetailsRefresh();
            },
          );
        },
      );
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> deleteOffer({required final String offerId}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      Loader.load(true);

      await productRepo.deleteOffer(offerId: offerId).then(
        (final dynamic value) async {
          Loader.load(false);
          getOfferList();
          SuccessBottomSheet.show(
            title: 'Offer deleted successfully.'.tr,
            onTapContinue: () {},
          );
        },
      );
    } catch (e) {
      Loader.load(false);
    }
  }

  bool isOnGoingOfferVisible() {
    return !((arrOffers.isEmpty && !isEditable) ||
        (arrOffers.isEmpty &&
            (approvalStatus == ProductApprovalStatus.inReview ||
                approvalStatus == ProductApprovalStatus.rejected)));
  }

  void onTapMore() {
    Get.bottomSheet(
      ProductDetailsMoreBottomSheet(
        onTapEditProduct: () {
          debugPrint('onTapEditProduct');

          Get.back();
          Get.toNamed(
            RouteHelper.addNewProduct,
            arguments: <String, ProductDetailsModel?>{
              'product': productDetails
            },
          )?.then((final dynamic value) {
            if (value != null) {
              if (value == true) {
                getProductDetails();
              }
            }
          });
        },
        onTapDeleteProduct: () {
          debugPrint('onTapDeleteProduct');
          showDeleteProductSheet();
        },
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }

  void showDeleteProductSheet() {
    Get.bottomSheet(
      DeleteProductBottomSheet(
        onTapDelete: () async {
          Get.back();
          Get.back();
          final bool isDeleted = await deleteProduct(productUUID: productUUID);
          if (isDeleted) {
            showDeleteSuccessSheet();
          }
        },
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }

  void showDeleteSuccessSheet() {
    SuccessBottomSheet.show(
      title: 'Product deleted successfully.'.tr,
      onTapContinue: () {
        Get.back();
      },
    );
  }
}
