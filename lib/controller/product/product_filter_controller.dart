import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/order_filer_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilterController extends GetxController {
  ProductFilterController(
      {required this.globalController, required this.productListController});

  final GlobalController globalController;
  final ProductListController productListController;

  final TextEditingController txtMinEc = TextEditingController();
  final TextEditingController txtMaxEc = TextEditingController();

  Category? selectedCategory;
  Category? selectedSubCategory;
  ProductApprovalStatus? selectedProductApprovalStatus;
  ProductStatus? selectedProductStatus;
  RangeValues rangeValues = RangeValues(0.0, 1.0);

  List<ProductApprovalStatus> statusList = ProductApprovalStatus.values;
  List<ProductStatus> productStatusList = ProductStatus.values;

  @override
  void onInit() {
    super.onInit();
    onInitialise();
  }

  void onInitialise() {
    final ProductListReqModel requestModel = productListController.requestModel;

    txtMinEc.text = requestModel.getMinValue(productListController.rangeValues);
    txtMaxEc.text = requestModel.getMaxValue(productListController.rangeValues);
    selectedCategory = requestModel.selectedCategory;
    selectedSubCategory = requestModel.selectedSubCategory;
    selectedProductApprovalStatus = requestModel.selectedProductApprovalStatus;
    selectedProductStatus = requestModel.selectedProductStatus;
    rangeValues = productListController.rangeValues;
  }

  void onSelectCategory(
      {required final Category selectedCategory,
      required final ProductListController controller}) {
    if (this.selectedCategory != null &&
        this.selectedCategory == selectedCategory) {
      this.selectedCategory = null;
    } else if (this.selectedCategory != null &&
        this.selectedCategory != selectedCategory) {
      this.selectedCategory = selectedCategory;
    } else {
      this.selectedCategory = selectedCategory;
    }
    filterSubCategory(this.selectedCategory?.subCategory);
    update();
  }

  void filterSubCategory(final List<Category>? list) {
    productListController.subCategoryList.clear();
    selectedSubCategory = null;
    productListController.subCategoryList.addAll(list ?? <Category>[]);
    update();
  }

  void onSelectSubCategory({required final Category subCategory}) {
    if (this.selectedSubCategory != null &&
        this.selectedSubCategory == subCategory) {
      this.selectedSubCategory = null;
    } else if (this.selectedSubCategory != null &&
        this.selectedSubCategory != subCategory) {
      this.selectedSubCategory = subCategory;
    } else {
      this.selectedSubCategory = subCategory;
    }
    update();
  }

  void onChangeMaxPriceRange(final String value) {
    final RangeValues? range = Utility.onChangeMaxPriceRange(
      value: value,
      filterViewRange: rangeValues,
    );
    setPriceValueToRangeSlider(range);
  }

  void onChangeMinPriceRange(final String value) {
    final RangeValues? range = Utility.onChangeMinPriceRange(
      value: value,
      filterViewRange: rangeValues,
      listViewRange: productListController.rangeValues,
    );
    setPriceValueToRangeSlider(range);
  }

  void setPriceValueToRangeSlider(final RangeValues? value) {
    if (value != null) {
      rangeValues = value;
      update();
    }
  }

  void onApprovalStatusSelected(
      {required final ProductApprovalStatus productStatusModel}) {
    if (this.selectedProductApprovalStatus != null &&
        this.selectedProductApprovalStatus == productStatusModel) {
      this.selectedProductApprovalStatus = null;
    } else if (this.selectedProductApprovalStatus != null &&
        this.selectedProductApprovalStatus != productStatusModel) {
      this.selectedProductApprovalStatus = productStatusModel;
    } else {
      this.selectedProductApprovalStatus = productStatusModel;
    }
    update();
  }

  void onProductStatusSelected(
      {required final ProductStatus productStatusModel}) {
    if (this.selectedProductStatus != null &&
        this.selectedProductStatus == productStatusModel) {
      this.selectedProductStatus = null;
    } else if (this.selectedProductStatus != null &&
        this.selectedProductStatus != productStatusModel) {
      this.selectedProductStatus = productStatusModel;
    } else {
      this.selectedProductStatus = productStatusModel;
    }
    update();
  }

  void setPriceValue(final RangeValues value) {
    rangeValues = value;
    txtMinEc.text = rangeValues.start.toStringAsFixed(2);
    txtMaxEc.text = rangeValues.end.toStringAsFixed(2);
    update();
  }

  void onTapApplyFilter() {
    FocusScope.of(Get.context!).unfocus();
    if (txtMinEc.text.isEmpty) {
      showCustomSnackBar(
          title: 'Error', message: 'Min price cannot be blank.'.tr);
      return;
    }
    if (Parsing.doubleFrom(txtMinEc.text) >=
        Parsing.doubleFrom(txtMaxEc.text)) {
      showCustomSnackBar(
          title: 'Error',
          message:
              'Min value should not be greater than or equal to the max value'
                  .tr);
      return;
    }
    if (txtMaxEc.text.isEmpty) {
      showCustomSnackBar(
          title: 'Error', message: 'Max price cannot be blank.'.tr);
      return;
    }
    setPriceValue(RangeValues(
        Parsing.doubleFrom(txtMinEc.text), Parsing.doubleFrom(txtMaxEc.text)));
    Get.back();
    productListController.rangeValues = rangeValues;
    final ProductListReqModel request = ProductListReqModel(
      minPrice: txtMinEc.text.toDouble(),
      maxPrice: txtMaxEc.text.toDouble(),
      selectedCategory: selectedCategory,
      selectedSubCategory: selectedSubCategory,
      selectedProductApprovalStatus: selectedProductApprovalStatus,
      selectedProductStatus: selectedProductStatus,
    );

    productListController.onTapApplyFilter(request);
  }
}
