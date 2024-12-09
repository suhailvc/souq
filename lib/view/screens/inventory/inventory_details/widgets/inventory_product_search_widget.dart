import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InventoryProductSearchWidget extends StatelessWidget {
  const InventoryProductSearchWidget(
      {super.key,
      required this.txtSearchProduct,
      required this.onSubmitSearch,
      required this.onChangeSearchText});

  final TextEditingController txtSearchProduct;
  final Function(String) onSubmitSearch;
  final Function(String) onChangeSearchText;
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.white,
      child: SizedBox(
        height: 45.0,
        child: CommonSearchTextField(
          textAlign: TextAlign.start,
          controller: txtSearchProduct,
          contentPadding: EdgeInsets.only(bottom: 9.0),
          prefixIcon: SvgPicture.asset(
            Assets.svg.icSearch,
            matchTextDirection: true,
          ).marginOnly(right: 14, left: 14),
          suffixIcon: txtSearchProduct.text.isNotNullAndEmpty()
              ? InkWell(
                  onTap: () {
                    onSubmitSearch('');
                  },
                  child: SvgPicture.asset(
                    Assets.svg.icClose,
                    colorFilter: ColorFilter.mode(
                        AppColors.color757474, BlendMode.srcIn),
                    matchTextDirection: true,
                  ).marginOnly(right: 14, left: 14),
                )
              : SizedBox(),
          textInputAction: TextInputAction.search,
          onSubmitted: (final String value) {
            onSubmitSearch.call(value);
          },
          onChange: (final String string) {
            onChangeSearchText.call(string);
          },
          hintStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
          labelText: 'Search'.tr,
        ),
      ),
    );
  }
}
