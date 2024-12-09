import 'package:atobuy_vendor_flutter/helper/extensions/date_time_ext.dart';
import 'package:atobuy_vendor_flutter/helper/extensions/string_ext.dart';

class BannerSlotsModel {
  BannerSlotsModel(
      {this.date,
      this.currency,
      this.slots,
      this.isExpanded = false,
      this.selectedSlotsCount});

  BannerSlotsModel.fromJson(final Map<String, dynamic> json) {
    date = json['date'] == null ? null : DateTime.parse(json['date']);
    currency = json['currency'];
    slots = json['slots'] == null
        ? <AvailableSlot>[]
        : List<AvailableSlot>.from(
            json['slots']!.map(
              (final dynamic x) => AvailableSlot.fromJson(x),
            ),
          );
  }
  DateTime? date;
  String? currency;
  List<AvailableSlot>? slots;
  bool isExpanded = false;
  int? selectedSlotsCount;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'date': date != null
            ? "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}"
            : date,
        'currency': currency,
        'slots': slots == null
            ? <dynamic>[]
            : List<dynamic>.from(
                slots!.map((final AvailableSlot x) => x.toJson())),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class AvailableSlot {
  AvailableSlot({
    this.id,
    this.startTime,
    this.endTime,
    this.price,
    this.isSelected = false,
  });

  AvailableSlot.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    if (json['start_time'] != null) {
      startTime = (json['start_time'] as String).formatHHMMSS().format24HHMM();
    }
    if (json['end_time'] != null) {
      endTime = (json['end_time'] as String).formatHHMMSS().format24HHMM();
    }
    price = json['price'];
  }
  int? id;
  String? startTime;
  String? endTime;
  String? price;
  bool isSelected = false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'start_time': startTime,
        'end_time': endTime,
        'price': price,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
