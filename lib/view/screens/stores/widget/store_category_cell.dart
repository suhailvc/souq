import 'package:atobuy_vendor_flutter/data/response_models/product/store_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/image_placeholder/common_image_placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StoreCategoryCell extends StatelessWidget {
  const StoreCategoryCell(
      {super.key, required this.category, required this.onTapCategory});

  final Category category;
  final Function(Category) onTapCategory;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onTapCategory(category),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
          border: Border.all(
            color: AppColors.colorB1D2E3,
          ),
        ),
        child: Column(
          children: <Widget>[
            category.icon != null
                ? CachedNetworkImage(
                    imageUrl: category.icon ?? '',
                    imageBuilder: (final BuildContext context,
                            final ImageProvider<Object> imageProvider) =>
                        AspectRatio(
                      aspectRatio: 109 / 85,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    placeholder:
                        (final BuildContext context, final String url) =>
                            _placeholder(),
                    errorWidget: (final BuildContext context, final String url,
                            final Object error) =>
                        _placeholder(),
                  )
                : _placeholder(),
            Gap(8),
            Text(
              category.getName(),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: mullerW500.copyWith(
                  fontSize: 12, color: AppColors.color1D1D1D),
            ).paddingSymmetric(horizontal: 15.0),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return AspectRatio(
      aspectRatio: 109 / 85,
      child: CommonImagePlaceholderWidget(
        backgroundColor: AppColors.color666666.withOpacity(0.05),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
