import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/cart_item_row.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/store_vendor_name_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartRow extends StatelessWidget {
  const CartRow({
    super.key,
    required this.vendorModel,
    required this.onIncreaseQty,
    required this.onDecreaseQty,
    required this.onUpdateQty,
    required this.cartModel,
  });

  final VendorModel vendorModel;
  final Function(ProductItem) onIncreaseQty;
  final Function(ProductItem, bool) onDecreaseQty;
  final Function(ProductItem, int) onUpdateQty;
  final CartModel cartModel;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.colorB1D2E3,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          StoreVendorNameWidget(
            storeName: vendorModel.storeName,
            vendorName: vendorModel.vendorName,
          ),
          ListView.builder(
            itemCount: (vendorModel.items ?? <ProductItem>[]).length,
            padding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (final BuildContext context, final int index) {
              return CartItemRow(
                productItem: vendorModel.items![index],
                onIncreaseQty: (final ProductItem product) {
                  this.onIncreaseQty(product);
                },
                onDecreaseQty:
                    (final ProductItem product, final bool isDelete) {
                  this.onDecreaseQty(product, isDelete).call();
                },
                onUpdateQty: (final ProductItem product, final int qty) {
                  this.onUpdateQty(product, qty).call();
                },
              );
            },
          ),
          Gap(15),
          Text(
            ((vendorModel.deliveryCharges ?? 0.00) > 0)
                ? 'Delivery Charge:'.trParams(<String, String>{
                    'charge':
                        '${vendorModel.deliveryCharges?.toStringAsFixed(2) ?? '0.00'} ${vendorModel.currency}'
                  })
                : 'Free Delivery'.tr,
            style: mullerW400.copyWith(
              color: ((vendorModel.deliveryCharges ?? 0.00) > 0)
                  ? AppColors.colorE59825
                  : AppColors.color12658E,
            ),
          ).paddingSymmetric(
            horizontal: 14,
          ),
          Gap(10),
          Visibility(
            visible: ((vendorModel.minOrderAmt ?? 0.00) > 0),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(11),
                    bottomRight: Radius.circular(11),
                  ),
                  color: AppColors.colorD0E4EE.withOpacity(0.5)),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.15),
                      gradient: LinearGradient(colors: <Color>[
                        AppColors.color12658E,
                        AppColors.color2E236C,
                      ]),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.svg.icDelivery,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Minimum Order Amount to get free delivery:'
                          .trParams(<String, String>{
                        'currency':
                            '${vendorModel.minOrderAmt?.toStringAsFixed(2) ?? '0.00'} ${vendorModel.currency} '
                      }),
                      style: mullerW400.copyWith(
                        fontSize: 12,
                        color: AppColors.color677A81,
                      ),
                    ).paddingSymmetric(
                      horizontal: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
