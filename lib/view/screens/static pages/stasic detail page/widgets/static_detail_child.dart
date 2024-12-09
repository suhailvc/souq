import 'package:atobuy_vendor_flutter/controller/static_page_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/static_pages/static_page_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:simple_html_css/simple_html_css.dart';

class StaticsDetailChild extends StatelessWidget {
  const StaticsDetailChild({
    super.key,
    required this.description,
  });

  final Description description;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<StaticPageController>(
        builder: (final StaticPageController controller) {
      return Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: HTML.toTextSpan(
                context,
                description.value?.title ?? '',
                defaultTextStyle: mullerW500.copyWith(
                    color: AppColors.color333333, fontSize: 16),
                linksCallback: (final dynamic links) async {
                  controller.openUrl(Uri.parse(links));
                },
              ),
            ),
            Gap(10),
            RichText(
              text: HTML.toTextSpan(
                context,
                description.value?.description ?? '',
                defaultTextStyle: mullerW400.copyWith(
                    color: AppColors.color333333, fontSize: 14),
                linksCallback: (final links) async {
                  controller.openUrl(Uri.parse(links));
                },
              ),
            ),
            Gap(description.value?.image != null ? 10 : 0),
            CachedNetworkImage(
              imageUrl: description.value?.image ?? '',
              imageBuilder: (final BuildContext context,
                  final ImageProvider<Object> imageProvider) {
                return Image(
                  height: Get.width,
                  image: imageProvider,
                  fit: BoxFit.cover,
                );
              },
              errorWidget: (final BuildContext context, final String url,
                  final Object error) {
                return SizedBox();
              },
            )
          ],
        ),
      );
    });
  }
}
