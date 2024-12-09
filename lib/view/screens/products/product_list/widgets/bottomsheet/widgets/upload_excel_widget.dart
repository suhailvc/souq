import 'package:atobuy_vendor_flutter/controller/product/product_list_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UploadExcelWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<ProductListController>(
        builder: (final ProductListController controller) {
      return Column(
        children: <Widget>[
          controller.productExcelFilePath.isEmpty
              ? GestureDetector(
                  onTap: () async {
                    controller.pickExcelFile();
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12.0),
                    color: AppColors.colorB1D2E3,
                    strokeWidth: 2,
                    dashPattern: <double>[4, 6],
                    padding: EdgeInsets.zero,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 162,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(Assets.svg.icExcelFile),
                            Gap(12.0),
                            Text(
                              'Click here to upload excel sheet of your products'
                                  .tr,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color3D8FB9),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : HeaderImage(controller),
          Gap(16.0),
        ],
      );
    });
  }

  Widget HeaderImage(final ProductListController controller) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          clipBehavior: Clip.hardEdge,
          height: 162,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.color0B3D56),
            color: AppColors.colorD0E4EE.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(Assets.svg.icExcelFileFill),
                Gap(16.0),
                Text(
                  controller.productExcelFileName,
                  style: mullerW500.copyWith(
                      fontSize: 14, color: AppColors.color0B3D56),
                ),
                Gap(8.0),
                Text(
                  controller.productExcelFileSize,
                  style: mullerW400.copyWith(
                      fontSize: 12, color: AppColors.color757474),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: DeleteImage(onTapDelete: () {
            Get.find<ProductListController>().resetImportFileDetail();
          }),
        )
      ],
    );
  }

  Widget DeleteImage({required final VoidCallback onTapDelete}) {
    return IconButton(
      onPressed: () {
        FocusScope.of(Get.context!).unfocus();
        onTapDelete.call();
      },
      icon: SvgPicture.asset(Assets.svg.icDelete),
    );
  }
}
