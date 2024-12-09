import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/offer_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/create_offer_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/delete_offer_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/offer_list_cell.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OnGoingOffersWidget extends StatelessWidget {
  const OnGoingOffersWidget({super.key, required this.onClickedAddOffer});

  final VoidCallback onClickedAddOffer;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (final ProductDetailsController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Ongoing Offers'.tr,
              style: mullerW400.copyWith(
                color: AppColors.color677A81,
                fontSize: 16,
              ),
            ),
            Gap(16.0),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                itemBuilder: (final BuildContext context, final int index) {
                  final ProductOffer item = controller.arrOffers[index];
                  return OfferListCell(
                    offer: item,
                    currency: controller.productDetails?.currency ??
                        '${AppConstants.defaultCurrency}',
                    onTapEdit: () {
                      Get.bottomSheet(
                        CreateOfferBottomSheet(
                          offer: item,
                        ),
                        barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
                        isScrollControlled: true,
                      );
                    },
                    onTapDelete: () {
                      Get.bottomSheet(
                        DeleteOfferBottomSheet(
                          onTapDelete: () {
                            Get.back();
                            controller.deleteOffer(offerId: item.id.toString());
                          },
                        ),
                        barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
                      );
                    },
                    isEditable: controller.isEditable,
                  );
                },
                separatorBuilder:
                    (final BuildContext context, final int index) {
                  return SizedBox(
                    height: 16,
                  );
                },
                itemCount: controller.arrOffers.length),
            Gap(16.0),
            (controller.arrOffers.isEmpty && controller.isEditable)
                ? _addOfferWidget()
                : SizedBox(),
          ],
        );
      },
    );
  }

  Widget _addOfferWidget() {
    return GestureDetector(
      onTap: onClickedAddOffer,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(0.5),
        color: AppColors.color2E236C,
        strokeWidth: 1,
        dashPattern: <double>[3, 8.5],
        borderPadding: EdgeInsets.zero,
        stackFit: StackFit.passthrough,
        strokeCap: StrokeCap.round,
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.colorD0E4EE.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                Assets.svg.icOfferRoundedCorner,
                height: 30,
                width: 30,
              ),
              Gap(12),
              Text(
                'No Offers Added.'.tr,
                style: mullerW400.copyWith(
                  color: AppColors.color1679AB,
                  fontSize: 12,
                ),
              ),
              Text(
                'Click here to Add one.'.tr,
                style: mullerW400.copyWith(
                  color: AppColors.color1679AB,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
