import 'package:atobuy_vendor_flutter/controller/product/add_product_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/brand_list_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/order_min_qty_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_barcode_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_brand_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_category_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_desc_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_name_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_price_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_quantity_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_store_field_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/textfields/product_sub_category_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductFormWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<AddProductController>(
      builder: (final AddProductController controller) {
        return Form(
          key: controller.addProductFormKey,
          child: Column(
            children: <Widget>[
              Gap(24),
              ProductNameTextFieldWidget(controller: controller.txtProdName),
              Gap(16),
              ProductDescFieldWidget(
                controller: controller.txtProdDesc,
              ),
              Gap(16),
              ProductStoreTextFieldWidget(
                selectedStore: controller.selectedStore,
                onSelectStore: (final StoreModel? store) {
                  controller.onSelectStore(store: store);
                },
                stores: controller.arrStores,
              ),
              Gap(16),
              ProductCategoryTextFieldWidget(
                categories: controller.arrCategory,
                selectedCategory: controller.selectedCategory,
                onSelectCategory: (final Category? category) {
                  controller.onSelectStoreCategory(category: category);
                },
              ),
              Gap(16),
              ProductSubCategoryTextFieldWidget(
                subCategories: controller.arrSubCategory,
                selectedCategory: controller.selectedSubCategory,
                onSelectSubCategory: (final Category? category) {
                  controller.onSelectStoreSubCategory(subCategory: category);
                },
              ),
              Gap(16),
              ProductBrandTextFieldWidget(
                brands: controller.arrBrands,
                selectedBrand: controller.selectedBrand,
                onSelectBrand: (final Brand? brand) {
                  controller.onSelectBrand(brand: brand);
                },
              ),
              Gap(16),
              ProductBarcodeFieldWidget(
                controller: controller.txtBarcode,
              ),
              Gap(16),
              ProductQuantityFieldWidget(
                controller: controller.txtProdInitialQuantity,
              ),
              Gap(16),
              ProductPriceFieldWidget(
                controller: controller.txtProdPrice,
              ),
              Gap(16),
              OrderMinQtyFieldWidget(
                controller: controller.txtMinOrderQty,
              ),
              Gap(16),
            ],
          ),
        );
      },
    );
  }
}
