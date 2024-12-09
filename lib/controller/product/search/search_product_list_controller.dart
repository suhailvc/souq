import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchProductListController extends GetxController {
  SearchProductListController(
      {required this.sharedPref,
      required this.productRepo,
      required this.globalController});
  final SharedPreferenceHelper sharedPref;
  final ProductRepo productRepo;
  final GlobalController globalController;

  PriceRangeData? priceRangeData;
  double minPrice = 0.0;
  double maxPrice = 1.0;

  ProductDetailsModel? product;
  //Product List Screen
  final TextEditingController txtSearchEc = TextEditingController();
  String searchText = '';
  int itemsCount = 0;

  PagingController<int, ProductDetailsModel> allProductPagingController =
      PagingController<int, ProductDetailsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  RangeValues rangeValues = RangeValues(0.0, 1.0);

  ProductListReqModel requestModel = ProductListReqModel();
  List<Category> categoryList = <Category>[];
  List<Category> subCategoryList = <Category>[];

  @override
  void onInit() {
    super.onInit();
    onInitialization();
  }

  void onInitialization() async {
    if (globalController.priceRangeData == null) {
      globalController.getProductFilter();
    }

    if (Get.arguments != null) {
      if (Get.arguments['product'] != null) {
        if (Get.arguments['product'] is ProductDetailsModel) {
          product = Get.arguments['product'];
        }
      }
    }

    if (globalController.categoryList.isEmpty) {
      globalController.getProductFilter().then((final void value) {
        setFilterData();
      });
    } else {
      setFilterData();
    }
    setPageControllerListener();
  }

  void setPageControllerListener() {
    allProductPagingController.addPageRequestListener((final int pageKey) {
      getAllProductList(page: pageKey);
    });
  }

  Future<void> handleRefresh(
      final PagingController<int, ProductDetailsModel> pagingController) async {
    pagingController.refresh();
  }

  Map<String, dynamic> getFilterAndSortParams(final int page) {
    return <String, dynamic>{
      'page': page,
      if (searchText.trim().isNotEmpty) 'title': searchText.trim(),
      'ordering': requestModel.sortSelectedValue.value,
      if (requestModel.selectedCategory != null)
        'category': '${requestModel.selectedCategory?.id}',
      if (requestModel.selectedSubCategory != null)
        'sub_category': '${requestModel.selectedSubCategory?.id}',
      if (requestModel.selectedProductApprovalStatus != null)
        'status': '${requestModel.selectedProductApprovalStatus?.key}',
      if (requestModel.selectedProductStatus != null)
        if (requestModel.selectedProductStatus?.key == ProductStatus.active.key)
          'is_active': '${true}'
        else if (requestModel.selectedProductStatus?.key ==
            ProductStatus.inActive.key)
          'is_active': '${false}',
      if (requestModel.minPrice != null)
        'price_min': '${requestModel.minPrice ?? 0.0}',
      if (requestModel.maxPrice != null)
        'price_max': '${requestModel.maxPrice ?? 0.0}',
    };
  }

  void applyFilterRefresh() {
    allProductPagingController.refresh();
  }

  void onTapApplyFilter(final ProductListReqModel request) {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = request;
    requestModel.sortSelectedValue = sort;
    applyFilterRefresh();
  }

  void setSearchText(final String value) {
    FocusScope.of(Get.context!).unfocus();
    txtSearchEc.text = value;
    searchText = value;
    update();
    applyFilterRefresh();
  }

  void changeSearchText(final String value) {
    txtSearchEc.text = value;
    update();
  }

  Future<void> getAllProductList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      itemsCount = 0;
      ProductListModel productListModel = ProductListModel();
      final Map<String, dynamic> req = getFilterAndSortParams(page);
      if (this.product != null) {
        productListModel = await productRepo.getVendorsProduct(
            productUUID: this.product?.uuid ?? '', params: req);
      } else {
        productListModel = await productRepo.getProduct(
          params: req,
        );
      }

      itemsCount = productListModel.count ?? 0;
      update();
      if (productListModel.next != null) {
        final int nextPage = page + 1;
        allProductPagingController.appendPage(
            productListModel.results ?? <ProductDetailsModel>[], nextPage);
      } else {
        allProductPagingController.appendLastPage(
            productListModel.results ?? <ProductDetailsModel>[]);
      }
    } catch (e) {
      allProductPagingController.error = e;
      Loader.load(false);
    }
  }

  void onSelectSortType(final SortOptions sortBy) {
    requestModel.sortSelectedValue = sortBy;
    update();
  }

  void setFilterData() {
    categoryList = globalController.categoryList;
    priceRangeData = globalController.priceRangeData;
    minPrice = Parsing.doubleFrom(priceRangeData?.minPrice ?? '0.0');
    maxPrice = Parsing.doubleFrom(priceRangeData?.maxPrice ?? '0.0');
    rangeValues = RangeValues(minPrice, maxPrice);
    update();
  }

  void resetFilter() {
    final SortOptions selectedSort = requestModel.sortSelectedValue;
    requestModel = ProductListReqModel();
    categoryList = globalController.categoryList;
    subCategoryList = <Category>[];
    priceRangeData = globalController.priceRangeData;
    rangeValues = RangeValues(minPrice, maxPrice);
    requestModel.sortSelectedValue = selectedSort;
    update();
  }
}
