import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({
    super.key,
    this.onTapFilter,
    this.onTapSort,
    required this.textEditController,
    required this.onSubmitSearch,
    required this.onChangeSearch,
    required this.onClearSearch,
    this.showFilterOption = true,
    this.showSortOption = true,
    this.labelText,
  });

  final VoidCallback? onTapFilter;
  final VoidCallback? onTapSort;
  final TextEditingController textEditController;
  final Function(String) onSubmitSearch;
  final Function(String) onChangeSearch;
  final VoidCallback onClearSearch;
  final bool showFilterOption;
  final bool showSortOption;
  final String? labelText;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Visibility(
          visible: showFilterOption,
          child: IconButton(
            onPressed: onTapFilter,
            icon: SvgPicture.asset(
              Assets.svg.icFilter,
              matchTextDirection: true,
            ),
          ),
        ),
        Gap(showFilterOption ? 12 : 0),
        Expanded(
          child: SizedBox(
            height: 45.0,
            child: CommonSearchTextField(
              textAlign: TextAlign.start,
              controller: textEditController,
              contentPadding: EdgeInsets.only(bottom: 9.0),
              prefixIcon: SvgPicture.asset(
                Assets.svg.icSearch,
                matchTextDirection: true,
              ).marginOnly(right: 14, left: 14),
              textInputAction: TextInputAction.search,
              onSubmitted: (final String value) {
                onSubmitSearch.call(value);
              },
              onChange: (final String value) {
                onChangeSearch.call(value);
              },
              hintStyle: mullerW400.copyWith(color: AppColors.color8ABCD5),
              labelText: labelText ?? 'Search'.tr,
              suffixIcon: textEditController.text != ''
                  ? IconButton(
                      onPressed: onClearSearch,
                      icon: Icon(
                        Icons.clear,
                        size: 20,
                      ),
                    )
                  : SizedBox(),
            ),
          ),
        ),
        Gap(showSortOption ? 12 : 0),
        Visibility(
          visible: showSortOption,
          child: IconButton(
            onPressed: onTapSort,
            icon: SvgPicture.asset(
              Assets.svg.icSort,
              matchTextDirection: true,
            ),
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 8.0, vertical: 16.0);
  }
}
