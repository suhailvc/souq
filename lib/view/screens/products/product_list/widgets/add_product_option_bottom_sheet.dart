import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/route_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_button_image.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/import_excel_product_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddProductOptionBottomSheet extends StatelessWidget {
  const AddProductOptionBottomSheet({super.key});

  @override
  Widget build(final BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        width: Get.width,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Gap(100),
            CommonButtonWithImage(
              onTap: () async {
                Utility.goBack();
                Get.find<ProductListController>().resetImportFileDetail();
                ImportExcelProductBottomSheet.show();
              },
              title: 'Import Excel'.tr,
              backgroundColor: AppColors.color12658E,
              suffixWidget: SvgPicture.asset(
                Assets.svg.icImportExcel,
              ),
            ).paddingSymmetric(horizontal: 79.0),
            Gap(14),
            CommonButtonWithImage(
              onTap: () {
                Get.back();
                Get.toNamed(RouteHelper.addNewProduct);
              },
              title: 'Add Manually'.tr,
              backgroundColor: AppColors.color12658E,
              suffixWidget: SvgPicture.asset(
                Assets.svg.icAddManually,
              ),
            ).paddingSymmetric(horizontal: 79.0),
            Gap(14),
            IconButton(
              padding: EdgeInsets.all(18),
              onPressed: () {
                Get.back();
              },
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: AppColors.color2E236C,
              ),
              icon: SvgPicture.asset(
                fit: BoxFit.contain,
                Assets.svg.icClose,
              ),
            ),
            Gap(50),
          ],
        ),
      ),
    );
  }

  static void show() {
    Get.bottomSheet(
      AddProductOptionBottomSheet(),
      barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
    );
  }
}
