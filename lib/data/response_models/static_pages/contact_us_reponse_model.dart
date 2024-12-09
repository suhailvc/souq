class ContactUsResponse {
  ContactUsResponse(
      {this.id,
      this.latitude,
      this.longitude,
      this.email,
      this.firstName,
      this.lastName,
      this.contactNumber,
      this.message});

  ContactUsResponse.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    contactNumber = json['contact_number'];
    message = json['message'];
  }
  int? id;
  dynamic latitude;
  dynamic longitude;
  String? email;
  String? firstName;
  String? lastName;
  String? contactNumber;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['contact_number'] = this.contactNumber;
    data['message'] = this.message;
    return data;
  }

  @override
  String toString() {
    return toJson.toString();
  }
}
