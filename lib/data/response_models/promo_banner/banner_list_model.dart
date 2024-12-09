import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';

class BannerListModel {
  BannerListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  BannerListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] == null
        ? <BannerListItem>[]
        : List<BannerListItem>.from(
            json['results']!.map(
              (final dynamic x) => BannerListItem.fromJson(x),
            ),
          );
  }
  int? count;
  String? next;
  String? previous;
  List<BannerListItem>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(
                results!.map(
                  (final BannerListItem x) => x.toJson(),
                ),
              ),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class BannerListItem {
  BannerListItem({
    this.id,
    this.owner,
    this.image,
    this.title,
    this.status,
    this.startDate,
    this.endDate,
    this.slots,
    this.totalAmount,
  });

  BannerListItem.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    image = json['image'];
    title = json['title'];
    if (json['status'] != null) {
      status = PromotionalBannerApprovalStatus.values.firstWhereOrNull(
          (final PromotionalBannerApprovalStatus status) =>
              (status.key == json['status'] || status.title == json['status']));
    }
    startDate =
        json['start_date'] == null ? null : DateTime.parse(json['start_date']);
    endDate =
        json['end_date'] == null ? null : DateTime.parse(json['end_date']);
    slots = json['slots'] == null
        ? <Slot>[]
        : List<Slot>.from(
            json['slots']!.map(
              (final dynamic x) => Slot.fromJson(x),
            ),
          );
    totalAmount = json['total_amount'];
  }
  int? id;
  int? owner;
  String? image;
  String? title;
  PromotionalBannerApprovalStatus? status;
  DateTime? startDate;
  DateTime? endDate;
  List<Slot>? slots;
  String? totalAmount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'owner': owner,
        'image': image,
        'title': title,
        'status': status?.title,
        'start_date': startDate != null
            ? "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}"
            : startDate,
        'end_date': endDate != null
            ? "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}"
            : endDate,
        'slots': slots == null
            ? <dynamic>[]
            : List<dynamic>.from(slots!.map((final Slot x) => x.toJson())),
        'total_amount': totalAmount,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Slot {
  Slot({
    this.id,
    this.startTime,
    this.endTime,
    this.price,
    this.bannerDay,
    this.banner,
  });

  Slot.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    bannerDay = json['banner_day'] == null
        ? null
        : BannerDay.fromJson(json['banner_day']);
    banner =
        json['banner'] == null ? null : BannerItem.fromJson(json['banner']);
  }
  int? id;
  String? startTime;
  String? endTime;
  String? price;
  BannerDay? bannerDay;
  BannerItem? banner;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'start_time': startTime,
        'end_time': endTime,
        'price': price,
        'banner_day': bannerDay?.toJson(),
        'banner': banner?.toJson(),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class BannerItem {
  BannerItem({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  BannerItem.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    if (json['product'] != null) {
      product = BannerProduct.fromJson(json['product']);
    }
  }
  int? id;
  String? title;
  String? description;
  String? image;
  BannerProduct? product;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'image': image,
        'product': product?.toJson()
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class BannerDay {
  BannerDay({
    this.date,
    this.startHours,
    this.endHours,
    this.durationOfSlots,
  });

  BannerDay.fromJson(final Map<String, dynamic> json) {
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    startHours = json['start_hours'];
    endHours = json['end_hours'];
    durationOfSlots = json['duration_of_slots'];
  }
  DateTime? date;
  String? startHours;
  String? endHours;
  int? durationOfSlots;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : date,
        'start_hours': startHours,
        'end_hours': endHours,
        'duration_of_slots': durationOfSlots,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class BannerProduct {
  BannerProduct({this.title, this.uuid, this.isActive, this.ownerId, this.id});

  BannerProduct.fromJson(final Map<String, dynamic> json) {
    title = json['title'];
    uuid = json['uuid'];
    if (json['id'] != null) {
      id = json['id'].toString();
    }
    isActive = json['is_active'];
    if (json['owner_id'] != null) {
      ownerId = json['owner_id'].toString();
    }
  }
  String? title;
  String? uuid;
  String? id;
  bool? isActive;
  String? ownerId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'uuid': uuid,
        'id': id,
        'is_active': isActive,
        'owner_id': ownerId,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
