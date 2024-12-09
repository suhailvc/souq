import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class FilterItemWrapWidget<T> extends StatelessWidget {
  const FilterItemWrapWidget({
    super.key,
    required this.list,
    required this.getPrintableText,
    required this.selectedItem,
    required this.onSelectItem,
    this.isStatus,
  });

  final List<T> list;
  final String Function(T item) getPrintableText;
  final T? selectedItem;
  final Function(T) onSelectItem;
  final bool? isStatus;

  @override
  Widget build(final BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: list.map<Widget>(
        (final T e) {
          return GestureDetector(
            onTap: () {
              onSelectItem.call(e);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: selectedItem == e
                    ? (isStatus ?? false)
                        ? AppColors.color12658E
                        : AppColors.color2E236C
                    : AppColors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: selectedItem == e
                        ? (isStatus ?? false)
                            ? AppColors.color12658E
                            : AppColors.color2E236C
                        : AppColors.colorB1D2E3),
              ),
              child: Text(
                getPrintableText(e),
                style: selectedItem == e
                    ? mullerW500.copyWith(fontSize: 16, color: AppColors.white)
                    : mullerW400.copyWith(
                        fontSize: 16, color: AppColors.color12658E),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
