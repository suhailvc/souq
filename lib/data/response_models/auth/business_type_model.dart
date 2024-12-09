class BusinessCategory {
  BusinessCategory({
    this.id,
    this.name,
    this.icon,
  });

  BusinessCategory.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
  }
  int? id;
  String? name;
  String? icon;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'icon': icon,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}
