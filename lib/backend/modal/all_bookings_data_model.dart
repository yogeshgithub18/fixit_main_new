class AllBookingsDataModel {
  bool? status;
  String? message;
  List<Data>? data;

  AllBookingsDataModel({this.status, this.message, this.data});

  AllBookingsDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  int?unread_message;
  String? userId;
  String? userLocationId;
  String? categoryId;
  String? date;
  String? fromTime;
  String? toTime;
  String? description;
  int? status;
  String? serviceProviderId;
  String? pricePerDay;
  int? isAccept;
  int? isClientConfirm;
  int? serviceProviderStatus;
  int? isComplete;
  String? addonPrice;
  String? addonPriceReason;
  String? grandtotal;
  dynamic rating;
  dynamic ratingComment;
  int? isCancel;
  String? cancelBy;
  int? bookingStatus;
  String? createdAt;
  String? updatedAt;
  User? user;
  Category? category;
  ServiceProvider? serviceProvider;
  Subcategory? subcategory;
  UserLocation? userLocation;

  Data(
      {this.id,
        this.unread_message,
      this.userId,
      this.userLocationId,
      this.categoryId,
      this.date,
      this.fromTime,
      this.toTime,
      this.description,
      this.status,
      this.serviceProviderId,
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
      this.isCancel,
      this.cancelBy,
      this.bookingStatus,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.category,
        this.subcategory,
      this.serviceProvider,
      this.userLocation});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unread_message=json['unread_message'];
    userId = json['user_id'];
    userLocationId = json['user_location_id'];
    categoryId = json['category_id'];
    date = json['date'];
    fromTime = json['from_time'];
    toTime = json['to_time'];
    description = json['description'];
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
    isCancel = json['is_cancel'];
    cancelBy = json['cancel_by'];
    bookingStatus = json['booking_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    serviceProvider = json['service_provider'] != null
        ? new ServiceProvider.fromJson(json['service_provider'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
    userLocation = json['user_location'] != null
        ? new UserLocation.fromJson(json['user_location'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unread_message']=this.unread_message;
    data['user_id'] = this.userId;
    data['user_location_id'] = this.userLocationId;
    data['category_id'] = this.categoryId;
    data['date'] = this.date;
    data['from_time'] = this.fromTime;
    data['to_time'] = this.toTime;
    data['description'] = this.description;
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
    data['is_cancel'] = this.isCancel;
    data['cancel_by'] = this.cancelBy;
    data['booking_status'] = this.bookingStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.serviceProvider != null) {
      data['service_provider'] = this.serviceProvider!.toJson();
    }
    if (this.userLocation != null) {
      data['user_location'] = this.userLocation!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic emailVerifiedAt;
  String? pwd;
  Null description;
  String? gender;
  String? userLocationId;
  String? fcmToken;
  String? latitude;
  String ?longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  dynamic categoryId;
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
      this.fcmToken,
      this.latitude,
      this.longitude,
      this.isNotification,
      this.isNightMode,
      this.isAvailable,
      this.roleId,
      this.categoryId,
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
    fcmToken = json['fcm_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    categoryId = json['category_id'];
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
    data['fcm_token'] = this.fcmToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
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

class ServiceProvider {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  dynamic emailVerifiedAt;
  String? pwd;
  String? description;
  String? gender;
  dynamic userLocationId;
  String? fcmToken;
  dynamic latitude;
  dynamic longitude;
  String? isNotification;
  String? isNightMode;
  int? isAvailable;
  int? roleId;
  String? categoryId;
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
      this.fcmToken,
      this.latitude,
      this.longitude,
      this.isNotification,
      this.isNightMode,
      this.isAvailable,
      this.roleId,
      this.categoryId,
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
    fcmToken = json['fcm_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isNotification = json['is_notification'];
    isNightMode = json['is_night_mode'];
    isAvailable = json['is_available'];
    roleId = json['role_id'];
    categoryId = json['category_id'];
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
    data['fcm_token'] = this.fcmToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['is_notification'] = this.isNotification;
    data['is_night_mode'] = this.isNightMode;
    data['is_available'] = this.isAvailable;
    data['role_id'] = this.roleId;
    data['category_id'] = this.categoryId;
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
