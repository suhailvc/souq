import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget addIconBGWithRounded(
      {final double? size, final Color color = Colors.white}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      padding: const EdgeInsets.all(6),
      child: this,
    );
  }
}
