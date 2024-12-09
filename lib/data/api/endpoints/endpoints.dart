class Endpoints {
  static const String staging = 'https://be-atobuy.trootechproducts.com';
  static const String stagingDev = 'https://be.atobuy-dev.trootechproducts.com';
  static const String local = 'http://192.168.0.56:8000';
  static const String live = 'https://api.souq-n01.com';

  static const String baseUrl = live;
  static const String version = '/api/v1/';
  static const String signup = '${version}users/';
  static const String verifyOTP = '${version}verify-otp/';
  static const String sendOTP = '${version}send-otp/';
  static const String resendOTP =
      '${version}send-login-otp/?is_mobile_otp=True/';
  static const String emailLogin = '$version/email-login/';
  static const String mobileLoginOTPVerify = '$version/contact-number-login/';
  static const String forgotPassword = '$version/forgot-password-otp/';
  static const String resetPassword = '$version/verify-forgot-password-otp/';
  static const String staticPages = '$version/pages/';
  static const String contactUS = '$version/contact-us/';

  //USER'S URLs
  static const String users = '$version/users/';
  static const String address = '$version/address/';
  static const String changePassword = '$version/change-password/';

  static const String getCountryList = '$version/countries/';
  static const String getStateList = '$version/regions/';
  static const String getCityList = '$version/city/';
  static const String getStoreList = '$version/store/';
  static const String products = '$version/product/';
  static const String productRequest = '$version/product-request/';
  static const String uploadProductsSheet = '$version/upload-product-sheet/';
  static const String category = '$version/category/';
  static const String order = '${version}order/';
  static const String driver = '${version}driver/';

  static const String logOut = '$baseUrl${version}logout/';
  static const String assignDriver = 'assign-driver/';
  static const String acceptRejectOrder = 'approve-reject-order/';
  static const String getImportExcelSample =
      '${baseUrl}${version}sample-product-file-format';

  static const String addToCart = '${version}/add_to_carts/';
  static const String promoBanner = '${version}booked-slot/';
  static const String getAvailableBannerSlot =
      '${version}banner-available-slot/';
  static const String getOfferTypeList = '${version}offer-type-list/';
  static const String getStoreBannerList = '${version}banner-list/';
  static const String offers = '${version}offers/';

  static const String cart = '${version}add_to_carts/';
  static const String paymentList = '${version}payment-type-list/';
  static const String orderStats = '${order}vendor-order-stats/';
  static const String deleteAccount = '${version}user_delete/';
  static const String invoices = '${version}invoices/';
  static const String updateFCMToken = '${version}device/fcm/';
  static const String walletHistory = '${version}received-payment-history/';
  static const String walletBalance = '${version}user-wallet/';
  static const String notifications = '${version}notifications/';

  static const String getBusinessCategory = '${version}business-category/';
  static const String ticket = '${version}tickets/';
  static const String getStoreCategory = '${version}store_categories/';
  static const String getBusinessType = '${version}business-type-list/';
  static const String getBrands = '${version}brand/';
}
