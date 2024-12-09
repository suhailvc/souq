import 'package:atobuy_vendor_flutter/controller/static_page_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/static_pages/static_page_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:simple_html_css/simple_html_css.dart';

class StaticsDetailChildFaq extends StatelessWidget {
  const StaticsDetailChildFaq({
    super.key,
    required this.description,
  });

  final Description description;

  @override
  Widget build(final BuildContext context) {
    return GetBuilder<StaticPageController>(
        builder: (final StaticPageController controller) {
      return ExpandedTileList.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.staticPagesDetails.length,
        separatorBuilder: (final BuildContext context, final int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              height: 1,
              color: AppColors.colorB1D2E3,
              thickness: 1,
            ),
          );
        },
        itemBuilder: (final BuildContext context, final int buildindex,
            final ExpandedTileController cntlr) {
          return ExpandedTile(
            contentseparator: 0,
            controller: cntlr,
            theme: ExpandedTileThemeData(
              contentBackgroundColor: AppColors.white,
              headerColor: AppColors.white,
              contentPadding: const EdgeInsets.all(0.0),
              trailingPadding: const EdgeInsets.all(0.0),
            ),
            title: Text(
              controller.staticPagesDetails[buildindex].value?.title ?? '',
              style: mullerW500.copyWith(
                  color: AppColors.color1D1D1D, fontSize: 16),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: RichText(
                          text: HTML.toTextSpan(
                            context,
                            controller.staticPagesDetails[buildindex].value
                                    ?.description ??
                                '',
                            linksCallback: (final links) async {
                              controller.openUrl(Uri.parse(links));
                            },
                            defaultTextStyle: mullerW400.copyWith(
                                color: AppColors.color666666, fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
