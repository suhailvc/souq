import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/data/response_models/cart/payment_method_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/app_constants.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentMethodRow extends StatelessWidget {
  const PaymentMethodRow(
      {super.key,
      required this.paymentMethod,
      required this.onPaymentMethodTap,
      required this.selectedPaymentMethod,
      required this.walletBalance});

  final PaymentModel paymentMethod;
  final PaymentModel? selectedPaymentMethod;
  final Function(PaymentModel) onPaymentMethodTap;
  final String? walletBalance;

  @override
  Widget build(final BuildContext context) {
    return Visibility(
      //TODO as of now we just want to show cash on delivery. Once we will allow online payment we just need to remove Visibility widget
      visible: (paymentMethod.key == PaymentMethod.cod.name ||
          paymentMethod.key == PaymentMethod.wallet.name),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.colorE8EBEC),
        child: InkWell(
          onTap: () => onPaymentMethodTap(paymentMethod),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset((paymentMethod == selectedPaymentMethod)
                  ? Assets.svg.icRadioButtonSelected
                  : Assets.svg.icRadioButton),
              Gap(12),
              Expanded(
                child: Text(
                  paymentMethod.value ?? '',
                  style: mullerW500.copyWith(
                    color: AppColors.color171236,
                  ),
                ),
              ),
              Visibility(
                visible: paymentMethod.key == PaymentMethod.wallet.name &&
                    walletBalance.isNotNullAndEmpty(),
                child: Text(
                  '$walletBalance ${Get.find<GlobalController>().priceRangeData?.currencySymbol ?? AppConstants.defaultCurrency}',
                  style: mullerW500.copyWith(
                    color: AppColors.color171236,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
