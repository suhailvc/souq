import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_list/widgets/bottomsheets/delete_invoice_bottom_sheet.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/widgets/item_with_icon_title_and_right_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceMoreBottomSheet extends StatelessWidget {
  const InvoiceMoreBottomSheet({super.key});

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<InvoiceController>(
      builder: (final InvoiceController controller) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.12),
                      blurRadius: 27.6,
                      spreadRadius: 0,
                      offset: Offset(0, -8),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Gap(20),
                    ItemWithIconTitleAndRightIconWidget(
                      title: 'Delete Invoice'.tr,
                      prefixSvgIcon: Assets.svg.icDeleteRoundedCorner,
                      onTap: () {
                        DeleteInvoiceBottomSheet.show();
                      },
                    ),
                    Gap(50),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void show() {
    Get.bottomSheet(
      InvoiceMoreBottomSheet(),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }
}
