import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ShippingAddressRow extends StatelessWidget {
  const ShippingAddressRow({
    super.key,
    required this.addressModel,
    required this.selectedAddressModel,
    required this.onAddressSelection,
  });

  final AddressModel addressModel;
  final AddressModel? selectedAddressModel;
  final Function(AddressModel) onAddressSelection;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () => onAddressSelection(addressModel),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(selectedAddressModel == addressModel
                  ? Assets.svg.icRadioButtonSelected
                  : Assets.svg.icRadioButton),
              Gap(12),
              Expanded(
                child: Text(
                  addressModel.getFullAddress(),
                  style: mullerW500.copyWith(
                      color: selectedAddressModel == addressModel
                          ? AppColors.color171236
                          : AppColors.color757474,
                      fontWeight: selectedAddressModel == addressModel
                          ? FontWeight.w500
                          : FontWeight.w400),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
