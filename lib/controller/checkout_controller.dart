import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/cart_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/wallet_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_balance_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  CheckoutController({
    required this.cartRepo,
    required this.walletRepo,
  });
  final CartRepo cartRepo;
  final WalletRepo walletRepo;

  PaymentModel? selectedPaymentMethod;

  CartModel? cartModel;
  AddressModel? selectedAddress;
  int totalItems = 0;
  List<VendorModel> vendorModelList = <VendorModel>[];
  List<PaymentModel> paymentModeList = <PaymentModel>[];
  String? walletBalance;

  @override
  void onInit() {
    initialization();
    super.onInit();
  }

  void initialization() {
    if (Get.arguments != null) {
      if (Get.arguments['cart'] != null) {
        cartModel = Get.arguments['cart'];
        selectedAddress = Get.arguments['address'];
      }
    }
    getProductList();
    getPaymentMethods();
    getWalletBalance();
  }

  void getProductList() {
    if (cartModel != null) {
      vendorModelList = cartModel?.getVendorModel() ?? <VendorModel>[];

      for (VendorModel vendorModel in vendorModelList) {
        totalItems += (vendorModel.items ?? <ProductItem>[]).length;
      }
    }
    update();
  }

  Future<void> getPaymentMethods() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final PaymentMethodModel paymentMethodModel =
          await cartRepo.getPaymentMethods();
      Loader.load(false);
      if (paymentMethodModel.results.isNotNullOrEmpty()) {
        paymentModeList = paymentMethodModel.results ?? <PaymentModel>[];
      }
      update();
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic> preparePlaceOrderParams() {
    Map<String, dynamic> params = <String, dynamic>{};
    if (cartModel!.results.isNotNullOrEmpty()) {
      params = <String, dynamic>{
        'cart': cartModel?.getCartId() ?? 0,
        'address': selectedAddress?.id ?? 0,
        'payment_mode': selectedPaymentMethod?.key
      };
    }
    return params;
  }

  Future<void> placeOrder() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      Loader.load(true);
      await cartRepo.buyProduct(body: preparePlaceOrderParams());
      Loader.load(false);
      Get.find<GlobalController>().getCartList();
      Get.offAllNamed(
        RouteHelper.placeOrder,
      );
    } catch (e) {
      Loader.load(false);
      return;
    }
  }

  void onPaymentMethod(final PaymentModel paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    update();
  }

  Future<void> getWalletBalance() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final WalletBalanceModel value = await walletRepo.getWalletBalance();
      walletBalance = value.balance;
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
