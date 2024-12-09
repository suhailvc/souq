import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CompanyNameWidget extends StatelessWidget {
  const CompanyNameWidget({
    super.key,
    required this.controller,
    this.image,
  });

  final TextEditingController controller;
  final String? image;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegexHelper.companyNameRegex)
      ],
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter supplier name.'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      labelText: 'Supplier Name'.tr,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      prefixIcon: Row(
        children: <Widget>[
          SvgPicture.asset(
            image ?? Assets.svg.icCompany,
            height: 24,
            width: 24,
            matchTextDirection: true,
          ),
          Gap(12),
          Container(
            height: 50,
            width: 1,
            color: AppColors.colorDDECF2,
          )
        ],
      ),
    );
  }
}
