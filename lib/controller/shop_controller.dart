import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/shop_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/business_type_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/auth/user_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/vendor_store_exist_response_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/promo_banner/banner_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ShopController extends GetxController implements GetxService {
  ShopController({required this.sharedPref, required this.shopRepository});

  final SharedPreferenceHelper sharedPref;
  final ShopRepo shopRepository;

  List<BannerItem> bannerList = <BannerItem>[];
  List<BusinessCategory> arrBusinessCategory = <BusinessCategory>[];
  BusinessCategory? selectedBusinessCategory;

  PagingController<int, Category> categoryListController =
      PagingController<int, Category>(
    firstPageKey: 1,
  );

  Future<void> init() async {
    getVendorStoreCreatedStatus();
    getBannerList();

    selectedBusinessCategory = null;
    await getBusinessCategory();

    categoryListController.dispose();
    categoryListController = PagingController<int, Category>(
      firstPageKey: 1,
    );
    categoryListController.addPageRequestListener((final int pageKey) {
      fetchCategories(page: pageKey);
    });
  }

  Future<void> fetchCategories({required final int page}) async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }
    try {
      final Map<String, dynamic> params = <String, dynamic>{
        'store_category': true,
        'page_size': 'all',
        if (selectedBusinessCategory?.id != null)
          'business_category': selectedBusinessCategory?.id
      };
      final List<Category> categories =
          await shopRepository.getCategories(queryParams: params);
      categoryListController.itemList = [];
      categoryListController.appendLastPage(categories);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getVendorStoreCreatedStatus() async {
    try {
      if (!sharedPref.isLoggedIn ||
          (sharedPref.user?.vendorStoreExist ?? false)) {
        return;
      }

      final VendorStoreExistResponseModel vendorStoreExistResponseModel =
          await shopRepository.getVendorStoreCreatedStatus(
              userId: sharedPref.user?.id ?? -1);
      if (vendorStoreExistResponseModel.vendorStoreExist ?? false) {
        final UserModel? user = sharedPref.user;
        user?.vendorStoreExist = true;
        if (user != null) {
          await sharedPref.saveUser(user);
          Future<void>.delayed(Duration(seconds: 1), () {
            Get.offAllNamed(
              RouteHelper.home,
            );
          });
        }
      }
    } catch (e) {}
  }

  Future<void> refreshData() async {
    categoryListController.refresh();
    getBusinessCategory();
  }

  Future<void> getBannerList() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      await shopRepository.getAllBannerList(
        params: <String, dynamic>{'page_size': 'all'},
      ).then((final List<BannerItem> value) {
        bannerList = value;
        update();
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getBusinessCategory() async {
    try {
      arrBusinessCategory = await Get.find<GlobalController>()
          .getBusinessCategory(
              queryParams: <String, dynamic>{'page_size': 'all'});
      if (arrBusinessCategory.isNotEmpty) {
        selectedBusinessCategory = arrBusinessCategory.first;
        fetchCategories(page: 1);
      }
      update();
    } catch (e) {
      rethrow;
    }
  }

  void onSelectBusinessCategory({required final BusinessCategory category}) {
    if (selectedBusinessCategory != category) {
      selectedBusinessCategory = category;
    }
    categoryListController.refresh();
    update();
  }

  bool isValidBanner({required final BannerItem banner}) {
    return (banner.product?.uuid != null &&
        banner.product?.isActive == true &&
        banner.product?.ownerId != sharedPref.user?.id.toString());
  }
}
