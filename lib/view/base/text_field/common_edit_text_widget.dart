import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/widgets/vertical_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CommonEditTextWidget extends StatelessWidget {
  const CommonEditTextWidget({
    super.key,
    required this.controller,
    required this.title,
    required this.iconSvg,
    this.validator,
    this.regExp,
    this.textInputType,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String title;
  final String iconSvg;
  final String? Function(String?)? validator;
  final RegExp? regExp;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(regExp ?? RegexHelper.nameRegex)
      ],
      validator: validator,
      controller: controller,
      labelText: title,
      keyboardType: textInputType ?? TextInputType.name,
      textInputAction: textInputAction ?? TextInputAction.next,
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 12),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              iconSvg,
            ),
            Gap(12),
            VerticalDividerWidget(
              height: 50,
              color: AppColors.colorDDECF2,
            ),
          ],
        ),
      ),
    );
  }
}
