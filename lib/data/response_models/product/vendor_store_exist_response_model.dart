class VendorStoreExistResponseModel {
  VendorStoreExistResponseModel({
    this.vendorStoreExist,
  });

  VendorStoreExistResponseModel.fromJson(final Map<String, dynamic> json) {
    vendorStoreExist = json['vendor_store_exist'] ?? false;
  }
  bool? vendorStoreExist;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_store_exist'] = this.vendorStoreExist;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
