import 'package:atobuy_vendor_flutter/controller/contact_us_controller.dart';
import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/purchase_history/purchase_history_detail_controller.dart';
import 'package:atobuy_vendor_flutter/controller/order/purchase_history/purchase_history_list_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/product_filter_controller.dart';
import 'package:atobuy_vendor_flutter/controller/product/stores/store_product_controller.dart';
import 'package:atobuy_vendor_flutter/controller/user/user_controller.dart';
import 'package:atobuy_vendor_flutter/controller/wallet/wallet_controller.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/accountcreated/account_created_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/forgot_password/views/forgot_password_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/login/login_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/reset_password/reset_password_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/signup/signup_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/auth/verifyOTP/verify_otp_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/cart_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/checkout_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/place_order/place_order_success_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/global%20pages/global_otp_verification_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/home/home_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_details/inventory_details_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_list/inventory_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/inventory/inventory_list/inventory_list_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_details/invoice_details_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_list/invoice_list_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/notifications/notification_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/assign_driver/assign_driver_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_detail/order_manage_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/order_list_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/orders/order_manage_list/order_manage_list_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/add_new_product/add_new_product_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_details/product_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/product_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/products/product_list/product_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/purchase_product_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/purhcase_history/purchase_history_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/purhcase_history/purchase_history_list_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/purhcase_history/purchase_history_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/search_product_list/search_product_filter_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/search_product_list/search_product_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/add_shipping_address/add_address_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/address_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/contact%20us%20page/contact_us_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/static%20pages/stasic%20detail%20page/static_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/shopproducts/store_product_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/stores/store_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/change_password/change_password_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_personal_address/edit_address_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_profile/edit_profile_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/edit_profile/widgets/edit_profile_verify_otp_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile/profile_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/profile_detail/profile_detail_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/select_store/store_list_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/user/success_screen.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/wallet_all_transaction.dart';
import 'package:atobuy_vendor_flutter/view/screens/wallet/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String home = '/home';
  static const String shop = '/shop';
  static const String wallet = '/wallet';
  static const String walletAllTransaction = '/wallet_all_transaction';
  static const String login = '/login';
  static const String profile = '/profile';
  static const String profileDetail = '/profileDetail';
  static const String forgotPassword = '/forgot_password';
  static const String resetPassword = '/reset_password';
  static const String verificationLinkSent = '/verification_link_sent';
  static const String signUp = '/signUp';
  static const String verifyOTP = '/verifyOTP';
  static const String accountCreated = '/accountCreated';
  static const String globalVerifyOTP = '/globalVerifyOTP';
  static const String addNewProduct = '/add_new_product';
  static const String productDetails = '/product_details';
  static const String productFilter = '/productFilter';
  static const String storeProductList = '/storeProductList';
  static const String editProfile = '/edit_profile';
  static const String successScreen = '/success_screen';
  static const String editAddress = '/edit_address';
  static const String contactUs = '/contact_us';
  static const String staticPageDetail = '/static_page_detail';
  static const String editVerifyOtp = '/editVerifyOtp';
  static const String changePassword = '/changePassword';
  static const String productList = '/productList';
  static const String inventoryList = '/inventory_list';
  static const String inventoryDetails = '/inventory_details';
  static const String orderManageList = '/order_manage_list';
  static const String orderManageDetail = '/order_manage_detail';
  static const String invoiceList = '/invoice_list';
  static const String invoiceDetails = '/invoice_details';
  static const String inventoryFilterScreen = '/inventory_filter_screen';
  static const String orderFilter = '/order_filter';
  static const String purchaseProductDetails = '/purchase_product_details';
  static const String cart = '/cart';
  static const String assignDriver = '/assign_driver';
  static const String checkout = '/checkout';
  static const String placeOrder = '/placeOrder';
  static const String addShippingAddress = '/addShippingAddress';
  static const String shippingAddress = '/shippingAddress';
  static const String searchProductList = '/searchProductList';
  static const String searchProductFilter = '/searchProductFilter';
  static const String purchaseHistory = '/purchase_history';
  static const String purchaseHistoryFilter = '/purchase_history_filter';
  static const String purchaseHistoryDetails = '/purchase_history_details';
  static const String invoiceFilterScreen = '/invoice_filter_screen';
  static const String notificationList = '/notification_list';
  static const String allStoreList = '/all_store_list';

  static List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: login,
      page: () => getRoute(
        const LoginScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: forgotPassword,
      page: () => getRoute(
        const ForgotPasswordScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: resetPassword,
      page: () => getRoute(
        const ResetPasswordScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: home,
      page: () => getRoute(
        const HomeScreen(),
      ),
      transition: Transition.noTransition,
    ),
    GetPage<dynamic>(
      name: profile,
      page: () => getRoute(
        const ProfileScreen(),
      ),
      transition: Transition.noTransition,
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<UserProfileController>(
            () => UserProfileController(
              globalController: Get.find(),
              userRepo: Get.find(),
              sharedPreferenceHelper: Get.find(),
              productRepo: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: signUp,
      page: () => getRoute(
        const SignupScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: verifyOTP,
      page: () => getRoute(
        const VerifyOtpScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: accountCreated,
      page: () => getRoute(
        const AccountCreatedScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: globalVerifyOTP,
      page: () => getRoute(
        const GlobalOTPVerificationScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: shop,
      page: () => getRoute(
        const StoreScreen(),
      ),
      transition: Transition.noTransition,
    ),
    GetPage<dynamic>(
      name: wallet,
      page: () => getRoute(
        const WalletScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<WalletController>(
            () => WalletController(
              walletRepo: Get.find(),
            ),
          );
        },
      ),
      transition: Transition.noTransition,
    ),
    GetPage<dynamic>(
      name: walletAllTransaction,
      page: () => getRoute(
        const WalletAllTransactionScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: addNewProduct,
      page: () => getRoute(
        const AddNewProductScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: profileDetail,
      page: () => getRoute(
        const ProfileDetailScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: editProfile,
      page: () => getRoute(
        const EditProfileScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: successScreen,
      page: () => getRoute(
        const SuccessScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: editAddress,
      page: () => getRoute(
        const EditAddressScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: contactUs,
      page: () => getRoute(
        const ContactUsScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<ContactUsController>(
            () => ContactUsController(
              globalController: Get.find(),
              staticRepo: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: staticPageDetail,
      page: () => getRoute(
        const StaticDetailScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: orderManageList,
      page: () => getRoute(
        OrderManageListScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: orderManageDetail,
      page: () => getRoute(
        OrderManageDetailScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: productDetails,
      page: () => getRoute(
        const ProductDetailScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: editVerifyOtp,
      page: () => getRoute(
        const EditProfileVerifyOtpScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: changePassword,
      page: () => getRoute(
        const ChangePasswordScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: productList,
      page: () => getRoute(
        const ProductScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: inventoryList,
      page: () => getRoute(
        const InventoryListScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: inventoryDetails,
      page: () => getRoute(
        const InventoryDetailsScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: invoiceList,
      page: () => getRoute(
        const InvoiceListScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<InvoiceController>(
            () => InvoiceController(
              invoiceRepo: Get.find(),
              globalController: Get.find(),
              sharedPref: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: invoiceDetails,
      page: () => getRoute(
        const InvoiceDetailsScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: productFilter,
      page: () => getRoute(
        const ProductFilterScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<ProductFilterController>(
            () => ProductFilterController(
              globalController: Get.find(),
              productListController: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: inventoryFilterScreen,
      page: () => getRoute(
        InventoryFilterScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: orderFilter,
      page: () => getRoute(
        const OrderListFilterScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: purchaseProductDetails,
      page: () => getRoute(
        PurchaseProductDetailScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: assignDriver,
      page: () => getRoute(
        const AssignDriverScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: storeProductList,
      page: () => getRoute(
        StoreProductScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<StoreProductController>(
            () => StoreProductController(
              shopRepo: Get.find(),
              globalController: Get.find(),
              productRepo: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: cart,
      page: () => getRoute(
        const CartScreen(),
      ),
    ),
    GetPage<dynamic>(
        name: checkout,
        page: () => getRoute(
              const CheckoutScreen(),
            ),
        transition: Transition.native),
    GetPage<dynamic>(
        name: placeOrder,
        page: () => getRoute(
              PlaceOrderSuccessScreen(),
            ),
        transition: Transition.native),
    GetPage<dynamic>(
      name: addShippingAddress,
      page: () => getRoute(
        const AddShippingAddressScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: shippingAddress,
      page: () => getRoute(
        const AddressScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: searchProductList,
      page: () => getRoute(
        SearchProductScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: searchProductFilter,
      page: () => getRoute(
        SearchProductFilterScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: purchaseHistory,
      page: () => getRoute(
        const PurchaseHistoryScreen(),
      ),
      transition: Transition.noTransition,
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<PurchaseHistoryListController>(
            () => PurchaseHistoryListController(
                globalController: Get.find(), orderRepo: Get.find()),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: purchaseHistoryFilter,
      page: () => getRoute(
        const PurchaseHistoryListFilterScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: purchaseHistoryDetails,
      page: () => getRoute(
        const PurchaseHistoryDetailScreen(),
      ),
      binding: BindingsBuilder<dynamic>(
        () {
          Get.lazyPut<PurchaseHistoryDetailController>(
            () => PurchaseHistoryDetailController(
              orderRepo: Get.find(),
            ),
          );
        },
      ),
    ),
    GetPage<dynamic>(
      name: notificationList,
      page: () => getRoute(
        const NotificationScreen(),
      ),
    ),
    GetPage<dynamic>(
      name: allStoreList,
      page: () => getRoute(
        const StoreListScreen(),
      ),
    ),
  ];

  static Widget getRoute(
    final Widget navigateTo,
  ) {
    return navigateTo;
  }

  static String getProductDetailRoute(final String? slug) {
    return '$purchaseProductDetails/$slug';
  }
}
