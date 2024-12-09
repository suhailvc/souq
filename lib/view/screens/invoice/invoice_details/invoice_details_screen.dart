import 'package:atobuy_vendor_flutter/controller/global_controller.dart';
import 'package:atobuy_vendor_flutter/controller/invoice/invoice_controller.dart';
import 'package:atobuy_vendor_flutter/theme/status_bar_config.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_app_bar.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_details/widgets/download_invoice_widget.dart';
import 'package:atobuy_vendor_flutter/view/screens/invoice/invoice_details/widgets/invoice_details_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});
  @override
  Widget build(final BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: darkStatusBarTransparent,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppbarWithBackIconAndTitle(
            title: 'Invoice Details'.tr,
          ),
          body: SafeArea(
            child: GetBuilder<InvoiceController>(
                builder: (final InvoiceController controller) {
              return Column(
                children: <Widget>[
                  InvoiceDetailsHeader(),
                  Gap(16.0),
                  DownloadInvoiceWidget(
                    onTapDownloadInvoice: () {
                      Get.find<GlobalController>().downloadInvoice(
                          controller.selectedInvoice?.downloadInvoiceUrl ?? '',
                          controller.selectedInvoice?.orderId ?? '');
                    },
                  )
                ],
              ).marginSymmetric(horizontal: 16.0, vertical: 16.0);
            }),
          ),
        ),
      ),
    );
  }
}
