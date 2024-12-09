import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/widgets/product_bottom_sheet_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class DeleteProductBottomSheet extends StatelessWidget {
  const DeleteProductBottomSheet({super.key, required this.onTapDelete});

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
            width: Get.width,
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
                Gap(24),
                SvgPicture.asset(
                  Assets.svg.icDeleteBig,
                  width: 36,
                  height: 36,
                ),
                Gap(16),
                Text(
                  'Are you sure you want to delete?'.tr,
                  style: mullerW400.copyWith(
                    color: AppColors.color171236,
                    fontSize: 18,
                  ),
                ),
                Gap(12),
                ProductBottomSheetItemWidget(),
                Gap(12),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    child: Text(
                      'Yes, Delete Product'.tr,
                      style: mullerW500.copyWith(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                    onPressed: onTapDelete,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.colorE52551,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      elevation: 5,
                      shadowColor: AppColors.black,
                    ),
                  ),
                ),
                Gap(12),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'No, Don’t Delete'.tr,
                      style: mullerW500.copyWith(
                        fontSize: 16,
                        color: AppColors.color12658E,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        width: 1,
                        color: AppColors.color12658E,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      elevation: 5,
                      shadowColor: AppColors.black,
                    ),
                  ),
                ),
                Gap(50),
              ],
            ),
          ),
        ],
      );
    });
  }
}
