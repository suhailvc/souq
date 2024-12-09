import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class NoItemFoundWidget extends StatelessWidget {
  const NoItemFoundWidget(
      {super.key,
      required this.image,
      required this.message,
      this.showOnlyText = false});

  final String image;
  final String message;
  final bool showOnlyText;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: image.isNotNullAndEmpty(),
            child: SvgPicture.asset(
              image,
              width: 150,
              height: 150,
            ),
          ),
          Gap(image.isNotNullAndEmpty() ? 24 : 0),
          Text(
            message,
            textAlign: TextAlign.center,
            style: mullerW400Italic.copyWith(
                fontSize: 15.0, color: AppColors.color12658E),
          ),
        ],
      ),
    );
  }
}
