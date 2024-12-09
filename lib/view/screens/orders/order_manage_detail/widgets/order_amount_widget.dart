import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class OrderAmountWidget extends StatelessWidget {
  const OrderAmountWidget(
      {super.key, required this.title, required this.amount, this.fontSize});

  final String title;
  final String amount;
  final int? fontSize;
  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          title,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color12658E),
        ),
        Text(
          amount,
          style:
              mullerW500.copyWith(fontSize: 13, color: AppColors.color171236),
        ),
      ],
    );
  }
}
