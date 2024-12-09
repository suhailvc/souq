import 'dart:ui';

import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/product_sort_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InventorySortBottomSheet extends StatelessWidget {
  InventorySortBottomSheet(
      {super.key,
      required final SortOptions sortSelectedValue,
      required this.onSubmit,
      required this.onReset}) {
    this.sortSelectedValue.value = sortSelectedValue;
  }

  Rx<SortOptions> sortSelectedValue = SortOptions.newestFirst.obs;

  Function(SortOptions option) onSubmit;
  Function(SortOptions option) onReset;

  List<SortOptions> arrSortBy = <SortOptions>[
    SortOptions.newestFirst,
    SortOptions.oldestFirst
  ];

  @override
  Widget build(final BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Gap(16.0),
                  Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Sort By'.tr,
                              style: mullerW500.copyWith(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      Transform.translate(
                        offset: Offset(0, -10),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: SvgPicture.asset(
                            Assets.svg.icBack,
                            matchTextDirection: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(16.0),
                  ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder:
                          (final BuildContext context, final int index) {
                        return Obx(
                          () => ProductSortRow(
                            selectedSortBy: sortSelectedValue.value,
                            sortBy: arrSortBy[index],
                            onTapSelect: (final SortOptions selectedSort) {
                              sortSelectedValue.value = selectedSort;
                            },
                          ),
                        );
                      },
                      separatorBuilder:
                          (final BuildContext context, final int index) {
                        return Divider(
                          height: 1,
                          color: AppColors.colorB1D2E3,
                        );
                      },
                      itemCount: arrSortBy.length),
                  Divider(
                    height: 1,
                    color: AppColors.colorB1D2E3,
                  ),
                  Gap(24.0),
                  CommonButton(
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      onTap: () {
                        Get.back();
                        onSubmit.call(sortSelectedValue.value);
                      },
                      title: 'Sort Results'.tr),
                  Gap(16.0),
                  CommonButton(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    onTap: () {
                      Get.back();
                      onReset.call(SortOptions.newestFirst);
                    },
                    title: 'Reset'.tr,
                    titleColor: AppColors.color12658E,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.color8ABCD5),
                    ),
                  ),
                  Gap(50.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
