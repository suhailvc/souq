class DriverListModel {
  DriverListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  DriverListModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    results = json['results'] == null
        ? <Driver>[]
        : List<Driver>.from(
            json['results']!.map((final dynamic x) => Driver.fromJson(x)));
  }
  int? count;
  dynamic next;
  dynamic previous;
  List<Driver>? results;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'next': next,
        'previous': previous,
        'results': results == null
            ? <dynamic>[]
            : List<dynamic>.from(
                results!.map(
                  (final Driver x) => x.toJson(),
                ),
              ),
      };
  @override
  String toString() {
    return toJson().toString();
  }
}

class Driver {
  Driver.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'] == null ? null : DateTime.parse(json['created']);
    status = json['status'];
    profileImage = json['profile_image'];
    uuid = json['uuid'];
    contactNumber = json['contact_number'];
  }

  Driver({
    this.id,
    this.name,
    this.created,
    this.status,
    this.profileImage,
    this.uuid,
    this.contactNumber,
    this.isSelected = false,
  });
  int? id;
  String? name;
  DateTime? created;
  int? status;
  String? profileImage;
  String? uuid;
  String? contactNumber;
  bool? isSelected;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'created': created?.toIso8601String(),
        'status': status,
        'profile_image': profileImage,
        'uuid': uuid,
        'contact_number': contactNumber,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
