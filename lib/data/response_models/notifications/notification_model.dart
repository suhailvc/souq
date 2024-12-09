class NotificationResponseModel {
  NotificationResponseModel(
      {this.count,
      this.next,
      this.previous,
      this.results,
      this.unreadNotificationCount});

  NotificationResponseModel.fromJson(final Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <NotificationsModel>[];
      json['results'].forEach((final v) {
        results!.add(new NotificationsModel.fromJson(v));
      });
    }
    unreadNotificationCount = json['unread_notification_count'];
  }
  int? count;
  String? next;
  String? previous;
  List<NotificationsModel>? results;
  int? unreadNotificationCount;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this
          .results!
          .map((final NotificationsModel v) => v.toJson())
          .toList();
    }
    data['unread_notification_count'] = this.unreadNotificationCount;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NotificationsModel {
  NotificationsModel({this.timestamp, this.notification});

  NotificationsModel.fromJson(final Map<String, dynamic> json) {
    timestamp =
        json['timestamp'] == null ? null : DateTime.parse(json['timestamp']);
    if (json['notification'] != null) {
      notification = <NotificationResults>[];
      json['notification'].forEach((final v) {
        notification!.add(new NotificationResults.fromJson(v));
      });
    }
  }
  DateTime? timestamp;
  List<NotificationResults>? notification;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp?.toIso8601String();
    if (this.notification != null) {
      data['notification'] = this
          .notification!
          .map((final NotificationResults v) => v.toJson())
          .toList();
    }
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

class NotificationResults {
  NotificationResults(
      {this.id,
      this.verb,
      this.description,
      this.unread,
      this.timestamp,
      this.type,
      this.slugId,
      this.actionData});

  NotificationResults.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    verb = json['verb'];
    description = json['description'];
    unread = json['unread'];
    timestamp =
        json['timestamp'] == null ? null : DateTime.parse(json['timestamp']);
    type = json['type'];
    slugId = json['slug_id'];
    actionData = json['action_data'];
  }
  int? id;
  String? verb;
  String? description;
  bool? unread;
  DateTime? timestamp;
  String? type;
  String? slugId;
  dynamic actionData;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verb'] = this.verb;
    data['description'] = this.description;
    data['unread'] = this.unread;
    data['timestamp'] = this.timestamp?.toIso8601String();
    data['type'] = this.type;
    data['slug_id'] = this.slugId;
    data['action_data'] = this.actionData;
    return data;
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
