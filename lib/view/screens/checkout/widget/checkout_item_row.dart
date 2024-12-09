import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CheckoutItemRow extends StatelessWidget {
  const CheckoutItemRow({
    super.key,
    required this.productItem,
  });

  final ProductItem productItem;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      productItem.product?.title ?? '',
                      style: mullerW500.copyWith(
                        fontSize: 15.0,
                        color: AppColors.color1D1D1D,
                      ),
                    ),
                    Visibility(
                      visible: productItem.size != null,
                      child: Text(
                        productItem.size?.unit ?? '',
                        style: mullerW400.copyWith(
                          fontSize: 12.0,
                          color: AppColors.color1D1D1D,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8.0),
              Text(
                textAlign: TextAlign.left,
                'X ${productItem.qty ?? ''}',
                style: mullerW500.copyWith(
                  fontSize: 15.0,
                  color: AppColors.color1679AB,
                ),
              ),
              Gap(8.0),
              Expanded(
                flex: 1,
                child: Text(
                  textAlign: TextAlign.right,
                  productItem.getProductPrice(),
                  style: mullerW400.copyWith(
                    fontSize: 13.0,
                    color: AppColors.color1D1D1D,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 8.0);
  }
}
