import 'package:atobuy_vendor_flutter/controller/purchase/purchase_product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/request_model/product_bulk_model.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/cart_icon.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/product_images_slider_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/no_item_found_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/add_item_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/more_items_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/product_info_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/product_size_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PurchaseProductDetailScreen extends StatelessWidget {
  String tag = Utility.getRandomString(10);

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<PurchaseProductDetailsController>(
          tag: tag,
          init: PurchaseProductDetailsController(productRepo: Get.find()),
          builder: (final PurchaseProductDetailsController controller) {
            return Scaffold(
              appBar: AppbarWithBackIconTitleAndSuffixWidget(
                title: 'Product Details'.tr,
                suffixWidget: Padding(
                  padding: EdgeInsetsDirectional.only(end: 16),
                  child: SouqCart.icon(),
                ),
              ),
              body: controller.productDetails != null
                  ? Column(
                      children: <Widget>[
                        Gap(16.0),
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: controller.refreshDetails,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ProductImagesSliderWidget(
                                    productImageList:
                                        controller.productDetails?.images ??
                                            <Images>[],
                                  ),
                                  ProductInfoWidget(
                                    tag: tag,
                                  ).paddingSymmetric(
                                      horizontal: 16, vertical: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Product Sizes'.tr,
                                        style: mullerW500.copyWith(
                                          color: AppColors.black,
                                          fontSize: 18,
                                        ),
                                      ).paddingSymmetric(horizontal: 16),
                                      Gap(8),
                                      ProductSizeSelectionWidget(
                                        sizeData: controller
                                                .productDetails?.sizeData ??
                                            <ProductSizeModel>[],
                                        onSelect:
                                            (final ProductSizeModel? size) {
                                          controller.onSelectSize(size);
                                        },
                                        selectedSize: controller.selectedSize,
                                      ).paddingSymmetric(horizontal: 16),
                                    ],
                                  ),
                                  Gap(20),
                                  Visibility(
                                    visible: controller
                                        .arrSimilarProducts.isNotEmpty,
                                    child: MoreItemsWidget(
                                      tag: tag,
                                    ).paddingOnly(
                                        left: 16, right: 16, bottom: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap(12),
                        AddItemWidget(
                          tag: tag,
                        ),
                        Gap(MediaQuery.of(context).padding.bottom > 0
                            ? MediaQuery.of(context).padding.bottom
                            : 16),
                      ],
                    )
                  : controller.isLoading
                      ? SizedBox()
                      : NoItemFoundWidget(
                          image: Assets.svg.icNoProduct,
                          message: 'No Details Found.'.tr),
            );
          },
        ),
      ),
    );
  }
}
