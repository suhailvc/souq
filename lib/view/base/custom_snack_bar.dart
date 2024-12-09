import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(
    {final String? title, final String? message, final bool isError = true}) {
  if (message != null && message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.red : Colors.green,
      title: isError ? 'Error'.tr : 'SOUQ NO1',
      message: message,
      maxWidth: 500,
      duration: const Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 30.0),
      borderRadius: 5.0,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      snackPosition: SnackPosition.TOP,
    ));
  }
}
