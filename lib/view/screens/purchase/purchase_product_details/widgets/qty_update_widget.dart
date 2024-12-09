import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class QtyUpdateWidget extends StatelessWidget {
  QtyUpdateWidget(
      {super.key,
      required this.onSubmit,
      required this.itemQty,
      required this.itemMinimumQty,
      required this.itemMaximumQty}) {
    txtItemQtyEc.text = itemQty.toString();
  }

  final Function(int) onSubmit;
  final int itemQty;
  final int itemMinimumQty;
  final int? itemMaximumQty;
  final TextEditingController txtItemQtyEc = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Column(
        children: <Widget>[
          Text(
            'Insert Quantity'.tr,
            style:
                mullerW700.copyWith(color: AppColors.color033E54, fontSize: 16),
          ),
          const Gap(10),
          Text(
            'Please insert the desired quantity'.tr,
            style:
                mullerW500.copyWith(color: AppColors.color033E54, fontSize: 14),
          ),
          const Gap(20),
          SizedBox(
            height: 35,
            child: CommonSearchTextField(
              inputFormatter: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegexHelper.regexDecimal),
                LengthLimitingTextInputFormatter(
                    AppConstants.priceUnitMaxLength),
              ],
              textAlign: TextAlign.center,
              controller: txtItemQtyEc,
              textInputAction: TextInputAction.done,
              hintStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
              labelText: '',
              hintText: itemMaximumQty != null
                  ? '$itemMinimumQty - $itemMaximumQty'
                  : '$itemMinimumQty',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              contentPadding: EdgeInsets.only(bottom: 7.0),
            ).marginSymmetric(horizontal: 40),
          ),
          const Gap(20),
          CommonButton(
            onTap: () {
              final int qty = Parsing.intFrom(txtItemQtyEc.text);
              if (itemMaximumQty != null) {
                if (qty > itemMaximumQty! || qty < itemMinimumQty) {
                  final String message = 'Please enter quantity between'
                      .trParams(<String, String>{
                    'minQty': '$itemMinimumQty',
                    'maxQty': '$itemMaximumQty'
                  });
                  showCustomSnackBar(message: message);
                } else {
                  onSubmit.call(Parsing.intFrom(txtItemQtyEc.text));
                }
              } else {
                if (qty < itemMinimumQty) {
                  final String message =
                      'Please enter quantity greater than or equal'
                          .trParams(<String, String>{
                    'minQty': '$itemMinimumQty',
                  });
                  showCustomSnackBar(message: message);
                } else {
                  onSubmit.call(Parsing.intFrom(txtItemQtyEc.text));
                }
              }
            },
            title: 'Confirm'.tr,
          ).marginSymmetric(horizontal: 60),
          const Gap(10),
          InkWell(
            onTap: () {
              Utility.goBack();
            },
            child: Text(
              'Skip'.tr,
              style: mullerW700.copyWith(
                  color: AppColors.color677A81, fontSize: 14),
            ).paddingAll(10),
          ),
        ],
      ).paddingAll(20),
    );
  }
}
