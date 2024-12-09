import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/common_widget/product_status_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductDetailsMoreBottomSheet extends StatelessWidget {
  const ProductDetailsMoreBottomSheet(
      {super.key,
      required this.onTapEditProduct,
      required this.onTapDeleteProduct});

  final VoidCallback onTapEditProduct;
  final VoidCallback onTapDeleteProduct;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (final ProductDetailsController controller) {
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
                    visible: controller.productDetails?.status ==
                        ProductApprovalStatus.approved,
                    child: ProductStatusWidget(
                      isActive: controller.productDetails?.isActive ?? false,
                      onChangeStatus: controller.toggleProductStatus,
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                      titleFontSize: 16,
                    ).paddingOnly(top: 20),
                  ),
                  Gap(8),
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
