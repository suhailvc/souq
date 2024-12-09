import 'package:atobuy_vendor_flutter/gen/assets.gen.dart';
import 'package:atobuy_vendor_flutter/theme/app_colors.dart';
import 'package:atobuy_vendor_flutter/utils/styles.dart';
import 'package:atobuy_vendor_flutter/view/base/text_field/common_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentCardRow extends StatelessWidget {
  const PaymentCardRow({super.key});

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(Assets.svg.icRadioButton),
                      Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Wade Warren',
                            style: mullerW500.copyWith(
                              color: AppColors.color171236,
                            ),
                          ),
                          Text(
                            '**** **** **** 6632',
                            style: mullerW400.copyWith(
                              fontSize: 12.0,
                              color: AppColors.color97A3A9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  RichText(
                    text: TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: 'Valid Till'.tr,
                          style: mullerW400.copyWith(
                              fontSize: 12, color: AppColors.color97A3A9),
                        ),
                        const TextSpan(text: '  '),
                        TextSpan(
                          text: '06/2024',
                          style: mullerW400.copyWith(
                              fontSize: 12, color: AppColors.color171236),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(12.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: AppColors.colorD0E4EE,
                  ),
                  child: Container(
                    height: 51,
                    width: 301,
                    padding:
                        EdgeInsets.symmetric(horizontal: 11, vertical: 9.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Enter CVV/CVC'.tr,
                          style: mullerW400.copyWith(
                              fontSize: 12.0, color: AppColors.color677A81),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 33,
                          width: 89,
                          child: CommonSearchTextField(
                            borderColor: AppColors.color12658E,
                            controller: TextEditingController(),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            labelText: '',
                            maxLength: 3,
                            textAlign: TextAlign.center,
                            contentPadding: EdgeInsets.only(bottom: 6),
                            inputFormatter: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 8),
          Divider(
            height: 1,
            color: AppColors.colorB9C1C5,
          )
        ],
      ),
    );
  }
}
