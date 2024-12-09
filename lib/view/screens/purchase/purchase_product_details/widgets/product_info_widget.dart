import 'package:atobuy_vendor_flutter/controller/purchase/purchase_product_details_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/readmore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key, required this.tag});

  final String tag;
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<PurchaseProductDetailsController>(
      tag: tag,
      builder: (final PurchaseProductDetailsController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ReadMoreText(
              controller.productDetails?.getProductTitle() ?? '-',
              trimMode: TrimMode.line,
              trimLines: 3,
              colorClickableText: AppColors.colorE72351,
              trimCollapsedText: 'Show more'.tr,
              trimExpandedText: '   ' + 'Show less'.tr,
              style: mullerW500.copyWith(
                fontSize: 18,
                color: AppColors.color171236,
              ),
              moreStyle: mullerW400.copyWith(
                fontSize: 14,
                color: AppColors.colorE72351,
              ),
              lessStyle: mullerW400.copyWith(
                fontSize: 14,
                color: AppColors.colorE72351,
              ),
            ),
            Gap(20),
            Row(
              children: <Widget>[
                Visibility(
                  visible:
                      (controller.productDetails?.offerPrice ?? 0.00) > 0 &&
                          controller.selectedSize == null,
                  child: Text(
                    controller.productDetails?.getActualPrice() ??
                        '0.00 ${AppConstants.defaultCurrency}',
                    style: mullerW400.copyWith(
                        fontSize: 18,
                        color: AppColors.color0B3D56,
                        decoration: TextDecoration.lineThrough),
                  ),
                ),
                Gap(5),
                Text(
                  getPrice(controller),
                  style: mullerW500.copyWith(
                    fontSize: 18,
                    color: AppColors.color171236,
                  ),
                ),
                Gap(8),
                Text(
                  controller.selectedSize != null
                      ? 'Per Size'.trParams(<String, String>{
                          'size': '${controller.selectedSize?.unit ?? ''}',
                        })
                      : '(Per Piece)'.tr,
                  style: mullerW500.copyWith(
                    fontSize: 12,
                    color: AppColors.color0B3D56,
                  ),
                ),
              ],
            ),
            Gap(24),
            Visibility(
              visible: controller.productDetails?.offerValidTill != null &&
                  controller.selectedSize == null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: AppColors.colorD0E4EE.withOpacity(0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Offer Valid Till'.tr,
                          style: mullerW500.copyWith(
                            color: AppColors.color677A81,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          '${controller.productDetails?.offerValidTill.formatDDMMYYYY().formatDDMMYYYY()}',
                          style: mullerW500.copyWith(
                            color: AppColors.color171236,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                ],
              ),
            ),
            Visibility(
              visible:
                  (controller.productDetails?.minimumOrderAmount ?? 0.00) > 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        color: AppColors.colorD0E4EE.withOpacity(0.5)),
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Free Delivery Offer'.tr,
                          style: mullerW500.copyWith(
                            color: AppColors.color171236,
                            fontSize: 12,
                          ),
                        ),
                        Gap(12),
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(Assets.svg.icDelivery),
                            Gap(12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Minimum Order Amount to get free delivery:'
                                              .trParams(<String, String>{
                                        'currency': controller.productDetails
                                                ?.getMinimumOrderAmount() ??
                                            '0.00 ${AppConstants.defaultCurrency}'
                                      }),
                                      style: mullerW400.copyWith(
                                        color: AppColors.color0B3D56,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(16),
                ],
              ),
            ),
            Text(
              'About This Product'.tr,
              style: mullerW500.copyWith(
                color: AppColors.color171236,
                fontSize: 12,
              ),
            ),
            Gap(8),
            ReadMoreText(
              controller.productDetails?.description ?? '-',
              trimMode: TrimMode.line,
              trimLines: 4,
              colorClickableText: AppColors.color171236,
              trimCollapsedText: 'Show more'.tr,
              trimExpandedText: '   ' + 'Show less'.tr,
              style: mullerW400.copyWith(
                color: AppColors.color0B3D56,
                fontSize: 14,
              ),
              moreStyle: mullerW400.copyWith(
                color: AppColors.colorE72351,
                fontSize: 12,
              ),
              lessStyle: mullerW400.copyWith(
                color: AppColors.colorE72351,
                fontSize: 12,
              ),
            ),
            Gap(16),
            Divider(
              color: AppColors.colorB1D1D3,
              height: 1,
            ),
            Gap(16),
            Visibility(
              visible: controller.productDetails?.owner?.fullName != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Vendor Name'.tr,
                    style: mullerW500.copyWith(
                      color: AppColors.color171236,
                      fontSize: 12,
                    ),
                  ),
                  Gap(12),
                  Text(
                    controller.productDetails?.owner?.fullName ?? '-',
                    style: mullerW500.copyWith(
                      color: AppColors.color171236,
                      fontSize: 14,
                    ),
                  ),
                  Gap(16),
                  Divider(
                    color: AppColors.colorB1D1D3,
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String getPrice(final PurchaseProductDetailsController controller) {
    final String price = controller.selectedSize != null
        ? '${controller.selectedSize?.price ?? '0.00'}'
        : '${controller.productDetails?.offerPrice != null ? controller.productDetails?.offerPrice ?? '' : controller.productDetails?.price ?? ''}';
    return '$price ${controller.productDetails?.currency ?? ''}';
  }
}
