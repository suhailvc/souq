import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/repository/inventory_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InventoryListController extends GetxController {
  InventoryListController(
      {required this.globalController, required this.inventoryRepo});

  final GlobalController globalController;
  final InventoryRepo inventoryRepo;

  //Inventory List
  SortOptions selectedSort = SortOptions.newestFirst;
  List<Category> categoryList = <Category>[];
  List<Category> subCategoryList = <Category>[];

  Category? selectedCategory;
  Category? selectedSubCategory;

  Category? selectedTempCategory;
  Category? selectedTempSubCategory;

  int itemCounts = 0;

  final TextEditingController txtSearchInventory = TextEditingController();
  String searchText = '';
  PagingController<int, StoreModel> inventoryListController =
      PagingController<int, StoreModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);
  @override
  void onInit() {
    super.onInit();
    initialise();
  }

  void initialise() {
    setFilterData();
    setPageControllerListener();
    txtSearchInventory.text = '';
  }

  void initialiseFilters() {
    selectedTempSubCategory = selectedSubCategory;
    selectedTempCategory = selectedCategory;
  }

  void applyFilterRefresh() {
    selectedSubCategory = selectedTempSubCategory;
    selectedCategory = selectedTempCategory;
    refreshInventoryList();
  }

  void setPageControllerListener() {
    inventoryListController.addPageRequestListener((final int pageKey) {
      getAllInventoryList(page: pageKey);
    });
  }

  Future<void> refreshInventoryList() async {
    inventoryListController.refresh();
  }

  // Manage Filter And Sort
  void onSubmitSearchText(final String value) {
    FocusScope.of(Get.context!).unfocus();
    searchText = value;
    onChangeSearchText(value);
    applyFilterRefresh();
  }

  void onChangeSearchText(final String value) {
    txtSearchInventory.text = value;
    update();
  }

  void onSelectSortType(final SortOptions sortType) {
    selectedSort = sortType;
    update();
    refreshInventoryList();
  }

  void onSelectCategory({required final Category selectedCategory}) {
    if (this.selectedTempCategory != null &&
        this.selectedTempCategory == selectedCategory) {
      this.selectedTempCategory = null;
    } else if (this.selectedTempCategory != null &&
        this.selectedTempCategory != selectedCategory) {
      this.selectedTempCategory = selectedCategory;
    } else {
      this.selectedTempCategory = selectedCategory;
    }
    filterSubCategory(this.selectedTempCategory?.subCategory);
    update();
  }

  void filterSubCategory(final List<Category>? list) {
    subCategoryList.clear();
    selectedSubCategory = null;
    selectedTempSubCategory = null;
    subCategoryList.addAll(list ?? <Category>[]);
    update();
  }

  void onSelectSubCategory({required final Category subCategory}) {
    if (this.selectedTempSubCategory != null &&
        this.selectedTempSubCategory == subCategory) {
      this.selectedTempSubCategory = null;
    } else if (this.selectedTempSubCategory != null &&
        this.selectedTempSubCategory != subCategory) {
      this.selectedTempSubCategory = subCategory;
    } else {
      this.selectedTempSubCategory = subCategory;
    }
    update();
  }

  void setFilterData() {
    categoryList = globalController.categoryList;
    subCategoryList = <Category>[];
    update();
  }

  void resetFilter() {
    categoryList = globalController.categoryList;
    selectedCategory = null;
    selectedSubCategory = null;
    selectedTempCategory = null;
    selectedTempSubCategory = null;
    update();
  }

  Map<String, dynamic> getFilterAndSortParams({required final int page}) {
    return <String, dynamic>{
      'page': page,
      if (searchText.trim().isNotEmpty) 'name': '${searchText.trim()}',
      'ordering': selectedSort.inventoryValue,
      if (selectedCategory != null) 'category': '${selectedCategory?.id}',
      if (selectedSubCategory != null)
        'sub_category': '${selectedSubCategory?.id}',
    };
  }

  // Get Inventory List
  Future<void> getAllInventoryList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      itemCounts = 0;
      update();
      await inventoryRepo
          .getInventoryList(
        params: getFilterAndSortParams(page: page),
      )
          .then((final InventoryListResponseModel value) {
        itemCounts = value.count ?? 0;
        if (value.next != null) {
          final int nextPage = page + 1;
          inventoryListController.appendPage(
              value.results ?? <StoreModel>[], nextPage);
        } else {
          inventoryListController
              .appendLastPage(value.results ?? <StoreModel>[]);
        }
        update();
      });
    } catch (e) {
      inventoryListController.error = e;
      Loader.load(false);
    }
  }
}
