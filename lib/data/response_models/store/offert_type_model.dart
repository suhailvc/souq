class OfferTypeListModel {
  OfferTypeListModel({
    this.results,
  });

  OfferTypeListModel.fromJson(final Map<String, dynamic> json) {
    results = json['results'] == null
        ? <OfferType>[]
        : List<OfferType>.from(
            json['results']!.map(
              (final dynamic data) => OfferType.fromJson(data),
            ),
          );
  }
  List<OfferType>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(
                results!.map(
                  (final OfferType type) => type.toJson(),
                ),
              ),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class OfferType {
  OfferType({
    this.key,
    this.value,
    this.isSelected = false,
  });

  OfferType.fromJson(final Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }
  String? key;
  String? value;
  bool isSelected = false;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'key': key,
        'value': value,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
