import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/product/product_filter_model.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FilterPriceWidget extends StatelessWidget {
  const FilterPriceWidget({
    super.key,
    required this.controller,
    required this.priceRangeData,
    this.onChange,
  });

  final TextEditingController controller;
  final PriceRangeData? priceRangeData;
  final Function(String)? onChange;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<GlobalController>(
        builder: (final GlobalController globalController) {
      return CommonSearchTextField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        controller: controller,
        labelText: '0.00',
        inputFormatter: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegexHelper.regexDecimal),
        ],
        textInputAction: TextInputAction.done,
        style: mullerW500.copyWith(
          fontSize: 16.0,
          color: AppColors.color171236,
        ),
        onChange: onChange,
        textCapitalization: TextCapitalization.none,
        contentPadding: EdgeInsets.only(bottom: 15.0),
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            globalController.priceRangeData?.currencySymbol ??
                AppConstants.defaultCurrency,
            textDirection: TextDirection.ltr,
            style: mullerW500.copyWith(
              fontSize: 14.0,
              color: AppColors.color171236,
            ),
          ),
        ),
      );
    });
  }
}
