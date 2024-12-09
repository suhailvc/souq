import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_details_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/common_widget/product_status_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductListMoreBottomSheet extends StatelessWidget {
  ProductListMoreBottomSheet(
      {super.key,
      required this.isProductActive,
      required this.productModel,
      required this.onTapEditProduct,
      required this.onTapDeleteProduct});

  RxBool isProductActive = false.obs;
  final ProductDetailsModel productModel;
  final Function() onTapEditProduct;
  final Function() onTapDeleteProduct;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductListController>(
      builder: (final ProductListController controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.12),
                    blurRadius: 27.6,
                    spreadRadius: 0,
                    offset: Offset(0, -8),
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible:
                        productModel.status == ProductApprovalStatus.approved,
                    child: Obx(
                      () => ProductStatusWidget(
                        isActive: isProductActive.value,
                        onChangeStatus: (final bool updatedValue) async {
                          isProductActive.value = updatedValue;
                          isProductActive.value =
                              await controller.productStatusUpdateAPI(
                                  productUUID: productModel.uuid ?? '',
                                  isActive: updatedValue);
                        },
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                        titleFontSize: 16,
                      ).paddingOnly(top: 20),
                    ),
                  ),
                  Gap(8),
                  Visibility(
                    visible: (productModel.status ==
                        ProductApprovalStatus.approved.key),
                    child: ItemWithIconTitleAndRightIconWidget(
                      title: 'Create Offer'.tr,
                      prefixSvgIcon: Assets.svg.icOfferDiscountPrice,
                      onTap: () {},
                    ),
                  ),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Edit Product Details'.tr,
                    prefixSvgIcon: Assets.svg.icEditRoundedCorner,
                    onTap: onTapEditProduct,
                  ),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Delete Product'.tr,
                    prefixSvgIcon: Assets.svg.icDeleteRoundedCorner,
                    onTap: onTapDeleteProduct,
                  ),
                  Gap(50),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
