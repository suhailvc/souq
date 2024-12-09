import 'package:atobuy_vendor_flutter/controller/static_page_controller.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/stasic%20detail%20page/widgets/static_detail_child.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/stasic%20detail%20page/widgets/static_detail_child_faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class StaticDetailScreen extends StatelessWidget {
  const StaticDetailScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<StaticPageController>(
            init: StaticPageController(staticRepo: Get.find()),
            builder: (final StaticPageController controller) {
              return Scaffold(
                appBar: AppbarWithBackIconAndTitle(
                  title: controller.page?.title.tr ?? '',
                ),
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: controller.staticPagesDetails.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder:
                                (final BuildContext context, final int index) {
                              return (controller.page?.slug ?? '')
                                      .contains(StaticPages.faqs.slug)
                                  ? StaticsDetailChildFaq(
                                      description:
                                          controller.staticPagesDetails[index])
                                  : StaticsDetailChild(
                                      description:
                                          controller.staticPagesDetails[index]);
                            },
                            itemCount: controller.staticPagesDetails.length,
                            separatorBuilder:
                                (final BuildContext context, final int index) {
                              return Gap(10);
                            },
                          )
                        : SizedBox(),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
