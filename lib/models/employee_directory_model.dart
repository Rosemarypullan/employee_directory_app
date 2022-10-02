class EmployeeModel {
  int? id;
  String name = "";
  String username = "";
  String email = "";
  String profileImage = "";
  Address? address;
  String phone = "";
  String website = "";
  Company? company;

  EmployeeModel(
      {this.id,
      required this.name,
      required this.username,
      required this.email,
      required this.profileImage,
      this.address,
      required this.phone,
      required this.website,
      required this.company});

  EmployeeModel.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    if (json['profile_image'] != null) {
      profileImage = json['profile_image'];
    } else {
      profileImage = "";
    }
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    if (json['phone'] != null) {
      phone = json['phone'];
    } else {
      phone = "";
    }
    if (json['website'] != null) {
      website = json['website'];
    } else {
      website = "";
    }
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['phone'] = this.phone;
    data['website'] = this.website;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Address {
  String street = "";

  String? suite;
  String city = "";
  String? zipcode;
  Geo? geo;

  Address(
      {required this.street,
      this.suite,
      required this.city,
      this.zipcode,
      this.geo});

  Address.fromJson(Map<String?, dynamic> json) {
    street = json['street'];
    suite = json['suite'];
    city = json['city'];
    zipcode = json['zipcode'];
    geo = json['geo'] != null ? new Geo.fromJson(json['geo']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['street'] = this.street;
    data['suite'] = this.suite;
    data['city'] = this.city;
    data['zipcode'] = this.zipcode;
    if (this.geo != null) {
      data['geo'] = this.geo!.toJson();
    }
    return data;
  }
}

class Geo {
  String? lat;
  String? lng;

  Geo({this.lat, this.lng});

  Geo.fromJson(Map<String?, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Company {
  String name = "";
  String? catchPhrase;
  String? bs;

  Company({required this.name, this.catchPhrase, this.bs});

  Company.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    catchPhrase = json['catchPhrase'];
    bs = json['bs'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['name'] = this.name;
    data['catchPhrase'] = this.catchPhrase;
    data['bs'] = this.bs;
    return data;
  }
}
