class UserModel {
  UserModel({
    this.wallet,
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.contactNumber,
    this.profileImage,
    this.isEmailVerified,
    this.isMobileVerified,
    this.isActive,
    this.userType,
    this.countryCode,
    this.countryName,
    this.phoneNumberWithoutCode,
    this.isKycApproved,
    this.userPermissions,
    this.uuid,
    this.company,
    this.vendorStoreExist,
  });

  UserModel.fromJson(final Map<String, dynamic> json) {
    wallet = json['wallet'];
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    profileImage = json['profile_image'];
    isEmailVerified = json['is_email_verified'];
    isMobileVerified = json['is_mobile_verified'];
    isActive = json['is_active'];
    userType = json['user_type'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    phoneNumberWithoutCode = json['phone_number_without_code'];
    isKycApproved = json['is_kyc_approved'];
    if (json['user_permissions'] != null) {
      userPermissions = <UserPermissions>[];
      json['user_permissions'].forEach((final dynamic v) {
        userPermissions!.add(UserPermissions.fromJson(v));
      });
    }
    vendorStoreExist = false;
    if (json['vendor_store_exist'] != null) {
      vendorStoreExist = json['vendor_store_exist'];
    }

    uuid = json['uuid'];
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((final dynamic v) {
        company!.add(Company.fromJson(v));
      });
    }
    if (json['business_type'] != null) {
      businessType = <BusinessType>[];
      json['business_type'].forEach((final dynamic type) {
        businessType!.add(BusinessType.fromJson(type));
      });
    }
  }
  String? wallet;
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? profileImage;
  bool? isEmailVerified;
  bool? isMobileVerified;
  bool? isActive;
  String? userType;
  String? countryCode;
  String? countryName;
  int? phoneNumberWithoutCode;
  bool? isKycApproved;
  List<UserPermissions>? userPermissions;
  String? uuid;
  List<Company>? company;
  bool? vendorStoreExist;
  List<BusinessType>? businessType;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['profile_image'] = this.profileImage;
    data['is_email_verified'] = this.isEmailVerified;
    data['is_mobile_verified'] = this.isMobileVerified;
    data['is_active'] = this.isActive;
    data['user_type'] = this.userType;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['phone_number_without_code'] = this.phoneNumberWithoutCode;
    data['is_kyc_approved'] = this.isKycApproved;
    if (this.userPermissions != null) {
      data['user_permissions'] = this
          .userPermissions!
          .map((final UserPermissions v) => v.toJson())
          .toList();
    }
    data['uuid'] = this.uuid;
    data['vendor_store_exist'] = this.vendorStoreExist;
    if (this.company != null) {
      data['company'] =
          this.company!.map((final Company v) => v.toJson()).toList();
    }
    if (this.businessType != null) {
      data['business_type'] =
          this.businessType!.map((final BusinessType v) => v.toJson()).toList();
    }
    return data;
  }

  String getBusinessTypeCommaSeparated() {
    final List<String> list = <String>[];
    businessType?.forEach((final BusinessType type) {
      if (type.name != null) {
        list.add(type.name ?? '');
      }
    });
    return list.join(', ');
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class UserPermissions {
  UserPermissions({this.id, this.model, this.permissions});

  UserPermissions.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    model = json['model'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((final dynamic v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  int? id;
  String? model;
  List<Permissions>? permissions;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['model'] = this.model;
    if (this.permissions != null) {
      data['permissions'] =
          this.permissions!.map((final Permissions v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Permissions {
  Permissions({this.id, this.name, this.codename});

  Permissions.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    codename = json['codename'];
  }
  int? id;
  String? name;
  String? codename;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['codename'] = this.codename;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class Company {
  Company(
      {this.id,
      this.user,
      this.companyName,
      this.legalBusinessName,
      this.taxId,
      this.businessType,
      this.websiteUrl});

  Company.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    companyName = json['company_name'];
    legalBusinessName = json['legal_business_name'];
    taxId = json['tax_id'];
    businessType = json['business_type'];
    websiteUrl = json['website_url'];
  }
  int? id;
  int? user;
  String? companyName;
  dynamic legalBusinessName;
  dynamic taxId;
  String? businessType;
  dynamic websiteUrl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['company_name'] = this.companyName;
    data['legal_business_name'] = this.legalBusinessName;
    data['tax_id'] = this.taxId;
    data['business_type'] = this.businessType;
    data['website_url'] = this.websiteUrl;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class BusinessType {
  BusinessType({
    this.id,
    this.name,
  });

  BusinessType.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;

    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
