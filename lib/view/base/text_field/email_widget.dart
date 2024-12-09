import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    super.key,
    required this.controller,
    this.readOnly,
    this.isPrefixIcon,
  });

  final TextEditingController controller;
  final bool? readOnly;
  final bool? isPrefixIcon;
  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      validator: (final String? p0) {
        if (p0?.isEmpty ?? false) {
          return 'Please enter email.'.tr;
        } else if (!(p0 ?? '').isEmail) {
          return 'Please enter valid email.'.tr;
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      readOnly: readOnly ?? false,
      controller: controller,
      labelText: 'Email'.tr,
      textInputAction: TextInputAction.next,
      textCapitalization: TextCapitalization.none,
      allowLeftRightPadding: isPrefixIcon,
      prefixIcon: (isPrefixIcon ?? true)
          ? Row(
              children: <Widget>[
                SvgPicture.asset(
                  Assets.svg.icEmail,
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
