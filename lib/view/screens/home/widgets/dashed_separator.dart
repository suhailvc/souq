import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashedSeparator extends StatelessWidget {
  const DashedSeparator(
      {this.height = 1, this.color = Colors.white, this.dashWidth = 10.0});
  final double height;
  final double dashWidth;
  final Color color;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final BuildContext context, final BoxConstraints constraints) {
        final double boxWidth = Get.width;
        final double? dashHeight = height;
        final int dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List<Widget>.generate(dashCount, (final int _) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
