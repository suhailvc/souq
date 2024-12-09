import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField(
      {super.key,
      this.isPasswordVisible,
      this.style,
      required this.labelText,
      this.labelStyle,
      this.prefixIconConstraints,
      this.border,
      this.prefixIcon,
      this.suffixIcon,
      this.borderColor,
      this.textInputAction,
      required this.controller,
      this.validator,
      this.readOnly,
      this.onTap,
      this.onChange,
      this.inputFormatter,
      this.keyboardType = TextInputType.text,
      this.maxLines,
      this.minLines,
      this.padding,
      this.textCapitalization,
      this.textAlign,
      this.enabled = true,
      this.onSubmitted,
      this.allowLeftRightPadding});

  final bool? isPasswordVisible;
  final bool? enabled;
  final TextStyle? style;
  final String labelText;
  final TextStyle? labelStyle;
  final BoxConstraints? prefixIconConstraints;
  final InputBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType keyboardType;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization? textCapitalization;
  final TextAlign? textAlign;
  final bool? allowLeftRightPadding;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? AppColors.colorB1D2E3,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        enabled: enabled,
        textAlign: textAlign ?? TextAlign.start,
        inputFormatters: inputFormatter,
        readOnly: readOnly ?? false,
        onTap: onTap,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization ?? TextCapitalization.words,
        onFieldSubmitted: onSubmitted,
        onChanged: onChange,
        controller: controller,
        obscureText: !(isPasswordVisible ?? true),
        cursorColor: Colors.black,
        cursorWidth: 1,
        maxLines: maxLines ?? 1,
        minLines: minLines ?? 1,
        textInputAction: textInputAction ?? TextInputAction.next,
        style: mullerW500.copyWith(fontSize: 16, color: AppColors.color171236),
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              labelStyle ?? mullerW400.copyWith(color: AppColors.color8ABCD5),
          prefixIconConstraints: prefixIconConstraints ??
              BoxConstraints(
                maxHeight: 30,
                maxWidth: 70,
              ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 40,
            maxWidth: 70,
          ),
          focusedBorder: border ?? InputBorder.none,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (allowLeftRightPadding ?? true) ? 12 : 0),
            child: prefixIcon ??
                SizedBox(
                  width: 12.0,
                ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: suffixIcon,
          ),
          border: border ?? InputBorder.none,
        ),
      ),
    );
  }
}
