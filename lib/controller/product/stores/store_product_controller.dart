import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/shop_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/store/offert_type_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/product_sort_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/shopproducts/widgets/store_product_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoreProductController extends GetxController
    with GetTickerProviderStateMixin {
  StoreProductController(
      {required this.productRepo,
      required this.globalController,
      required this.shopRepo});
  final ProductRepo productRepo;
  final ShopRepo shopRepo;
  final GlobalController globalController;

  List<Category> subCategoryList = <Category>[];
  List<Brand> arrBrands = <Brand>[];
  Brand? selectedBrand;
  PriceRangeData? priceRangeData;
  double minPrice = 0.0;
  double maxPrice = 1.0;

  //Product List Screen
  final TextEditingController txtSearchEc = TextEditingController();
  String searchText = '';

  PagingController<int, ProductDetailsModel> shopProductPagingController =
      PagingController<int, ProductDetailsModel>(
    firstPageKey: 1,
  );

  RangeValues rangeValues = RangeValues(0.0, 1.0);

  ProductListReqModel requestModel = ProductListReqModel();

  TabController? tabController;
  int selectedTabIndex = 0;
  List<Category> tabs = <Category>[];
  Category? selectedCategory;
  Category? selectedSubCategory;
  OfferType? offer;

  @override
  void onInit() {
    super.onInit();
    resetFilter();

    if (Get.arguments != null) {
      if (Get.arguments['offer'] != null) {
        if (Get.arguments['offer'] is OfferType) {
          offer = Get.arguments['offer'];
        }
      } else if (Get.arguments['category'] != null) {
        if (Get.arguments['category'] is Category) {
          selectedCategory = Get.arguments['category'];
          requestModel.selectedCategory = selectedCategory;
          getSubCategories();
        }
      }
    }
    onInitialization();
    shopProductPagingController.dispose();
    shopProductPagingController = PagingController<int, ProductDetailsModel>(
      firstPageKey: 1,
    );
    shopProductPagingController.addPageRequestListener((final int pageKey) {
      getAllProductList(page: pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabController?.dispose();
  }

  void onInitialization() async {
    priceRangeData = null;
    minPrice = 0.0;
    maxPrice = 1.0;
    txtSearchEc.text = '';
    selectedBrand = null;

    if (globalController.priceRangeData == null) {
      globalController.getProductFilter().then((final void value) {
        setFilterData();
      });
    } else {
      setFilterData();
    }
    getBrandList();
  }

  void initialiseTabController() {
    tabController = TabController(
        length: tabs.length,
        vsync: this,
        initialIndex: selectedTabIndex,
        animationDuration: Duration.zero);

    tabController?.animation?.addListener(
      () async {
        selectedTabIndex = tabController?.animation?.value.round() ?? 0;
        debugPrint('Tab Index $selectedTabIndex');
        if (selectedTabIndex == 0) {
          selectedSubCategory = null;
        } else {
          selectedSubCategory = tabs[selectedTabIndex];
        }
        selectedBrand = null;
        await getBrandList();
        shopProductPagingController.refresh();

        update();
      },
    );
    update();
  }

  Future<void> getAllProductList({required final int page}) async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }
    try {
      final ProductListModel productListModel = await productRepo.getProduct(
        params: getFilterAndSortParams(page),
      );

      if (productListModel.next != null) {
        final int nextPage = page + 1;
        shopProductPagingController.appendPage(
            productListModel.results ?? <ProductDetailsModel>[], nextPage);
      } else {
        shopProductPagingController.appendLastPage(
            productListModel.results ?? <ProductDetailsModel>[]);
      }
      update();
    } catch (e) {
      shopProductPagingController.error = e;
      debugPrint(e.toString());
    }
  }

  Map<String, dynamic> getFilterAndSortParams(final int page) {
    return <String, dynamic>{
      'page': page,
      if (txtSearchEc.text.trim().isNotEmpty)
        'title': '${txtSearchEc.text.trim()}',
      'ordering': requestModel.sortSelectedValue.value,
      if (selectedCategory != null) 'category': '${selectedCategory?.id}',
      if (selectedSubCategory != null)
        'sub_category': '${selectedSubCategory?.id}',
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
      if (offer != null) 'offer_type': offer?.key,
      if (selectedBrand != null) 'brand': selectedBrand?.uuid,
    };
  }

  Future<void> refreshStoreProductList() async {
    shopProductPagingController.refresh();
  }

  void onTapApplyFilter(final ProductListReqModel request) {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = request;
    requestModel.sortSelectedValue = sort;
    refreshStoreProductList();
  }

  void onSelectSortType(final SortOptions sortBy) {
    requestModel.sortSelectedValue = sortBy;
    refreshStoreProductList();
    update();
  }

  void setFilterData() {
    priceRangeData = globalController.priceRangeData;
    minPrice = Parsing.doubleFrom(priceRangeData?.minPrice ?? '0.0');
    maxPrice = Parsing.doubleFrom(priceRangeData?.maxPrice ?? '0.0');
    rangeValues = RangeValues(minPrice, maxPrice);
  }

  void resetFilter() {
    final SortOptions selectedSort = requestModel.sortSelectedValue;
    requestModel = ProductListReqModel();
    priceRangeData = globalController.priceRangeData;
    rangeValues = RangeValues(minPrice, maxPrice);
    requestModel.sortSelectedValue = selectedSort;
  }

  void setSearchText(final String value) {
    searchText = value;
    changeSearchText(value);
    refreshStoreProductList();
  }

  void changeSearchText(final String value) {
    txtSearchEc.text = value;
    update();
  }

  Future<void> getSubCategories() async {
    if (!await ConnectionUtils.isNetworkConnected()) {
      showCustomSnackBar(message: MessageConstant.networkError.tr);
      return;
    }
    try {
      final List<Category> subCategories = await shopRepo.getSubCategories(
          categoryId: selectedCategory?.id.toString() ?? '0');
      tabs = <Category>[Category(name: 'All Items'.tr, id: 0)];
      tabs.addAll(subCategories);
      initialiseTabController();

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onTapFilter() {
    Get.bottomSheet(ShopProductFilterBottomSheet(), isScrollControlled: true);
  }

  void onTapSort() {
    Get.bottomSheet(
      ProductSortBottomSheet(
        sortSelectedValue: requestModel.sortSelectedValue,
        onSubmit: (final SortOptions option) {
          onSelectSortType(option);
        },
        onReset: (final SortOptions option) {
          onSelectSortType(SortOptions.newestFirst);
        },
      ),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  Future<void> getBrandList() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, String> req = <String, String>{
        if (selectedCategory != null) 'category': '${selectedCategory?.id}',
        if (selectedSubCategory != null)
          'sub_category': '${selectedSubCategory?.id}',
      };
      final BrandListResponseModel data = await globalController
          .globalRepository
          .getBrandList(queryParams: req);
      if (data.results.isNotNullOrEmpty()) {
        arrBrands = data.results ?? <Brand>[];
        arrBrands.insert(0, Brand(title: 'All'.tr));
        selectedBrand = arrBrands.first;
      } else {
        arrBrands = <Brand>[];
        selectedBrand = null;
      }
      update();
    } catch (e) {
      rethrow;
    }
  }

  void onSelectBrand({required final Brand brand}) {
    if (selectedBrand != brand) {
      selectedBrand = brand;
    }
    update();
    refreshStoreProductList();
  }
}
