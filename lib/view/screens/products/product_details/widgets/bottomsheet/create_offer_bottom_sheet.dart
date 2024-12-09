import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/offer_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/double_ext.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/widgets/bottomsheet/widgets/product_bottom_sheet_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateOfferBottomSheet extends StatelessWidget {
  CreateOfferBottomSheet({super.key, this.offer});

  final ProductOffer? offer;
  @override
  Widget build(final BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
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
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      icon: SvgPicture.asset(
                        Assets.svg.icBack,
                        width: 24,
                        height: 24,
                      ),
                    ),
                    Text(
                      offer == null ? 'Create Offer'.tr : 'Edit Offer'.tr,
                      style: mullerW500.copyWith(
                        fontSize: 18,
                        color: AppColors.color171236,
                      ),
                    ),
                    Gap(56),
                  ],
                ),
                Gap(12),
                ProductBottomSheetItemWidget(),
                Gap(16),
                GetBuilder<ProductDetailsController>(initState:
                    (final GetBuilderState<ProductDetailsController> state) {
                  Get.find<ProductDetailsController>().resetOfferBottomSheet();
                  manageEditOffer(Get.find<ProductDetailsController>());
                }, builder: (final ProductDetailsController controller) {
                  return Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: AppColors.colorB1D2E3)),
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(Assets.svg.icOfferDiscountPrice),
                            Gap(15),
                            VerticalDividerWidget(height: 34),
                            Gap(15),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Percentage'.tr,
                                    style: mullerW500.copyWith(
                                        color: AppColors.color8ABCD5,
                                        fontSize: 14.0),
                                  ),
                                  _percentageField(controller),
                                ],
                              ),
                            ),
                            Gap(12),
                            VerticalDividerWidget(height: 34),
                            Gap(12),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Discounted Price'.tr,
                                    style: mullerW500.copyWith(
                                        color: AppColors.color8ABCD5,
                                        fontSize: 14.0),
                                  ),
                                  _discountField(controller),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(16.0),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: AppColors.colorB1D2E3)),
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: <Widget>[
                            SvgPicture.asset(Assets.svg.icOfferValidity),
                            Gap(15),
                            VerticalDividerWidget(height: 34),
                            Gap(15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Date'.tr,
                                    style: mullerW500.copyWith(
                                        color: AppColors.color8ABCD5,
                                        fontSize: 14.0),
                                  ),
                                  _dateRangeField(controller),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
                Gap(32),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    child: Text(
                      'Save & Submit Changes'.tr,
                      style: mullerW500.copyWith(
                        fontSize: 16,
                        color: AppColors.white,
                      ),
                    ),
                    onPressed: () {
                      Get.find<ProductDetailsController>()
                          .onTapCreateOffer(offerId: offer?.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.color12658E,
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
                Gap(48),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _discountField(final ProductDetailsController controller) {
    return SizedBox(
      height: 35,
      child: CommonSearchTextField(
        enabled: false,
        key: controller.formDiscount,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: controller.txtDiscountAmount,
        style: mullerW700.copyWith(fontSize: 16, color: AppColors.color171236),
        textInputAction: TextInputAction.search,
        onChange: (final String value) {
          controller.onChangeDiscountedAmount(value);
        },
        hintStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
        labelText: '0.00',
        contentPadding: EdgeInsets.only(bottom: 9.0),
        borderColor: Colors.transparent,
        suffixIcon: Padding(
          padding: EdgeInsetsDirectional.only(end: 3),
          child: Text(
            Get.find<GlobalController>().priceRangeData?.currencySymbol ??
                AppConstants.defaultCurrency,
            textDirection: TextDirection.ltr,
            style:
                mullerW700.copyWith(fontSize: 16, color: AppColors.color171236),
          ),
        ),
        prefixIcon: SizedBox(
          width: 0,
        ),
        inputFormatter: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegexHelper.regexDecimal),
        ],
      ),
    );
  }

  Widget _percentageField(final ProductDetailsController controller) {
    return SizedBox(
      height: 30,
      child: CommonSearchTextField(
          key: controller.formPercentage,
          textAlign: TextAlign.start,
          controller: controller.txtPercentage,
          textInputAction: TextInputAction.done,
          onChange: (final String value) {
            controller.onChangePercentageValue(value);
          },
          prefixIcon: SizedBox(
            width: 0,
          ),
          hintStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
          labelText: '0.00%',
          borderColor: Colors.transparent,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          contentPadding: EdgeInsets.only(bottom: 7.0),
          inputFormatter: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegexHelper.regexDecimal),
          ]),
    );
  }

  Widget _dateRangeField(final ProductDetailsController controller) {
    return SizedBox(
      height: 30,
      child: CommonSearchTextField(
        onTap: () {
          _openDatePicker(controller);
        },
        readOnly: true,
        textAlign: TextAlign.start,
        controller: controller.txtDates,
        textInputAction: TextInputAction.done,
        onSubmitted: (final String value) {},
        hintStyle:
            mullerW400.copyWith(color: AppColors.color8ABCD5, fontSize: 16),
        labelText: '${'DD/MM/YYYY'.tr} - ${'DD/MM/YYYY'.tr}',
        borderColor: Colors.transparent,
        keyboardType: TextInputType.text,
        prefixIcon: SizedBox(
          width: 0,
        ),
        contentPadding: EdgeInsets.only(bottom: 7.0),
      ),
    );
  }

  Future<void> _openDatePicker(
      final ProductDetailsController controller) async {
    final DateTimeRange? range = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDateRange: controller.fromDate != null && controller.toDate != null
          ? DateTimeRange(start: controller.fromDate!, end: controller.toDate!)
          : null,
    );
    if (range != null) {
      controller.onSelectionChanged(range);
    }
  }

  void manageEditOffer(final ProductDetailsController controller) {
    if (offer != null) {
      if (offer?.amount != null) {
        controller.discountPercentage = double.parse(offer?.amount ?? '0.00');
        final double? truncated =
            controller.discountPercentage?.truncateToDecimalPlaces(2);
        controller.txtPercentage.text = '${truncated}%';
        controller.onChangePercentageValue(truncated.toString());
      }
      if (offer?.fromDate != null && offer?.toDate != null) {
        controller.fromDate = offer?.fromDate;
        controller.toDate = offer?.toDate;
        controller.txtDates.text =
            '${offer?.fromDate.formatDDMMYYYY()} - ${offer?.toDate.formatDDMMYYYY()}';
      }
    }
  }
}
