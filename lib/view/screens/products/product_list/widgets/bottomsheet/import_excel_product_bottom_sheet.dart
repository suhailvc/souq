import 'dart:ui';

import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/widgets/bottomsheet/widgets/upload_excel_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ImportExcelProductBottomSheet extends StatelessWidget {
  const ImportExcelProductBottomSheet({super.key});
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductListController>(
        builder: (final ProductListController controller) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: Get.width,
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
                  Gap(24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: SvgPicture.asset(Assets.svg.icBack),
                      ),
                      Spacer(),
                      Text(
                        'Import Excel File'.tr,
                        style: mullerW500.copyWith(
                          fontSize: 18,
                          color: AppColors.color1D1D1D,
                        ),
                      ),
                      Spacer(),
                      Gap(31.0),
                    ],
                  ),
                  Gap(16),
                  UploadExcelWidget(),
                  Gap(16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Continue'.tr,
                        style: mullerW500.copyWith(
                          fontSize: 16,
                          color: AppColors.white,
                        ),
                      ),
                      onPressed: () async {
                        if (controller.productExcelFilePath.isNotEmpty) {
                          await controller.uploadProductListFile(
                              filePath: controller.productExcelFilePath);
                        } else {
                          showCustomSnackBar(
                              message: 'Please Select File'.tr, isError: true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color12658E,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        elevation: 5,
                        shadowColor: AppColors.black,
                      ),
                    ),
                  ),
                  Gap(38),
                  RichText(
                    text: TextSpan(children: <InlineSpan>[
                      TextSpan(
                        text: 'Click here to'.tr,
                        style: mullerW400.copyWith(
                            fontSize: 14, color: AppColors.color3D8FB9),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                          text: 'Download Template'.tr,
                          style: mullerW400.copyWith(
                              fontSize: 14,
                              color: AppColors.color1D1D1D,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              controller.downloadSampleFile();
                            }),
                    ]),
                  ),
                  Gap(40),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  static void show() {
    Get.bottomSheet(ImportExcelProductBottomSheet(),
        barrierColor: AppColors.colorE8EBEC.withOpacity(0.85),
        isScrollControlled: true);
  }
}
