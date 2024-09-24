class LocationDataModel {
  bool? status;
  String? message;
  List<LocationData>? data;

  LocationDataModel({this.status, this.message, this.data});

  LocationDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LocationData>[];
      json['data'].forEach((v) {
        data!.add(new LocationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationData {
  int? id;
  String? userId;
  String? streetNo;
  String? streetName;
  String? location;
  String? city;
  String? country;
  String? pincode;
  String? latitude;
  String? longitude;
  int? status;
  String? createdAt;
  String? updatedAt;

  LocationData(
      {this.id,
      this.userId,
      this.streetNo,
      this.streetName,
      this.location,
      this.latitude,
      this.longitude,
      this.city,
      this.country,
      this.pincode,
      this.status,
      this.createdAt,
      this.updatedAt});

  LocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    streetNo = json['street_no'];
    streetName = json['street_name'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    country = json['country'];
    pincode = json['pincode'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['street_no'] = this.streetNo;
    data['street_name'] = this.streetName;
    data['location'] = this.location;
    data['city'] = this.city;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
