import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BusinessWebsiteTextFieldWidget extends StatelessWidget {
  const BusinessWebsiteTextFieldWidget({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter website url.'.tr;
        }
        if (!(p0?.trim().isURL ?? true)) {
          return 'Please enter valid website url.'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      labelText: 'Business Website'.tr,
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      textInputAction: TextInputAction.done,
      prefixIcon: Row(
        children: <Widget>[
          SvgPicture.asset(
            Assets.svg.icWebsite,
          ),
          Gap(12),
          VerticalDividerWidget(
            height: 50,
            color: AppColors.colorDDECF2,
          ),
        ],
      ),
    );
  }
}
