import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:get/get.dart';

class WalletTransactionsModel {
  WalletTransactionsModel({this.count, this.next, this.previous, this.results});

  WalletTransactionsModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <WalletTransaction>[];
      json['results'].forEach((final v) {
        results!.add(WalletTransaction.fromJson(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<WalletTransaction>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] =
          results!.map((final WalletTransaction v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class WalletTransaction {
  WalletTransaction({
    this.id,
    this.user,
    this.amount,
    this.created,
    this.type,
    this.paymentTransaction,
    this.wallet,
    this.emi,
  });

  WalletTransaction.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    amount = json['amount'];
    created = json['created'];
    type = json['type'];
    paymentTransaction = json['payment_transaction'] != null
        ? PaymentTransaction.fromJson(json['payment_transaction'])
        : null;
    wallet = json['wallet'];
    if (json['emi'] != null) {
      emi = <Emi>[];
      json['emi'].forEach((final v) {
        emi!.add(Emi.fromJson(v));
      });
    }
  }
  int? id;
  User? user;
  String? amount;
  String? created;
  String? type;
  PaymentTransaction? paymentTransaction;
  String? wallet;
  List<Emi>? emi;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['amount'] = amount;
    data['created'] = created;
    data['type'] = type;
    if (paymentTransaction != null) {
      data['payment_transaction'] = paymentTransaction!.toJson();
    }
    data['wallet'] = wallet;
    if (emi != null) {
      data['emi'] = emi!.map((final Emi v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }

  String getTransactionAmount() {
    final String? newPrice = (amount ?? '0.00').toDouble()?.toStringAsFixed(2);
    return '${newPrice ?? '0.00'} ${Get.find<GlobalController>().priceRangeData?.currencySymbol ?? AppConstants.defaultCurrency}';
  }
}

class User {
  User(
      {this.email,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.userType});

  User.fromJson(final Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    userType = json['user_type'];
  }
  String? email;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? userType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['contact_number'] = contactNumber;
    data['user_type'] = userType;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class PaymentTransaction {
  PaymentTransaction({this.store, this.status, this.metadata});

  PaymentTransaction.fromJson(final Map<String, dynamic> json) {
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    status = TransactionType.values.firstWhereOrNull(
        (final TransactionType type) =>
            type.name == json['status'].toString().toLowerCase());
    metadata =
        json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
  }
  Store? store;
  Metadata? metadata;
  TransactionType? status;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (store != null) {
      data['store'] = store!.toJson();
    }
    data['status'] = status?.name;
    if (metadata != null) {
      data['metadata'] = metadata!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Store {
  Store({this.name, this.logo});

  Store.fromJson(final Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }
  String? name;
  String? logo;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Metadata {
  Metadata({this.userApiKey, this.orderReceipt});

  Metadata.fromJson(final Map<String, dynamic> json) {
    userApiKey = json['user_api_key'];
    orderReceipt = json['order_receipt'];
  }
  String? userApiKey;
  String? orderReceipt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_api_key'] = userApiKey;
    data['order_receipt'] = orderReceipt;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Emi {
  Emi(
      {this.amount,
      this.paymentTransaction,
      this.installmentNumber,
      this.emiScheduleDate,
      this.status,
      this.emiPaymentDate});

  Emi.fromJson(final Map<String, dynamic> json) {
    amount = json['amount'];
    paymentTransaction = json['payment_transaction'];
    installmentNumber = json['installment_number'];
    emiScheduleDate = json['emi_schedule_date'];
    status = json['status'];
    emiPaymentDate = json['emi_payment_date'];
  }
  String? amount;
  int? paymentTransaction;
  int? installmentNumber;
  String? emiScheduleDate;
  String? status;
  dynamic emiPaymentDate;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['payment_transaction'] = paymentTransaction;
    data['installment_number'] = installmentNumber;
    data['emi_schedule_date'] = emiScheduleDate;
    data['status'] = status;
    data['emi_payment_date'] = emiPaymentDate;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
