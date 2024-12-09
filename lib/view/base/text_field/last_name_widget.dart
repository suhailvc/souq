import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LastNameWidget extends StatelessWidget {
  const LastNameWidget({
    super.key,
    required this.controller,
    this.isPrefixIcon,
  });

  final TextEditingController controller;
  final bool? isPrefixIcon;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegexHelper.nameRegex)
      ],
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter last name.'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      labelText: 'Last Name'.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      allowLeftRightPadding: isPrefixIcon,
      prefixIcon: (isPrefixIcon ?? true)
          ? Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svg.icPerson,
                ),
                Gap(12),
                VerticalDividerWidget(
                  height: 50,
                  color: AppColors.colorDDECF2,
                ),
              ],
            )
          : null,
    );
  }
}
