import 'package:atobuy_vendor_flutter/data/repository/notification_repo.dart';
import 'package:atobuy_vendor_flutter/data/response_models/notifications/notification_model.dart';
import 'package:atobuy_vendor_flutter/helper/connection/connection.dart';
import 'package:atobuy_vendor_flutter/utils/message_constant.dart';
import 'package:atobuy_vendor_flutter/view/base/custom_snack_bar.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationController extends GetxController {
  NotificationController({required this.notificationRepo});

  // ----------------- Repositories -----------------
  final NotificationRepo notificationRepo;
  PagingController<int, NotificationsModel> notificationListController =
      PagingController<int, NotificationsModel>(
          firstPageKey: 1, invisibleItemsThreshold: 1);

  @override
  void onInit() {
    super.onInit();
    setPageControllerListener();
  }

  void setPageControllerListener() {
    notificationListController.addPageRequestListener((final int pageKey) {
      getNotificationList(page: pageKey);
    });
  }

  Future<void> refreshNotificationList() async {
    notificationListController.refresh();
  }

  Future<void> getNotificationList({required final int page}) async {
    try {
      if (!await ConnectionUtils.isNetworkConnected()) {
        showCustomSnackBar(message: MessageConstant.networkError.tr);
        return;
      }

      await notificationRepo.getNotificationList(
        queryParams: <String, dynamic>{'page': page},
      ).then((final NotificationResponseModel value) {
        final List<NotificationsModel> newList =
            _getUpdatedNotiList(value.results ?? <NotificationsModel>[]);
        if (value.next != null) {
          final int nextPage = page + 1;
          notificationListController.appendPage(newList, nextPage);
        } else {
          notificationListController.appendLastPage(newList);
        }
      });
    } catch (e) {
      notificationListController.error = e;
    }
  }

  List<NotificationsModel> _getUpdatedNotiList(
      final List<NotificationsModel> notifications) {
    final List<NotificationsModel> arrNotification = notifications;
    for (int i = 0;
        i <
            (notificationListController.itemList ?? <NotificationsModel>[])
                .length;
        i++) {
      final DateTime? existedTimeStamp =
          notificationListController.itemList![i].timestamp;
      for (int n = 0; n < notifications.length; n++) {
        if (notifications[n].timestamp == existedTimeStamp) {
          arrNotification[n].timestamp = null;
        }
      }
    }

    return arrNotification;
  }
}
