import 'dart:io';

import 'package:atobuy_vendor_flutter/controller/product/add_product_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/utils/utility.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UploadPhotosWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder<AddProductController>(
        builder: (final AddProductController controller) {
      return Column(
        children: <Widget>[
          controller.mainImage == null
              ? GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.onTapUploadMainImage();
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
                      height: 363,
                      decoration: BoxDecoration(
                        color: AppColors.colorD0E4EE.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SvgPicture.asset(
                              Assets.svg.icUploadImage,
                              colorFilter: ColorFilter.mode(
                                  AppColors.color8ABCD5, BlendMode.srcIn),
                            ),
                            Gap(12.0),
                            Text(
                              'Click here to Upload Main Image'.tr,
                              style: mullerW400.copyWith(
                                  fontSize: 12, color: AppColors.color8ABCD5),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : HeaderImage(),
          Gap(16.0),
          ImageList()
        ],
      );
    });
  }

  Widget ImageList() {
    final int mediaCount = Get.find<AddProductController>().arrSubImages.length;

    return Column(
      children: <Widget>[
        Text(
          'Click here to Upload Sub Image'.tr,
          style:
              mullerW400.copyWith(fontSize: 12, color: AppColors.color8ABCD5),
        ),
        Gap(16.0),
        SizedBox(
          height: 75,
          child: ListView.separated(
            separatorBuilder: (final BuildContext context, final int index) {
              return SizedBox(width: index == 4 ? 0 : 14.96);
            },
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (final BuildContext context, final int index) {
              if (index >= mediaCount) {
                return AddNewImage();
              }
              return ImageCell(index);
            },
          ),
        ),
      ],
    );
  }

  Widget HeaderImage() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Utility.checkIsNetworkUrl(
                Get.find<AddProductController>().mainImage?.image ?? '')
            ? CachedNetworkImage(
                imageUrl:
                    Get.find<AddProductController>().mainImage?.image ?? '',
                imageBuilder: (final BuildContext context,
                    final ImageProvider<Object> imageProvider) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    height: 363,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                errorWidget: (final BuildContext context, final String url,
                    final Object error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 363,
                      width: Get.width,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorB1D2E3, width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CommonImagePlaceholderImage(),
                    ),
                  );
                },
              )
            : Container(
                clipBehavior: Clip.hardEdge,
                height: 363,
                width: Get.width,
                decoration: BoxDecoration(
                  color: AppColors.colorDFE6E9.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ImageFile(
                    imagePath:
                        Get.find<AddProductController>().mainImage?.image ??
                            ''),
              ),
        Positioned(
          right: 0,
          top: 0,
          child: DeleteImage(onTapDelete: () {
            Get.find<AddProductController>().deleteCoverImage();
          }),
        )
      ],
    );
  }

  Widget ImageCell(final int index) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Utility.checkIsNetworkUrl(
                Get.find<AddProductController>().arrSubImages[index].image ??
                    '')
            ? CachedNetworkImage(
                imageUrl: Get.find<AddProductController>()
                        .arrSubImages[index]
                        .image ??
                    '',
                imageBuilder: (final BuildContext context,
                    final ImageProvider<Object> imageProvider) {
                  return Container(
                    height: 59,
                    width: 59,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                errorWidget: (final BuildContext context, final String url,
                    final Object error) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      height: 59,
                      width: 59,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.colorB1D2E3, width: 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: CommonImagePlaceholderImage(),
                    ),
                  );
                },
              )
            : Container(
                clipBehavior: Clip.hardEdge,
                width: 59,
                height: 59,
                decoration: BoxDecoration(
                  color: AppColors.colorDFE6E9.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ImageFile(
                    imagePath: Get.find<AddProductController>()
                            .arrSubImages[index]
                            .image ??
                        ''),
              ),
        Positioned(
          bottom: -13,
          child: DeleteImage(onTapDelete: () {
            Get.find<AddProductController>().deleteImageFromSubImages(index);
          }),
        )
      ],
    );
  }

  Widget AddNewImage() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(Get.context!).unfocus();
        Get.find<AddProductController>().onTapUploadSubImage();
      },
      child: Center(
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(12.0),
          color: AppColors.colorB1D2E3,
          strokeWidth: 2,
          dashPattern: <double>[4, 6],
          padding: EdgeInsets.zero,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.colorD0E4EE.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            width: 59,
            height: 59,
            child: Center(
              child: SvgPicture.asset(
                Assets.svg.icAddSubImage,
                colorFilter:
                    ColorFilter.mode(AppColors.color8ABCD5, BlendMode.srcIn),
              ),
            ),
          ),
        ),
      ),
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

  Widget ImageFile({required final String imagePath}) {
    return Image.file(
      fit: BoxFit.cover,
      File(imagePath),
      errorBuilder: (final BuildContext context, final Object error,
          final StackTrace? stackTrace) {
        return Center(
          child: Text(
            'This image type is not supported'.tr,
            style: mullerW400.copyWith(fontSize: 12),
          ),
        );
      },
    );
  }
}
