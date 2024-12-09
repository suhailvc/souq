import 'package:atobuy_vendor_flutter/helper/extensions/list_extension.dart';
import 'package:atobuy_vendor_flutter/utils/app_enums.dart';

class AddressListModel {
  AddressListModel({this.count, this.next, this.previous, this.results});

  AddressListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <AddressModel>[];
      json['results'].forEach((final dynamic v) {
        results!.add(AddressModel.fromJson(v));
      });
    }
  }
  int? count;
  String? next;
  String? previous;
  List<AddressModel>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] =
          this.results!.map((final AddressModel v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class AddressModel {
  AddressModel(
      {this.id,
      this.user,
      this.company,
      this.addressType,
      this.addressLine1,
      this.street,
      this.building,
      this.landmark,
      this.city,
      this.postalCode});

  AddressModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    company = json['company'];
    if (json['address_type'] != null) {
      addressType = AddressType.values.firstWhereOrNull(
          (final AddressType element) => element.name == json['address_type']);
    }
    addressLine1 = json['line1'];
    street = json['line2'];
    building = json['line3'];
    landmark = json['landmark'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    postalCode = json['postal_code'];

    fullAddress = <String>[];
    if ((addressLine1 ?? '').trim().isNotEmpty) {
      fullAddress?.add(addressLine1!);
    }

    if ((street ?? '').trim().isNotEmpty) {
      fullAddress?.add(street!);
    }
    if ((building ?? '').trim().isNotEmpty) {
      fullAddress?.add(building!);
    }

    if ((landmark ?? '').trim().isNotEmpty) {
      fullAddress?.add(landmark!);
    }

    if ((city?.name ?? '').trim().isNotEmpty) {
      fullAddress?.add(city?.name ?? '');
    }

    if ((city?.region?.name ?? '').trim().isNotEmpty) {
      fullAddress?.add(city?.region?.name ?? '');
    }

    if ((city?.country?.name ?? '').trim().isNotEmpty) {
      fullAddress?.add(city?.country?.name ?? '');
    }

    if (postalCode != null) {
      fullAddress?.add(postalCode.toString());
    }
  }
  int? id;
  dynamic user;
  dynamic company;
  AddressType? addressType;
  String? addressLine1;
  String? street;
  String? building;
  String? landmark;
  City? city;
  int? postalCode;
  List<String>? fullAddress;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['company'] = this.company;
    if (addressType != null) {
      data['address_type'] = addressType?.name;
    }
    data['line1'] = this.addressLine1;
    data['line2'] = this.street;
    data['line3'] = this.building;
    data['landmark'] = this.landmark;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['postal_code'] = this.postalCode;
    return data;
  }

  String getFullAddress() {
    return fullAddress?.join(', ') ?? '';
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class City {
  City(
      {this.id,
      this.name,
      this.displayName,
      this.subregion,
      this.region,
      this.country});

  City.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    subregion = json['subregion'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    country =
        json['country'] != null ? CountryModel.fromJson(json['country']) : null;
  }
  int? id;
  String? name;
  String? displayName;
  String? subregion;
  Region? region;
  CountryModel? country;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['subregion'] = this.subregion;
    if (this.region != null) {
      data['region'] = this.region!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Region {
  Region({this.id, this.name, this.geonameCode});

  Region.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    geonameCode = json['geoname_code'];
  }
  int? id;
  String? name;
  String? geonameCode;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['geoname_code'] = this.geonameCode;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class CountryModel {
  CountryModel({this.id, this.name, this.code3, this.code2, this.phone});

  CountryModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code3 = json['code3'];
    code2 = json['code2'];
    phone = json['phone'];
  }
  int? id;
  String? name;
  String? code3;
  String? code2;
  String? phone;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code3'] = this.code3;
    data['code2'] = this.code2;
    data['phone'] = this.phone;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
