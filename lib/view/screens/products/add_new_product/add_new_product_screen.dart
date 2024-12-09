import 'package:atobuy_vendor_flutter/controller/product/add_product_controller.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/product_form_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/widgets/upload_photos_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddNewProductScreen extends StatelessWidget {
  const AddNewProductScreen({
    super.key,
  });

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GetBuilder<AddProductController>(
          init: AddProductController(
            productRepo: Get.find(),
          ),
          builder: (final AddProductController controller) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                appBar: AppbarWithBackIconAndTitle(
                  title: controller.product != null
                      ? 'Update Product'.tr
                      : 'Create New Product'.tr,
                ),
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Gap(24.0),
                              UploadPhotosWidget(),
                              ProductFormWidget(),
                            ],
                          ).paddingSymmetric(horizontal: 16.0),
                        ),
                      ),
                      Gap(16.0),
                      CommonButton(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                Get.find<AddProductController>()
                                    .onTapAddOrEditProduct();
                              },
                              title: 'Save & Submit Changes'.tr)
                          .paddingSymmetric(horizontal: 16.0),
                      Gap(MediaQuery.of(context).padding.bottom > 0 ? 0 : 16)
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
