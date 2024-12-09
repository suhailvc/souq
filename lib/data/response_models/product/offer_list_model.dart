class OfferListModel {
  OfferListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  OfferListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] == null
        ? <ProductOffer>[]
        : List<ProductOffer>.from(
            json['results']!.map(
              (final dynamic data) => ProductOffer.fromJson(data),
            ),
          );
  }
  int? count;
  String? next;
  String? previous;
  List<ProductOffer>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(
                results!.map(
                  (final ProductOffer data) => data.toJson(),
                ),
              ),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class ProductOffer {
  ProductOffer.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    offerType = json['offer_type'];
    amount = json['amount'];
    fromDate =
        json['from_date'] == null ? null : DateTime.parse(json['from_date']);
    toDate = json['to_date'] == null ? null : DateTime.parse(json['to_date']);
  }

  ProductOffer({
    this.product,
    this.offerType,
    this.amount,
    this.fromDate,
    this.toDate,
  });
  int? id;
  int? product;
  String? offerType;
  String? amount;
  DateTime? fromDate;
  DateTime? toDate;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'product': product,
        'offer_type': offerType,
        'amount': amount,
        'from_date': fromDate != null
            ? "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}"
            : null,
        'to_date': toDate != null
            ? "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}"
            : null,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
