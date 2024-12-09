import 'package:atobuy_vendor_flutter/controller/purchase/purchase_product_details_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddItemWidget extends StatelessWidget {
  const AddItemWidget({super.key, required this.tag});

  final String tag;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<PurchaseProductDetailsController>(
      tag: tag,
      builder: (final PurchaseProductDetailsController controller) {
        return ((controller.productDetails?.quantity ?? 0) >=
                (controller.productDetails?.minimumOrderQuantity ?? 0))
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.colorE8EBEC,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: controller.isDecrementEnable
                                ? () {
                                    controller.onTapDecreaseQty();
                                  }
                                : null,
                            icon: SvgPicture.asset(
                              Assets.svg.icMinusBig,
                              colorFilter: ColorFilter.mode(
                                  controller.isDecrementEnable
                                      ? AppColors.color12658E
                                      : AppColors.color666666.withOpacity(0.5),
                                  BlendMode.srcIn),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.openQtyUpdateDialog();
                              },
                              child: Text(
                                '${controller.itemQty.toString().padLeft(2, "0")}',
                                style: mullerW500.copyWith(
                                    color: AppColors.color20163A),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                maxLines: 5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: controller.isIncrementEnable
                                ? () {
                                    controller.onTapIncreaseQty();
                                  }
                                : null,
                            icon: SvgPicture.asset(
                              Assets.svg.icPlusBig,
                              colorFilter: ColorFilter.mode(
                                  controller.isIncrementEnable
                                      ? AppColors.color12658E
                                      : AppColors.color666666.withOpacity(0.5),
                                  BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(16),
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.color12658E,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.color3D8FB9.withOpacity(0.15),
                            blurRadius: 12,
                            spreadRadius: 0,
                            offset: const Offset(0, 12),
                          )
                        ],
                      ),
                      margin: EdgeInsets.zero,
                      child: TextButton(
                        child: Text(
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          '${'Add Item'.tr}\n ${controller.getTotalPrice()}',
                          style: mullerW700.copyWith(
                              color: AppColors.white, fontSize: 16),
                        ),
                        onPressed: () {
                          controller.addProductsToCart();
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16)
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                width: Get.width,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.colorEC1C50.withOpacity(0.2),
                  border: Border.all(
                    color: AppColors.colorE72351,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    'Out of stock'.tr,
                    style: mullerW700.copyWith(
                        color: AppColors.colorE72351, fontSize: 16),
                  ),
                ),
              );
      },
    );
  }
}
