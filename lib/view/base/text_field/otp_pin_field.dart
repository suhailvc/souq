import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

class CustomOtpPinField extends StatelessWidget {
  const CustomOtpPinField({
    super.key,
    required this.otpPinFieldKey,
    required this.onSubmit,
    required this.onChange,
  });

  final GlobalKey<OtpPinFieldState> otpPinFieldKey;
  final Function(String) onSubmit;
  final Function(String) onChange;

  @override
  Widget build(final BuildContext context) {
    return OtpPinField(
      key: otpPinFieldKey,
      onSubmit: (final String text) => onSubmit(text),
      onChange: (final String text) => onChange(text),
      keyboardType: TextInputType.number,
      maxLength: 6,
      showCursor: true,
      autoFocus: false,
      autoFillEnable: true,
      cursorWidth: 1.0,
      otpPinFieldStyle: OtpPinFieldStyle(
        activeFieldBorderColor: AppColors.color12658E,
        defaultFieldBorderColor: AppColors.colorDDECF2,
        filledFieldBorderColor: AppColors.colorDDECF2,
        fieldBorderRadius: 12,
        fieldBorderWidth: 1,
        fieldPadding: 8,
        textStyle:
            mullerW500.copyWith(fontSize: 28, color: AppColors.color1D1D1D),
      ),
      cursorColor: AppColors.color1D1D1D,
      otpPinFieldDecoration: OtpPinFieldDecoration.custom,
    );
  }
}
