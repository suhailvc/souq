import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/api/endpoints/endpoints.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/common/common_detail_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/product_list_more_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/product_sort_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/delete_listed_product_bottom_sheet.dart';
import 'package:dio/dio.dart' as dio_multi;
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ProductListController(
      {required this.sharedPref,
      required this.productRepo,
      required this.globalController});
  final SharedPreferenceHelper sharedPref;
  final ProductRepo productRepo;
  final GlobalController globalController;
  TabController? tabController;
  int selectedTabIndex = 0;

  String productExcelFilePath = '';
  String productExcelFileName = '';
  String productExcelFileSize = '';
  String searchText = '';

  List<Category> categoryList = <Category>[];
  List<Category> subCategoryList = <Category>[];

  PriceRangeData? priceRangeData;
  double minPrice = 0.0;
  double maxPrice = 1.0;

  //Product List Screen
  final TextEditingController txtSearchEc = TextEditingController();

  PagingController<int, ProductDetailsModel> allProductPagingController =
      PagingController<int, ProductDetailsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  PagingController<int, ProductDetailsModel> approvedProductPagingController =
      PagingController<int, ProductDetailsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  PagingController<int, ProductDetailsModel> rejectedProductPagingController =
      PagingController<int, ProductDetailsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  RangeValues rangeValues = RangeValues(0.0, 1.0);

  ProductListReqModel requestModel = ProductListReqModel();

  @override
  void onInit() {
    super.onInit();
    onInitialization();
  }

  void onInitialization() async {
    tabController = TabController(
        length: 3,
        vsync: this,
        initialIndex: selectedTabIndex,
        animationDuration: Duration.zero);
    tabController?.animation?.addListener(
      () {
        selectedTabIndex = tabController?.animation?.value.round() ?? 0;
        update();
        onTabChangeRefresh();
      },
    );
    selectedTabIndex = 0;

    if (globalController.categoryList.isEmpty ||
        globalController.priceRangeData == null) {
      await globalController.getProductFilter();
    }
    resetFilter();
    setFilterData();
    setPageControllerListener();
  }

  void setPageControllerListener() {
    allProductPagingController.addPageRequestListener((final int pageKey) {
      getAllProductList(page: pageKey);
    });

    approvedProductPagingController.addPageRequestListener((final int pageKey) {
      getApprovedProductList(page: pageKey);
    });

    rejectedProductPagingController.addPageRequestListener((final int pageKey) {
      getRejectedProductList(page: pageKey);
    });
  }

  Future<void> handleRefresh(
      final PagingController<int, ProductDetailsModel> pagingController) async {
    pagingController.refresh();
  }

  Map<String, dynamic> getFilterAndSortParams(final int page) {
    return <String, dynamic>{
      'page': page,
      'is_vendor': true,
      if (sharedPref.selectedStoreId != null)
        'store': sharedPref.selectedStoreId,
      if (searchText.trim().isNotEmpty) 'title': searchText.trim(),
      'ordering': requestModel.sortSelectedValue.value,
      if (requestModel.selectedCategory != null)
        'category': '${requestModel.selectedCategory?.id}',
      if (requestModel.selectedSubCategory != null)
        'sub_category': '${requestModel.selectedSubCategory?.id}',
      if (selectedTabIndex == 0 &&
          requestModel.selectedProductApprovalStatus != null)
        'status': '${requestModel.selectedProductApprovalStatus?.key}'
      else if (selectedTabIndex == 1)
        'status': '${ProductApprovalStatus.approved.key}'
      else if (selectedTabIndex == 2)
        'status': '${ProductApprovalStatus.rejected.key}',
      if (requestModel.selectedProductStatus != null)
        if (requestModel.selectedProductStatus?.key == ProductStatus.active.key)
          'is_active': '${true}'
        else if (requestModel.selectedProductStatus?.key ==
            ProductStatus.inActive.key)
          'is_active': '${false}',
      if (requestModel.minPrice != null)
        'price_min': '${requestModel.minPrice!}',
      if (requestModel.maxPrice != null)
        'price_max': '${requestModel.maxPrice!}',
    };
  }

  void refreshProductList() {
    allProductPagingController.refresh();
    approvedProductPagingController.refresh();
    rejectedProductPagingController.refresh();
  }

  void onTapApplyFilter(final ProductListReqModel request) {
    final SortOptions sort = requestModel.sortSelectedValue;
    requestModel = request;
    requestModel.sortSelectedValue = sort;
    refreshProductList();
  }

  void resetImportFileDetail() {
    productExcelFileSize = '';
    productExcelFileName = '';
    productExcelFilePath = '';
    update();
  }

  Future<void> downloadSampleFile() async {
    try {
      final String? filePath = await FileSaver.instance.saveAs(
        name: 'sample-product-file-format',
        link: LinkDetails(
            link: Endpoints.getImportExcelSample,
            headers: <String, String>{
              'Authorization': 'Token ${sharedPref.authToken}'
            }),
        ext: 'xlsx',
        mimeType: MimeType.microsoftExcel,
      );
      if (filePath != null) {
        showCustomSnackBar(
            message: 'Sample file downloaded successfully'.tr, isError: false);
      }
    } catch (e) {
      showCustomSnackBar(
          message: 'Failed to download sample file'.tr, isError: true);
    }
  }

  Future<void> pickExcelFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: <String>[
        ImportFileExtension.xlsx.name,
        ImportFileExtension.xls.name
      ],
      type: FileType.custom,
    );

    if (result != null) {
      productExcelFilePath = result.files.single.path ?? '';
      productExcelFileName = result.files.single.name;
      productExcelFileSize =
          Utility.getFileSizeString(bytes: result.files.single.size);
      update();
    }
  }

  void setSearchText(final String value) {
    FocusScope.of(Get.context!).unfocus();
    txtSearchEc.text = value;
    searchText = value;
    update();
    refreshProductList();
  }

  void setOnChangeSearchText(final String value) {
    txtSearchEc.text = value;
    update();
  }

  void onTabChangeRefresh() {
    if (selectedTabIndex == 0 &&
        allProductPagingController.itemList.isNullOrEmpty()) {
      allProductPagingController.refresh();
    } else if (selectedTabIndex == 1 &&
        approvedProductPagingController.itemList.isNullOrEmpty()) {
      approvedProductPagingController.refresh();
    } else if (selectedTabIndex == 2 &&
        rejectedProductPagingController.itemList.isNullOrEmpty()) {
      rejectedProductPagingController.refresh();
    }
  }

  Future<void> getAllProductList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      await productRepo
          .getProduct(
        params: getFilterAndSortParams(page),
      )
          .then((final ProductListModel value) {
        if (value.next != null) {
          final int nextPage = page + 1;
          allProductPagingController.appendPage(
              value.results ?? <ProductDetailsModel>[], nextPage);
        } else {
          allProductPagingController
              .appendLastPage(value.results ?? <ProductDetailsModel>[]);
        }
        update();
      });
    } catch (e) {
      allProductPagingController.error = e;
      Loader.load(false);
    }
  }

  Future<void> uploadProductListFile({required final String filePath}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      dio_multi.MultipartFile? productFileParam;
      if (filePath.isNotEmpty && !Utility.checkIsNetworkUrl(filePath)) {
        productFileParam = await dio_multi.MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last);
      }

      final Map<String, dynamic> payLoad = <String, dynamic>{
        if (filePath.isNotEmpty && !Utility.checkIsNetworkUrl(filePath))
          'product_file': productFileParam,
      };
      await productRepo
          .uploadProductListFile(params: payLoad)
          .then((final CommonDetailModel value) {
        resetImportFileDetail();
        Get.back();
        Get.back();
        showCustomSnackBar(message: value.detail, isError: false);
        allProductPagingController.refresh();
        return;
      });
      Loader.load(false);
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> getApprovedProductList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      await productRepo
          .getProduct(
        params: getFilterAndSortParams(page),
      )
          .then((final ProductListModel value) {
        if (value.next != null) {
          final int nextPage = page + 1;
          approvedProductPagingController.appendPage(
              value.results ?? <ProductDetailsModel>[], nextPage);
        } else {
          approvedProductPagingController
              .appendLastPage(value.results ?? <ProductDetailsModel>[]);
        }
        update();
      });
    } catch (e) {
      approvedProductPagingController.error = e;
      Loader.load(false);
    }
  }

  Future<void> getRejectedProductList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      await productRepo
          .getProduct(
        params: getFilterAndSortParams(page),
      )
          .then((final ProductListModel value) {
        update();
        if (value.next != null) {
          final int nextPage = page + 1;
          rejectedProductPagingController.appendPage(
              value.results ?? <ProductDetailsModel>[], nextPage);
        } else {
          rejectedProductPagingController
              .appendLastPage(value.results ?? <ProductDetailsModel>[]);
        }
        update();
      });
    } catch (e) {
      rejectedProductPagingController.error = e;
      Loader.load(false);
    }
  }

  void changeStatusFormAllRecords(
      final String productUuid, final bool isActiveStatus) {
    allProductPagingController.itemList
        ?.forEach((final ProductDetailsModel item) {
      if (item.uuid == productUuid) {
        item.isActive = isActiveStatus;
      }
    });
    approvedProductPagingController.itemList
        ?.forEach((final ProductDetailsModel item) {
      if (item.uuid == productUuid) {
        item.isActive = isActiveStatus;
      }
    });
    rejectedProductPagingController.itemList
        ?.forEach((final ProductDetailsModel item) {
      if (item.uuid == productUuid) {
        item.isActive = isActiveStatus;
      }
    });
    update();
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
    subCategoryList = <Category>[];
    categoryList = globalController.categoryList;
    priceRangeData = globalController.priceRangeData;
    rangeValues = RangeValues(minPrice, maxPrice);
    requestModel.sortSelectedValue = selectedSort;
  }

  Future<bool> deleteProduct({
    required final String productUUID,
    required final int productID,
  }) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return false;
      }
      Loader.load(true);
      final bool isDeleted = await productRepo.deleteProduct(
        productUUID: productUUID,
        queryParams: <String, dynamic>{
          'is_vendor': true,
          'id': productID,
        },
      );
      Loader.load(false);
      manageDeletedProduct(productID: productID);
      return isDeleted;
    } catch (e) {
      Loader.load(false);
      return false;
    }
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
      changeStatusFormAllRecords(productUUID, response.isActive ?? false);
      Loader.load(false);
      return response.isActive ?? false;
    } catch (e) {
      Loader.load(false);
      return !isActive;
    }
  }

  void manageDeletedProduct({required final int productID}) {
    allProductPagingController.itemList?.removeWhere(
        (final ProductDetailsModel product) => product.id == productID);
    approvedProductPagingController.itemList?.removeWhere(
        (final ProductDetailsModel product) => product.id == productID);
    rejectedProductPagingController.itemList?.removeWhere(
        (final ProductDetailsModel product) => product.id == productID);
    update();
  }

  void onTapMore(final ProductDetailsModel product) {
    Get.bottomSheet(
      ProductListMoreBottomSheet(
        isProductActive: (product.isActive ?? false).obs,
        productModel: product,
        onTapEditProduct: () {
          Get.back();
          Get.toNamed(RouteHelper.addNewProduct,
              arguments: <String, ProductDetailsModel>{'product': product});
        },
        onTapDeleteProduct: () {
          Get.back();
          showDeleteProductConfirmationSheet(product);
        },
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }

  void showDeleteProductConfirmationSheet(final ProductDetailsModel product) {
    Get.bottomSheet(
      DeleteListedProductBottomSheet(
        product: product,
      ),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }

  void onTapSort() {
    FocusScope.of(Get.context!).unfocus();
    Get.bottomSheet(
      ProductSortBottomSheet(
        sortSelectedValue: requestModel.sortSelectedValue,
        onSubmit: (final SortOptions option) {
          onSelectSortType(option);
          refreshProductList();
        },
        onReset: (final SortOptions option) {
          onSelectSortType(SortOptions.newestFirst);
          refreshProductList();
        },
      ),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }
}
