class CartItemModel {
  CartItemModel.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'];
    status = json['status'];
    totalItems = json['total_items'];
    totalPrice = json['total_price'];
    items = json['items'] == null
        ? <CartItem>[]
        : List<CartItem>.from(
            json['items']!.map(
              (final dynamic x) => CartItem.fromJson(x),
            ),
          );
  }

  CartItemModel({
    this.id,
    this.user,
    this.status,
    this.totalItems,
    this.totalPrice,
    this.items,
  });
  int? id;
  int? user;
  String? status;
  int? totalItems;
  double? totalPrice;
  List<CartItem>? items;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'user': user,
        'status': status,
        'total_items': totalItems,
        'total_price': totalPrice,
        'items': items == null
            ? <dynamic>[]
            : List<dynamic>.from(items!.map((final CartItem x) => x.toJson())),
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class CartItem {
  CartItem({
    this.id,
    this.product,
    this.qty,
    this.created,
    this.totalPrice,
  });

  CartItem.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    qty = json['qty'];
    created = json['created'] == null ? null : DateTime.parse(json['created']);
    totalPrice = json['total_price'];
  }
  int? id;
  int? product;
  int? qty;
  DateTime? created;
  double? totalPrice;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'product': product,
        'qty': qty,
        'created': created?.toIso8601String(),
        'total_price': totalPrice,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
