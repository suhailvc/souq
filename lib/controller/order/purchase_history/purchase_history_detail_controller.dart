import 'dart:io';

import 'package:atobuy_vendor_flutter/data/repository/order_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/order/order_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PurchaseHistoryDetailController extends GetxController {
  PurchaseHistoryDetailController({
    required this.orderRepo,
  });

  final OrderRepo orderRepo;
  OrderDetailsModel? orderDetails;
  String orderId = '';
  bool isDetailsLoading = true;

  @override
  void onInit() {
    super.onInit();
    manageArguments();
  }

  void manageArguments() {
    if (Get.arguments != null) {
      if (Get.arguments['order_id'] != null) {
        orderId = Get.arguments['order_id'];
        if (orderId != '') {
          getOrderDetails(orderId: orderId);
        }
      }
    }
  }

  Future<void> getOrderDetails({required final String orderId}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      await orderRepo.getOrderDetails(
        orderId: orderId,
        param: <String, dynamic>{},
      ).then((final OrderDetailsModel value) {
        Loader.load(false);
        orderDetails = value;
        isDetailsLoading = false;
        update();
      });
    } catch (e) {
      Loader.load(false);
      isDetailsLoading = false;
      update();
    }
  }

  Future<void> contactUs() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      Loader.load(true);
      await orderRepo.contactUs(parameter: <String, dynamic>{
        'order': orderDetails?.id ?? '',
      });
      Loader.load(false);
    } catch (e) {
      Loader.load(false);
    }
  }

  Future<void> openWhatsApp(final String orderId) async {
    String phoneNumberCode = AppConstants.contactUsWhatsAppPhone;

    phoneNumberCode = phoneNumberCode.replaceAll('+', '');
    final String message =
        'Hi, I\'m checking on the status of my order $orderId. Can you please update me? Thanks!';

    final Uri url =
        Uri.parse('whatsapp://send?phone=$phoneNumberCode&text=$message');
    final Uri storeUrl = Uri.parse(Platform.isAndroid
        ? AppConstants.whatsappPlayStoreUrl
        : AppConstants.whatsappAppStoreUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (await canLaunchUrl(storeUrl)) {
        await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $storeUrl';
      }
      throw 'Could not launch $url';
    }
  }
}
