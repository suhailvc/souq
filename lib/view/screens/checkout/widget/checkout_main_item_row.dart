import 'package:atobuy_vendor_flutter/data/response_models/cart/cart_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/view/screens/cart/widget/store_vendor_name_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/checkout/widget/checkout_item_row.dart';
import 'package:flutter/material.dart';

class CheckoutMainItemRow extends StatelessWidget {
  const CheckoutMainItemRow({
    super.key,
    required this.vendorModel,
  });

  final VendorModel vendorModel;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 1,
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
              return CheckoutItemRow(
                productItem: vendorModel.items![index],
              );
            },
          ),
        ],
      ),
    );
  }
}
