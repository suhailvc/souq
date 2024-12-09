import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/offer_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/double_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/offer_more_option_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OfferListCell extends StatelessWidget {
  const OfferListCell(
      {super.key,
      required this.offer,
      required this.currency,
      required this.onTapEdit,
      required this.onTapDelete,
      required this.isEditable});

  final ProductOffer offer;
  final String currency;

  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  final bool isEditable;
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 12, bottom: 12, start: 12),
      decoration: BoxDecoration(
        color: AppColors.colorD0E4EE.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.colorB1D2E3,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              SvgPicture.asset(
                Assets.svg.icOfferRoundedCorner,
                width: 30,
                height: 30,
              ),
              Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Percentage'.tr,
                    style: mullerW700.copyWith(
                      color: AppColors.color3D8FB9,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${offer.amount}%',
                    style: mullerW700.copyWith(
                      color: AppColors.color171236,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Gap(24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Discounted Price'.tr,
                    style: mullerW700.copyWith(
                      color: AppColors.color3D8FB9,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${_discountedPrice()} $currency',
                    style: mullerW700.copyWith(
                      color: AppColors.color171236,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              isEditable ? Spacer() : SizedBox(),
              isEditable
                  ? IconButton(
                      onPressed: () {
                        Get.bottomSheet(
                          OfferMoreBottomSheet(
                            onTapEdit: onTapEdit,
                            onTapDelete: onTapDelete,
                          ),
                          barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
                        );
                      },
                      icon: SvgPicture.asset(
                        Assets.svg.icMore,
                        width: 20,
                        height: 20,
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Date'.tr,
                style: mullerW700.copyWith(
                  color: AppColors.color3D8FB9,
                  fontSize: 12,
                ),
              ),
              Text(
                '${offer.fromDate.formatDDMMYYYY()} - ${offer.toDate.formatDDMMYYYY()}',
                style: mullerW700.copyWith(
                  color: AppColors.color171236,
                  fontSize: 16,
                ),
              ),
            ],
          ).paddingOnly(left: 46),
        ],
      ),
    );
  }

  double _discountedPrice() {
    final double price = double.parse(
        Get.find<ProductDetailsController>().productDetails?.price ?? '0.0');
    return Get.find<ProductDetailsController>()
        .getDiscountedAmountFromPercentage(
            percentage: double.parse(offer.amount ?? '0.0'), price: price)
        .truncateToDecimalPlaces(2);
  }
}
