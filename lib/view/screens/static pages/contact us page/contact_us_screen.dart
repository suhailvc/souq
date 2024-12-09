import 'package:atobuy_vendor_flutter/controller/contact_us_controller.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/common_button.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/contact%20us%20page/widgets/contact_bottom_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/contact%20us%20page/widgets/contact_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: GetBuilder<ContactUsController>(
            initState: (final GetBuilderState<ContactUsController> state) {
          Get.find<ContactUsController>().resetEditProfileFrom();
          Get.find<ContactUsController>().refreshCountryList();
        }, builder: (final ContactUsController controller) {
          return Scaffold(
            appBar: AppbarWithBackIconAndTitle(
              title: 'Contact us'.tr,
            ),
            body: SafeArea(
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    width: Get.width,
                    height: 225,
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Image.asset(
                        Assets.images.mapBg.path,
                        fit: BoxFit.cover,
                      ),
                      Center(child: SvgPicture.asset(Assets.svg.icLocationPin)),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: Get.width,
                      height: Get.height * .6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ContactUsFormWidget(),
                            CommonButton(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                controller.callContactUsApiRequest();
                              },
                              title: 'Send Message'.tr,
                            ),
                            ContactUsBottomWidget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
