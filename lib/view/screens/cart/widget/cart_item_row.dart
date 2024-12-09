import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/parsing.dart';
import 'package:atobuy_vendor_flutter/helper/shared_preference_helper/shared_pref_helper.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/purchase/purchase_product_details/widgets/qty_update_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartItemRow extends StatelessWidget {
  const CartItemRow({
    super.key,
    required this.productItem,
    required this.onIncreaseQty,
    required this.onDecreaseQty,
    required this.onUpdateQty,
  });

  final ProductItem productItem;
  final Function(ProductItem) onIncreaseQty;
  final Function(ProductItem, bool) onDecreaseQty;
  final Function(ProductItem, int) onUpdateQty;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
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
              Row(
                children: <Widget>[
                  Visibility(
                    visible: (productItem.totalPriceWithOffer ?? 0.00) !=
                        productItem.totalPrice,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 5.0),
                      child: Text(
                        productItem.getProductMainPrice(),
                        style: mullerW400.copyWith(
                            fontSize: 13,
                            color: AppColors.color1D1D1D,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  Text(
                    productItem.getProductPrice(),
                    style: mullerW400.copyWith(
                      fontSize: 13.0,
                      color: AppColors.color1D1D1D,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Directionality(
                  textDirection:
                      Get.find<SharedPreferenceHelper>().getLanguageCode == 'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(4),
                        bottomStart: Radius.circular(4),
                      ),
                      color: getMinusBackgroundColor(),
                    ),
                    child: InkWell(
                      onTap: () {
                        if ((productItem.qty ?? 0) > 1 &&
                            productItem.size != null) {
                          onDecreaseQty(productItem, false);
                        } else {
                          if ((productItem.qty ?? 0) >
                              (productItem.product?.minimumOrderQuantity ??
                                  0)) {
                            onDecreaseQty(productItem, false);
                          }
                        }
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.icMinus,
                          colorFilter: ColorFilter.mode(
                              getMinusIconsColor(), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    openQtyUpdateDialog();
                  },
                  child: Container(
                    height: 24,
                    alignment: Alignment.center,
                    color: AppColors.colorE8EBEC,
                    child: Text('${productItem.qty ?? 0}'),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Directionality(
                  textDirection:
                      Get.find<SharedPreferenceHelper>().getLanguageCode == 'en'
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topEnd: Radius.circular(4),
                        bottomEnd: Radius.circular(4),
                      ),
                      color: getPlusBackgroundColor(),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (productItem.size != null) {
                          onIncreaseQty(productItem);
                        } else {
                          if ((productItem.qty ?? 0) !=
                              (productItem.product?.quantity ?? 0)) {
                            onIncreaseQty(productItem);
                          }
                        }
                      },
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.icPlus,
                          colorFilter: ColorFilter.mode(
                              (productItem.qty ?? 0) <
                                      (productItem.product?.quantity ?? 0)
                                  ? AppColors.white
                                  : AppColors.color666666.withOpacity(0.5),
                              BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Gap(15),
              InkWell(
                onTap: () {
                  onDecreaseQty(productItem, true);
                },
                child: Center(
                  child: SvgPicture.asset(
                    Assets.svg.icDelete,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ).paddingSymmetric(vertical: 8.0);
  }

  void openQtyUpdateDialog() {
    Get.dialog(
      Dialog(
        elevation: 0,
        child: SizedBox(
          height: Get.height * .35,
          width: Get.width,
          child: QtyUpdateWidget(
            //Add qty from API
            itemMaximumQty: productItem.size == null
                ? Parsing.intFrom(productItem.product?.quantity)
                : null,
            itemMinimumQty: productItem.size == null
                ? Parsing.intFrom(productItem.product?.minimumOrderQuantity)
                : Parsing.intFrom(1),
            onSubmit: (final int qty) {
              if (qty > 0) {
                onUpdateQty(productItem, qty);
              }
            },
            itemQty: Parsing.intFrom(productItem.qty),
          ),
        ),
      ),
    );
  }

  Color getMinusIconsColor() {
    if (productItem.size != null) {
      if ((productItem.qty ?? 0) > 1) {
        return AppColors.white;
      } else {
        return AppColors.color333333.withOpacity(0.5);
      }
    }
    return (productItem.qty ?? 0) >
            (productItem.product?.minimumOrderQuantity ?? 0)
        ? AppColors.white
        : AppColors.color333333.withOpacity(0.5);
  }

  Color getMinusBackgroundColor() {
    if (productItem.size != null) {
      if ((productItem.qty ?? 0) > 1) {
        return AppColors.color12658E;
      } else {
        return AppColors.color97A3A9;
      }
    }
    return (productItem.qty ?? 0) >
            (productItem.product?.minimumOrderQuantity ?? 0)
        ? AppColors.color12658E
        : AppColors.color97A3A9;
  }

  Color getPlusIconsColor() {
    if (productItem.size != null) {
      return AppColors.white;
    }
    return (productItem.qty ?? 0) < (productItem.product?.quantity ?? 0)
        ? AppColors.white
        : AppColors.color666666.withOpacity(0.5);
  }

  Color getPlusBackgroundColor() {
    if (productItem.size != null) {
      return AppColors.color12658E;
    }
    return (productItem.qty ?? 0) < (productItem.product?.quantity ?? 0)
        ? AppColors.color12658E
        : AppColors.color97A3A9;
  }
}
