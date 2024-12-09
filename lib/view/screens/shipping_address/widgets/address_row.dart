import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/screens/shipping_address/add_shipping_address/widgets/address_more_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddressRow extends StatelessWidget {
  const AddressRow({
    super.key,
    required this.addressModel,
    required this.onTapEditProduct,
    required this.onTapDeleteProduct,
  });

  final AddressModel addressModel;
  final Function(AddressModel) onTapEditProduct;
  final Function(AddressModel) onTapDeleteProduct;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.colorB1D2E3,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Text(
              addressModel.getFullAddress(),
              style: mullerW500.copyWith(
                  color: AppColors.color171236, fontSize: 16),
            ).paddingAll(12),
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.topCenter,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            style: IconButton.styleFrom(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.all(0),
                iconSize: 16),
            onPressed: () {
              AddressMoreBottomSheet.show(
                addressModel: addressModel,
                onTapEditProduct: () => onTapEditProduct.call(addressModel),
                onTapDeleteProduct: () => onTapDeleteProduct.call(addressModel),
              );
            },
            icon: SvgPicture.asset(
              Assets.svg.icMore,
              height: 16,
              width: 16,
            ),
          )
        ],
      ),
    );
  }
}
