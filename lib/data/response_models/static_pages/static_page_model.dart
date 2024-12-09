class StaticPageDetails {
  StaticPageDetails({this.id, this.meta, this.title, this.description});

  StaticPageDetails.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    meta =
        json['meta'] != null ? new StaticPageMeta.fromJson(json['meta']) : null;
    title = json['title'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((final v) {
        description!.add(new Description.fromJson(v));
      });
    }
  }
  int? id;
  StaticPageMeta? meta;
  String? title;
  List<Description>? description;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['title'] = this.title;
    if (this.description != null) {
      data['description'] =
          this.description!.map((final v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class StaticPageMeta {
  StaticPageMeta(
      {this.type,
      this.detailUrl,
      this.htmlUrl,
      this.slug,
      this.showInMenus,
      this.seoTitle,
      this.searchDescription,
      this.firstPublishedAt,
      this.parent,
      this.locale});

  StaticPageMeta.fromJson(final Map<String, dynamic> json) {
    type = json['type'];
    detailUrl = json['detail_url'];
    htmlUrl = json['html_url'];
    slug = json['slug'];
    showInMenus = json['show_in_menus'];
    seoTitle = json['seo_title'];
    searchDescription = json['search_description'];
    firstPublishedAt = json['first_published_at'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    locale = json['locale'];
  }
  String? type;
  String? detailUrl;
  String? htmlUrl;
  String? slug;
  bool? showInMenus;
  String? seoTitle;
  String? searchDescription;
  String? firstPublishedAt;
  Parent? parent;
  String? locale;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['detail_url'] = this.detailUrl;
    data['html_url'] = this.htmlUrl;
    data['slug'] = this.slug;
    data['show_in_menus'] = this.showInMenus;
    data['seo_title'] = this.seoTitle;
    data['search_description'] = this.searchDescription;
    data['first_published_at'] = this.firstPublishedAt;
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    data['locale'] = this.locale;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Parent {
  Parent({this.id, this.meta, this.title});

  Parent.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    title = json['title'];
  }
  int? id;
  Meta? meta;
  String? title;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    data['title'] = this.title;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Meta {
  Meta({this.type, this.htmlUrl});

  Meta.fromJson(final Map<String, dynamic> json) {
    type = json['type'];
    htmlUrl = json['html_url'];
  }
  String? type;
  String? htmlUrl;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['html_url'] = this.htmlUrl;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Description {
  Description({this.type, this.value, this.id});

  Description.fromJson(final Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
    id = json['id'];
  }
  String? type;
  Value? value;
  String? id;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}

class Value {
  Value({this.userType, this.title, this.description});

  Value.fromJson(final Map<String, dynamic> json) {
    userType = json['user_type'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }
  String? userType;
  String? title;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;

    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
