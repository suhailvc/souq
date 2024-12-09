import 'package:atobuy_vendor_flutter/data/repository/cart_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/global_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController implements GetxService {
  GlobalController({
    required this.globalRepository,
    required this.sharedPref,
    required this.cartRepo,
  });

  final GlobalRepository globalRepository;
  final SharedPreferenceHelper sharedPref;
  final CartRepo cartRepo;

  List<CountryModel> countryList = <CountryModel>[];
  List<Region> stateList = <Region>[];
  List<City> cityList = <City>[];
  List<PaymentModel> paymentModeList = <PaymentModel>[];

  List<Category> categoryList = <Category>[];
  PriceRangeData? priceRangeData;

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
    getProductFilter();
    getPaymentMethods();
    getCartList();
  }

  Future<void> fetchCountries({
    final int? userStateId,
  }) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final List<CountryModel> response = await globalRepository
          .getCountryList(queryParams: <String, dynamic>{'page_size': 'all'});

      countryList.clear();
      countryList.addAll(response);
      countryList.sort((final CountryModel a, final CountryModel b) =>
          (a.name ?? '').compareTo(b.name ?? ''));
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> refreshCountryList() async {
    await fetchCountries();
  }

  Future<void> fetchState({
    final int? stateId,
    required final int countryId,
  }) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      final List<Region> response = await globalRepository.getStates(
          queryParams: <String, dynamic>{
            'country': countryId,
            'page_size': 'all'
          });

      stateList.clear();
      stateList.addAll(response);
      stateList.sort((final Region a, final Region b) =>
          (a.name ?? '').compareTo(b.name ?? ''));

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> fetchCity({
    required final int stateId,
    required final int countryId,
  }) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, dynamic> params = <String, dynamic>{
        'region': stateId,
        'country': countryId,
        'page_size': 'all'
      };
      final List<City> response =
          await globalRepository.getCity(queryParams: params);

      cityList.clear();
      cityList.addAll(response);
      cityList.sort((final City a, final City b) =>
          (a.name ?? '').compareTo(b.name ?? ''));

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getProductFilter() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final ProductFilter productFilterModel = await globalRepository
          .getProductFilterData(
              queryParams: <String, String>{'filter_data': 'product'});
      priceRangeData = productFilterModel.priceRangeData;
      if ((productFilterModel.categories ?? <Category>[]).isNotEmpty) {
        categoryList = productFilterModel.categories ?? <Category>[];
        update();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BusinessCategory>> getBusinessCategory(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return <BusinessCategory>[];
      }

      final List<BusinessCategory> data =
          await globalRepository.getBusinessCategory(queryParams: queryParams);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> downloadInvoice(final String url, final String orderId) async {
    try {
      Loader.load(true);
      await FileSaver.instance.saveAs(
        name: '${orderId}',
        link: LinkDetails(
          link: url,
        ),
        ext: 'pdf',
        mimeType: MimeType.pdf,
      );
      Loader.load(false);
    } catch (e) {
      Loader.load(false);
      showCustomSnackBar(
          message: 'Failed to download invoice'.tr, isError: true);
    }
  }

  Future<void> getPaymentMethods() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final PaymentMethodModel paymentMethodModel =
          await globalRepository.getPaymentMethods();
      if (paymentMethodModel.results.isNotNullOrEmpty()) {
        paymentModeList = paymentMethodModel.results ?? <PaymentModel>[];
      }
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getCartList() async {
    if (!sharedPref.isLoggedIn) {
      return;
    }
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, dynamic> params = <String, dynamic>{
        'page': 1,
      };
      final CartModel cartModel = await cartRepo.getCartList(
        params: params,
      );

      if (cartModel.results.isNotNullOrEmpty()) {
        final int totalItems = cartModel.getTotalCartItems();
        SouqCart.update(newCartCount: totalItems);
      } else {
        SouqCart.update(newCartCount: 0);
      }
    } catch (e) {}
  }

  Future<void> updateFCMToken({required final String fcmToken}) async {
    try {
      await globalRepository.updateFCMToken(fcmToken: fcmToken);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Brand>> getBrandList(
      {required final Map<String, dynamic> queryParams}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return <Brand>[];
      }
      final BrandListResponseModel data =
          await globalRepository.getBrandList(queryParams: queryParams);
      return data.results ?? <Brand>[];
    } catch (e) {
      rethrow;
    }
  }
}
