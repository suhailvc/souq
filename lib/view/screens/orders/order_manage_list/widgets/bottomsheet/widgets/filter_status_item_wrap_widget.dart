import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class FilterStatusItemWrapWidget<T> extends StatelessWidget {
  const FilterStatusItemWrapWidget({
    super.key,
    required this.list,
    required this.getPrintableText,
    required this.selectedItem,
    required this.onSelectItem,
    this.iconWithTitle = false,
  });

  final List<T> list;
  final String Function(T item) getPrintableText;
  final T? selectedItem;
  final Function(T) onSelectItem;
  final bool iconWithTitle;
  @override
  Widget build(final BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: list.map<Widget>(
        (final T e) {
          return GestureDetector(
            onTap: () {
              onSelectItem.call(e);
            },
            child: Container(
              height: 35,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color:
                    selectedItem == e ? AppColors.color12658E : AppColors.white,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: selectedItem == e
                        ? AppColors.color12658E
                        : AppColors.color2E236C),
              ),
              child: (iconWithTitle == false)
                  ? Column(
                      children: <Widget>[
                        Spacer(),
                        Text(
                          getPrintableText(e),
                          style: selectedItem == e
                              ? mullerW500.copyWith(
                                  fontSize: 16, color: AppColors.white)
                              : mullerW400.copyWith(
                                  fontSize: 16, color: AppColors.color12658E),
                        ),
                        Spacer(),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(Assets.svg.icOnlinePayment),
                        Gap(3),
                        Column(
                          children: <Widget>[
                            Spacer(),
                            Text(
                              getPrintableText(e),
                              style: selectedItem == e
                                  ? mullerW500.copyWith(
                                      fontSize: 16, color: AppColors.white)
                                  : mullerW400.copyWith(
                                      fontSize: 16,
                                      color: AppColors.color12658E),
                            ),
                            Spacer(),
                          ],
                        )
                      ],
                    ),
            ),
          );
        },
      ).toList(),
    );
  }
}
