import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OfferMoreBottomSheet extends StatelessWidget {
  const OfferMoreBottomSheet(
      {super.key, required this.onTapEdit, required this.onTapDelete});

  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;
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
                  Gap(20),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Edit Offer'.tr,
                    prefixSvgIcon: Assets.svg.icEditRoundedCorner,
                    onTap: () {
                      Get.back();
                      onTapEdit.call();
                    },
                  ),
                  ItemWithIconTitleAndRightIconWidget(
                    title: 'Delete Offer'.tr,
                    prefixSvgIcon: Assets.svg.icDeleteRoundedCorner,
                    onTap: () {
                      Get.back();
                      onTapDelete.call();
                    },
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
