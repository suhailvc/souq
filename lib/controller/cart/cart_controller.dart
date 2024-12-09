import 'package:atobuy_vendor_flutter/data/repository/cart_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:atobuy_vendor_flutter/view/base/common_delete_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CartController extends GetxController {
  CartController({
    required this.cartRepo,
  });
  final CartRepo cartRepo;

  CartModel cartModel = CartModel();
  int totalItems = 0;
  List<AddressModel> shippingAddressList = <AddressModel>[];

  AddressModel? selectedAddress;
  bool isLoading = true;

  PagingController<int, VendorModel> cartListController =
      PagingController<int, VendorModel>(
    firstPageKey: 1,
  );

  @override
  void onInit() {
    onInitialise();
    super.onInit();
  }

  void onInitialise() {
    cartListController.addPageRequestListener((final int pageKey) {
      getCartList(page: pageKey);
    });
    cartListController.notifyPageRequestListeners(1);
    getAddressApiCall();
  }

  Future<void> refreshCart() async {
    shippingAddressList.clear();
    getAddressApiCall();
    cartListController.refresh();
  }

  Future<void> getCartList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      final Map<String, dynamic> params = <String, dynamic>{
        'page': page,
      };
      cartModel = await cartRepo.getCartList(
        params: params,
      );
      Loader.load(false);
      if (cartModel.next != null) {
        final int nextPage = page + 1;
        cartListController.appendPage(cartModel.getVendorModel(), nextPage);
      } else {
        cartListController.appendLastPage(cartModel.getVendorModel());
      }
      if (cartModel.results.isNotNullOrEmpty()) {
        totalItems = cartModel.getTotalCartItems();
      }
      SouqCart.update(newCartCount: totalItems);
      isLoading = false;
      update();
    } catch (e) {
      Loader.load(false);
      isLoading = false;
      cartListController.error = e;
      update();
    }
  }

  Future<void> updateCart(final ProductItem product) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final Map<String, dynamic> params = <String, dynamic>{
        'product': product.product?.id ?? 0,
        if (product.size != null) 'size': product.size?.id,
      };
      Loader.load(true);
      await cartRepo.updateCart(
        params: params,
      );
      Loader.load(false);
      cartListController.refresh();
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Future<void> updateCartWithQuantity(
      final ProductItem product, final int quantity) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final int? cartId = cartModel.getCartId();
      final Map<String, dynamic> params = <String, dynamic>{
        'product': product.product?.id ?? 0,
        'qty': quantity,
        if (product.size != null) 'size': product.size?.id
      };
      Loader.load(true);
      await cartRepo.updateCartWithQuantity(
        params: params,
        cartId: cartId.toString(),
      );
      Loader.load(false);
      cartListController.refresh();
      Utility.goBack();
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Future<void> decreaseCartQty(
      final ProductItem product, final bool isDelete) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, dynamic> params = <String, dynamic>{
        'product': product.product?.id ?? 0,
        if (product.size != null) 'size': product.size?.id,
      };
      Loader.load(true);
      if (isDelete) {
        cartRepo.deleteItemFromCart(
          params: params,
          cartId: cartModel.getCartId(),
        );
      } else {
        await cartRepo.decreaseQty(
          params: params,
          cartId: cartModel.getCartId(),
        );
      }
      Loader.load(false);
      Future<void>.delayed(Duration(milliseconds: 200), () {
        cartListController.refresh();
      });
    } catch (e) {
      Loader.load(false);
      debugPrint(e.toString());
    }
  }

  Future<void> getAddressApiCall() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final AddressListModel addressListModel =
          await cartRepo.getShippingAddress();
      if (addressListModel.results.isNotNullOrEmpty()) {
        shippingAddressList = (addressListModel.results ?? <AddressModel>[]);
        if (shippingAddressList.isNotEmpty) {
          final AddressModel defaultAddress = shippingAddressList
                  .firstWhereOrNull((final AddressModel address) =>
                      address.addressType == AddressType.company) ??
              shippingAddressList.first;
          selectedAddress = defaultAddress;
        }
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onAddressTap(final AddressModel addressModel) {
    selectedAddress = addressModel;
    update();
  }

  void onTapRemoveFromBag({required final ProductItem product}) {
    Get.bottomSheet(
      CommonDeleteBottomSheet(
        onTapDelete: () {
          decreaseCartQty(product, true);
        },
        title: 'Remove from Bag'.tr,
        subTitle: 'Are you sure you want to remove this item from bag?'.tr,
      ),
    );
  }
}
