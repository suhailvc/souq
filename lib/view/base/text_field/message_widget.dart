import 'package:atobuy_vendor_flutter/helper/regex_helper.dart';
import 'package:atobuy_vendor_flutter/view/base/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return CommonTextField(
      minLines: 3,
      maxLines: 3,
      inputFormatter: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegexHelper.nameRegex)
      ],
      allowLeftRightPadding: false,
      validator: (final String? p0) {
        if (p0?.trim().isEmpty ?? false) {
          return 'Please enter message.'.tr;
        } else {
          return null;
        }
      },
      controller: controller,
      labelText: 'Message'.tr,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
    );
  }
}
