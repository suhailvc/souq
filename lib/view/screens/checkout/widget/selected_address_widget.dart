import 'package:atobuy_vendor_flutter/data/response_models/user_profile/address_list_model.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';

class SelectedAddressWidget extends StatelessWidget {
  const SelectedAddressWidget({
    super.key,
    this.selectedAddress,
  });
  final AddressModel? selectedAddress;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColors.colorE8EBEC,
      ),
      child: Text(
        selectedAddress != null ? selectedAddress!.getFullAddress() : '-',
        style: mullerW500.copyWith(
          color: AppColors.color171236,
        ),
      ),
    );
  }
}
