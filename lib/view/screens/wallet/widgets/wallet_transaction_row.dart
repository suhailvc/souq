import 'package:atobuy_vendor_flutter/data/response_models/wallet/wallet_transactions_model.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WalletTransactionRow extends StatelessWidget {
  const WalletTransactionRow({super.key, required this.transaction});

  final WalletTransaction transaction;
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: AppColors.colorB1D2E3,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.paymentTransaction?.store?.name ??
                      transaction.type?.capitalize ??
                      '',
                  style: mullerW500.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.color1D1D1D,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      transaction.created?.formatDDMMYYYY().formatDDMMMYYYY() ??
                          '',
                      style: mullerW400.copyWith(
                        color: AppColors.color94ACB5,
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 4,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColors.color94ACB5,
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    Text(
                      transaction.paymentTransaction?.status?.title ?? '',
                      style: mullerW400.copyWith(
                        color: transaction.paymentTransaction?.status?.color ??
                            AppColors.color2E236C,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            transaction.getTransactionAmount(),
            style: mullerW500.copyWith(
              fontWeight: FontWeight.w500,
              color: _getTransactionTextColor(),
            ),
          )
        ],
      ),
    );
  }

  Color _getTransactionTextColor() {
    return (transaction.amount ?? '').contains('+')
        ? Colors.green
        : ((transaction.amount ?? '').contains('-')
            ? Colors.red
            : AppColors.color1D1D1D);
  }
}
