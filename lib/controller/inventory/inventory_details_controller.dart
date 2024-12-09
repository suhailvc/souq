import 'package:atobuy_vendor_flutter/data/repository/inventory_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/inventory/inventory_details_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:atobuy_vendor_flutter/view/base/loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InventoryDetailsController extends GetxController {
  InventoryDetailsController({required this.inventoryRepo});

  final InventoryRepo inventoryRepo;

  // Inventory Details
  final TextEditingController txtSearchProduct = TextEditingController();
  String searchText = '';
  InventoryDetailsModel? inventoryDetails;
  String? storeUUID;

  @override
  void onInit() {
    super.onInit();
    initialiseDetails();
  }

  void initialiseDetails() {
    txtSearchProduct.text = '';
    storeUUID = null;
    inventoryDetails = null;
    if (Get.arguments != null) {
      if (Get.arguments['uuid'] != null) {
        storeUUID = Get.arguments['uuid'];
        getInventoryDetails();
      }
    }
  }

  Future<void> getInventoryDetails() async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }
      final Map<String, String> parameter = <String, String>{
        if (searchText.trim().isNotEmpty) 'product_name': searchText.trim()
      };

      await inventoryRepo
          .getInventoryDetails(
        storeUUID: storeUUID ?? '',
        params: parameter,
      )
          .then((final InventoryDetailsModel value) {
        inventoryDetails = value;
        update();
      });
    } catch (e) {
      Loader.load(false);
    }
  }

  void setSearchProductText({required final String text}) {
    FocusScope.of(Get.context!).unfocus();
    txtSearchProduct.text = text;
    searchText = text;
    update();
    getInventoryDetails();
  }
}
