import 'package:atobuy_vendor_flutter/data/repository/statics_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/static_pages/static_page_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StaticPageController extends GetxController {
  StaticPageController({
    required this.staticRepo,
  });

  final StaticsRepository staticRepo;
  List<Description> staticPagesDetails = <Description>[];
  StaticPages? page;

  @override
  void onInit() {
    super.onInit();
    initialise();
  }

  void initialise() {
    if (Get.arguments != null) {
      if (Get.arguments['page'] != null) {
        if (Get.arguments['page'] is StaticPages) {
          page = Get.arguments['page'];
          getStaticDetail(page?.slug ?? '');
        }
      }
    }
  }

  void openUrl(final Uri links) async => await canLaunchUrl(links)
      ? await launchUrl(links)
      : throw 'Could not launch $links';

  Future<void> getStaticDetail(final String slugName) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);

      final StaticPageDetails result =
          await staticRepo.getStaticPageDetailsApiRequest(slugName);

      staticPagesDetails = <Description>[];
      staticPagesDetails.addAll(result.description ?? <Description>[]);
      update();
      Loader.load(false);
    } catch (e) {
      Loader.load(false);
    }
  }
}
