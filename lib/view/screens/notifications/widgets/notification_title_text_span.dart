import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:flutter/material.dart';

class NotificationTitleTextSpan extends StatelessWidget {
  const NotificationTitleTextSpan({required this.verb});

  final String verb;

  @override
  Widget build(final BuildContext context) {
    return Text.rich(
      verb.contains(AppConstants.queryDeposit)
          ? TextSpan(
              children:
                  Utility.highlightOccurrences(verb, AppConstants.queryDeposit),
              style: mullerW400.copyWith(
                  color: AppColors.color1679AB, fontSize: 16),
            )
          : verb.contains(AppConstants.queryDeducted)
              ? TextSpan(
                  children: Utility.highlightOccurrences(
                      verb, AppConstants.queryDeducted),
                  style: mullerW400.copyWith(
                      color: AppColors.color1679AB, fontSize: 16),
                )
              : TextSpan(
                  children: Utility.highlightOccurrences(verb, ''),
                  style: mullerW400.copyWith(
                      color: AppColors.color1D1D1D, fontSize: 16),
                ),
    );
  }
}
