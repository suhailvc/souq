import 'package:flutter/material.dart';

enum SelectedLoginType {
  email,
  mobile,
}

enum OTPVerificationFor {
  mobileLogin,
}

enum PhotoPickerType {
  camera,
  photos,
}

enum UserProfileFromPage {
  personal,
}

enum ForceSignoutStatus {
  invalidOrExpiredApiToken('invalid or expired api token'),
  tokenNotFound('token not found!'),
  userIsDeactivatedByAdmin('user is deactivated by admin'),
  userIsDeletedByAdmin('user is deleted by admin'),
  userIsDeactivated('user is deactivated');

  const ForceSignoutStatus(this.message);

  final String? message;
}

enum EditEmailOrPhone { mobile, email }

enum ImportFileExtension { xlsx, xls }

enum ProductApprovalStatus {
  inReview('in_review', 'In Review'),
  approved('approved', 'Approved'),
  rejected('rejected', 'Rejected');

  const ProductApprovalStatus(this.key, this.title);
  final String key;
  final String title;
}

enum PromotionalBannerApprovalStatus {
  upcoming('upcoming', 'Upcoming'),
  running('running', 'Running'),
  completed('completed', 'Completed');

  const PromotionalBannerApprovalStatus(this.key, this.title);
  final String key;
  final String title;
}

enum ProductStatus {
  active('active', 'Active'),
  inActive('inactive', 'In Active');

  const ProductStatus(this.key, this.title);
  final String key;
  final String title;
}

enum PaymentOption {
  cod('cod', 'COD'),
  card('card', 'Card'),
  upi('upi', 'UPI');

  const PaymentOption(this.key, this.value);
  final String key;
  final String value;
}

enum AddressType { company, user, shipping }

enum SortOptions {
  newestFirst('Newest First', '-created', '-id', '-created'),
  oldestFirst('Oldest First', 'created', 'id', 'created'),
  priceLowToHigh('Price (Low to High)', 'price', '', 'total'),
  priceHighToLow('Price (High to Low)', '-price', '', '-total');

  const SortOptions(
      this.message, this.value, this.inventoryValue, this.orderValue);
  final String message;
  final String value;
  final String inventoryValue;
  final String orderValue;
}

enum StaticPages {
  termsAndCondition(
      'Terms and conditions', 'customer-user-terms-and-conditions'),
  privacyPolicy('Privacy policy', 'customer-user-privacy-policy'),
  faqs('FAQs', 'customer-faqs'),
  aboutUs('About us', 'customer-about-us');

  const StaticPages(this.title, this.slug);
  final String title;
  final String slug;
}

enum OrderStatus {
  pending('Pending', 'pending'),
  accepted('Accepted', 'accepted'),
  rejected('Rejected', 'rejected'),
  processing('Processing', 'processing'),
  shipped('Shipped', 'shipped'),
  delivered('Delivered', 'delivered'),
  canceled('Canceled', 'canceled'),
  refunded('Refunded', 'refunded'),
  returned('Returned', 'returned'),
  onTheWay('On the way', 'on_the_way');

  const OrderStatus(this.title, this.value);
  final String title;
  final String value;
}

enum OrderDetailsCommonAPIType {
  assignDriver,
  acceptRejectOrder;

  const OrderDetailsCommonAPIType();
}

enum TransactionType {
  captured('Successful', Colors.green),
  authorized('Pending', Colors.orange),
  cancelled('Rejected', Colors.red),
  refunded('Refunded', Colors.orange),
  withdraw('Withdrawn', Colors.red),
  deposit('Deposit', Colors.green),
  purchase('Purchase', Colors.red),
  order_payment('Order Payment', Colors.red),
  installment('Installment', Colors.red),
  bnpl_credit('BNPL Credit', Colors.green),
  bnpl_commission('BNPL Commission', Colors.black),
  cashback('Cashback', Colors.green);

  const TransactionType(this.title, this.color);

  final String title;
  final Color color;
}

enum PaymentMethod {
  cod,
  wallet;

  const PaymentMethod();
}
