import 'package:atobuy_vendor_flutter/controller/auth/login_controller.dart';
import 'package:atobuy_vendor_flutter/controller/auth/signup_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/global_otp_verification_controller.dart';
import 'package:atobuy_vendor_flutter/controller/home_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_details_controller.dart';
import 'package:atobuy_vendor_flutter/controller/shipping_address_controller.dart';
import 'package:atobuy_vendor_flutter/controller/shop_controller.dart';
import 'package:atobuy_vendor_flutter/data/api/dio_client.dart';
import 'package:atobuy_vendor_flutter/data/repository/auth_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/cart_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/global_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/home_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/inventory_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/invoice_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/notification_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/order_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/product_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/shop_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/statics_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/user_repo.dart';
import 'package:atobuy_vendor_flutter/data/repository/wallet_repo.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  // Core
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Get.put(sharedPreferences);
  Get.put(SharedPreferenceHelper());
  Get.lazyPut(() => DioClient(Dio(), sharedPrefHelper: Get.find()));

  // Repository
  Get.lazyPut(
    () => AuthRepo(
      sharedPreferences: Get.find(),
      dioClient: Get.find(),
    ),
    fenix: true,
  );
  Get.lazyPut(
    () => HomeRepo(
      sharedPreferences: sharedPreferences,
      apiClient: Get.find(),
    ),
    fenix: true,
  );
  Get.lazyPut(
    () => StaticsRepository(
      dioClient: Get.find(),
    ),
    fenix: true,
  );

  Get.lazyPut(
    () => GlobalRepository(
      dioClient: Get.find(),
    ),
    fenix: true,
  );

  Get.lazyPut(
      () => UserRepo(
            dioClient: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
      () => ProductRepo(
            dioClient: Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => InventoryRepo(
            dioClient: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
      () => OrderRepo(
            dioClient: Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
      () => ShopRepo(
            Get.find(),
          ),
      fenix: true);
  Get.lazyPut(
      () => CartRepo(
            Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => InvoiceRepo(
            dioClient: Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => WalletRepo(
            dioClient: Get.find(),
          ),
      fenix: true);

  Get.lazyPut(
      () => NotificationRepo(
            dioClient: Get.find(),
          ),
      fenix: true);

  // Controller
  Get.put<GlobalController>(
    GlobalController(
        globalRepository: Get.find(),
        sharedPref: Get.find(),
        cartRepo: Get.find()),
  );
  Get.lazyPut<LoginController>(
    () => LoginController(
      authRepo: Get.find(),
      sharedPreferenceHelper: Get.find(),
      globalController: Get.find(),
    ),
  );
  Get.lazyPut<SignupController>(
    () => SignupController(
      authRepo: Get.find(),
      globalController: Get.find(),
    ),
  );
  Get.lazyPut<OTPVerificationController>(
    () => OTPVerificationController(
        authRepo: Get.find(), sharedPreferenceHelper: Get.find()),
  );
  Get.lazyPut<HomeController>(
    () => HomeController(
        sharedPreferenceHelper: Get.find(), homeRepo: Get.find()),
  );
  Get.lazyPut<ShopController>(
    () => ShopController(
      sharedPref: Get.find(),
      shopRepository: Get.find(),
    ),
  );
  Get.lazyPut<ProductDetailsController>(
    () => ProductDetailsController(
        productRepo: Get.find(), orderRepo: Get.find()),
  );
  Get.lazyPut<ShippingAddressController>(
    () => ShippingAddressController(
        globalController: Get.find(), userRepo: Get.find()),
  );
}
