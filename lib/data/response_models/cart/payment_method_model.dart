class PaymentMethodModel {
  PaymentMethodModel({this.results});

  PaymentMethodModel.fromJson(final Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <PaymentModel>[];
      json['results'].forEach((final v) {
        results!.add(new PaymentModel.fromJson(v));
      });
    }
  }
  List<PaymentModel>? results;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] =
          this.results!.map((final PaymentModel v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentModel {
  PaymentModel({this.key, this.value});

  PaymentModel.fromJson(final Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }
  String? key;
  String? value;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
