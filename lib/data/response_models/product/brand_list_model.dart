class BrandListResponseModel {
  BrandListResponseModel({
    this.results,
  });

  BrandListResponseModel.fromJson(final Map<String, dynamic> json) {
    results = json['results'] == null
        ? <Brand>[]
        : List<Brand>.from(
            json['results']!.map(
              (final dynamic result) => Brand.fromJson(result),
            ),
          );
  }
  List<Brand>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'results': results == null
            ? <Brand>[]
            : List<dynamic>.from(
                results!.map((final Brand brand) => brand.toJson())),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Brand {
  Brand({this.title, this.logo, this.id, this.uuid});

  Brand.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    logo = json['logo'];
    uuid = json['uuid'];
  }
  int? id;
  String? title;
  String? logo;
  String? uuid;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'logo': logo,
        'uuid': uuid,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
