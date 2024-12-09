import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class BusinessCategoryRow extends StatelessWidget {
  const BusinessCategoryRow(
      {super.key,
      required this.title,
      required this.logo,
      required this.onTapType,
      required this.isSelected});

  final String? title;
  final String? logo;
  final VoidCallback onTapType;
  final bool isSelected;
  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTapType,
      child: SizedBox(
        width: 75,
        child: Column(
          children: <Widget>[
            Container(
              height: 65,
              width: 65,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.5),
                color: AppColors.colorEEF5F5,
                border: Border.all(
                  width: isSelected ? 2.0 : 0,
                  color:
                      isSelected ? AppColors.color3D8FB9 : Colors.transparent,
                ),
              ),
              child: logo != null
                  ? CachedNetworkImage(
                      imageUrl: logo ?? '',
                      imageBuilder: (final BuildContext context,
                              final ImageProvider<Object> imageProvider) =>
                          Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.5),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder:
                          (final BuildContext context, final String url) =>
                              _placeholder(),
                      errorWidget: (final BuildContext context,
                              final String url, final Object error) =>
                          _placeholder(),
                    )
                  : title == 'All'.tr
                      ? _optionForAll()
                      : _placeholder(),
            ),
            Gap(5),
            Text(
              title?.capitalizeFirst ?? '-',
              style: mullerW500.copyWith(
                  color: isSelected ? AppColors.color3D8FB9 : AppColors.black,
                  fontSize: 12.0),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return SizedBox(
      height: 65,
      width: 65,
      child: CommonImagePlaceholderWidget(
        padding: EdgeInsets.all(10),
        borderRadius: BorderRadius.circular(32.5),
      ),
    );
  }

  Widget _optionForAll() {
    return SizedBox(
      height: 65,
      width: 65,
      child: SvgPicture.asset(
        Assets.svg.icMore,
        colorFilter: ColorFilter.mode(AppColors.color3D8FB9, BlendMode.srcIn),
      ).paddingAll(14),
    );
  }
}
