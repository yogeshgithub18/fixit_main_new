class BookingDetailDataModel {
  bool? status;
  String? message;
  BookingDetailData? data;

  BookingDetailDataModel({this.status, this.message, this.data});

  BookingDetailDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? new BookingDetailData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class BookingDetailData {
  int? id;
  String? userId;
  String? userLocationId;
  String? categoryId;
  String? date;
  String? fromTime;
  String? toTime;
  int? status;
  String? totalRatingSp;
  String? text_description;
  String? serviceProviderId;
  String? pricePerDay;
  int? isAccept;
  int? isClientConfirm;
  int? serviceProviderStatus;
  int? isComplete;
  String? addonPrice;
  String? addonPriceReason;
  String? grandtotal;
  String? rating;
  String? ratingComment;
  int? bookingStatus;
  String? createdAt;
  String? updatedAt;
  Category? category;
  User? user;
  UserLocation? userLocation;
  Subcategory? subcategory;
  ServiceProvider? serviceProvider;

  BookingDetailData(
      {this.id,
      this.userId,
      this.userLocationId,
      this.categoryId,
      this.text_description,
      this.date,
      this.fromTime,
      this.toTime,
      this.status,
      this.serviceProviderId,
      this.totalRatingSp,
      this.pricePerDay,
      this.isAccept,
        this.isClientConfirm,
      this.serviceProviderStatus,
      this.isComplete,
      this.addonPrice,
      this.addonPriceReason,
      this.grandtotal,
      this.rating,
      this.ratingComment,
      this.bookingStatus,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.user,
      this.userLocation,
        this.subcategory,
      this.serviceProvider});

  BookingDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userLocationId = json['user_location_id'];
    totalRatingSp = json['total_rating_sp'] != null ?  json['total_rating_sp'].toString() : null;
    categoryId = json['category_id'];
    date = json['date'];
    fromTime = json['from_time'];
    text_description = json['text_description'];
    toTime = json['to_time'];
    status = json['status'];
    serviceProviderId = json['service_provider_id'];
    pricePerDay = json['price_per_day'];
    isAccept = json['is_accept'];
    isClientConfirm = json['is_client_confirm'];
    serviceProviderStatus = json['service_provider_status'];
    isComplete = json['is_complete'];
    addonPrice = json['addon_price'];
    addonPriceReason = json['addon_price_reason'];
    grandtotal = json['grandtotal'];
    rating = json['rating'];
    ratingComment = json['rating_comment'];
    bookingStatus = json['booking_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    userLocation = json['user_location'] != null
        ? UserLocation.fromJson(json['user_location'])
        : null;
    serviceProvider = json['service_provider'] != null
        ? ServiceProvider.fromJson(json['service_provider'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_location_id'] = this.userLocationId;
    data['category_id'] = this.categoryId;
    data['text_description'] = this.text_description;
    data['date'] = this.date;
    data['total_rating_sp'] = this.totalRatingSp;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['status'] = this.status;
    data['service_provider_id'] = this.serviceProviderId;
    data['price_per_day'] = this.pricePerDay;
    data['is_accept'] = this.isAccept;
    data['is_client_confirm'] = this.isClientConfirm;
    data['service_provider_status'] = this.serviceProviderStatus;
    data['is_complete'] = this.isComplete;
    data['addon_price'] = this.addonPrice;
    data['addon_price_reason'] = this.addonPriceReason;
    data['grandtotal'] = this.grandtotal;
    data['rating'] = this.rating;
    data['rating_comment'] = this.ratingComment;
    data['booking_status'] = this.bookingStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.userLocation != null) {
      data['user_location'] = this.userLocation!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    if (this.serviceProvider != null) {
      data['service_provider'] = this.serviceProvider!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "serviceprovider___$serviceProviderStatus";
  }
}

class Category {
  int? id;
  String? name;
  String? image;
  String? price;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.description,
      this.status,
      this.createdAt,
      this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? emailVerifiedAt;
  String? pwd;
  String? description;
  String? gender;
  String? userLocationId;
  String? latitude;
  String? longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  int? status;
  int? isVerified;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.emailVerifiedAt,
      this.pwd,
      this.description,
      this.gender,
      this.userLocationId,
      this.latitude,
      this.longitude,
      this.isNotification,
      this.isNightMode,
      this.isAvailable,
      this.roleId,
      this.status,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    pwd = json['pwd'];
    description = json['description'];
    gender = json['gender'];
    userLocationId = json['user_location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    status = json['status'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['pwd'] = this.pwd;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['user_location_id'] = this.userLocationId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserLocation {
  int? id;
  String? userId;
  String? streetNo;
  String? streetName;
  String? location;
  String? city;
  String? country;
  String? pincode;
  int? status;
  String? createdAt;
  String? updatedAt;

  UserLocation(
      {this.id,
      this.userId,
      this.streetNo,
      this.streetName,
      this.location,
      this.city,
      this.country,
      this.pincode,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserLocation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    streetNo = json['street_no'];
    streetName = json['street_name'];
    location = json['location'];
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
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ServiceProvider {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? emailVerifiedAt;
  String? pwd;
  String? description;
  String? gender;
  String? userLocationId;
  String? latitude;
  String? longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  int? status;
  int? isVerified;
  String? createdAt;
  String? updatedAt;

  ServiceProvider(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.emailVerifiedAt,
      this.pwd,
      this.description,
      this.gender,
      this.userLocationId,
      this.latitude,
      this.longitude,
      this.isNotification,
      this.isNightMode,
      this.isAvailable,
      this.roleId,
      this.status,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    pwd = json['pwd'];
    description = json['description'];
    gender = json['gender'];
    userLocationId = json['user_location_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    status = json['status'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['pwd'] = this.pwd;
    data['description'] = this.description;
    data['gender'] = this.gender;
    data['user_location_id'] = this.userLocationId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Subcategory {
  int? id;
  String? langId;
  String? name;
  String? arName;
  String? kuName;
  String? catId;
  String? description;
  String? price;
  String? arDescription;
  String? image;
  String? darkImage;
  String? kuDescription;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;

  Subcategory(
      {this.id,
        this.langId,
        this.name,
        this.arName,
        this.kuName,
        this.catId,
        this.description,
        this.price,
        this.arDescription,
        this.image,
        this.darkImage,
        this.kuDescription,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isDeleted});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langId = json['lang_id'];
    name = json['name'];
    arName = json['ar_name'];
    kuName = json['ku_name'];
    catId = json['cat_id'];
    description = json['description'];
    price = json['price'];
    arDescription = json['ar_description'];
    image = json['image'];
    darkImage = json['dark_image'];
    kuDescription = json['ku_description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lang_id'] = this.langId;
    data['name'] = this.name;
    data['ar_name'] = this.arName;
    data['ku_name'] = this.kuName;
    data['cat_id'] = this.catId;
    data['description'] = this.description;
    data['price'] = this.price;
    data['ar_description'] = this.arDescription;
    data['image'] = this.image;
    data['dark_image'] = this.darkImage;
    data['ku_description'] = this.kuDescription;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}
