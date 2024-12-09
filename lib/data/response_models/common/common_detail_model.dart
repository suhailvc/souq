class CommonDetailModel {
  CommonDetailModel({this.detail});

  CommonDetailModel.fromJson(final Map<String, dynamic> json) {
    detail = json['detail'];
  }
  String? detail;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['detail'] = this.detail;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
