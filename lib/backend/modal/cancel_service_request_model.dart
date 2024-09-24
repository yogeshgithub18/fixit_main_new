// ignore_for_file: dead_code

class Cancel_Service_Model {
  bool? _status;
  String? _message;
  Data? _data;

  Cancel_Service_Model({bool? status, String? message, Data? data}) {
    if (status != null) {
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  bool? get status => _status;
  set status(bool? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  Data? get data => _data;
  set data(Data? data) => _data = data;

  Cancel_Service_Model.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  int? _id;
  String? _userId;
  String? _userLocationId;
  String? _categoryId;
  String? _date;
  String? _fromTime;
  String? _toTime;
  String? _description;
  int? _status;
  Null _serviceProviderId;
  String? _pricePerDay;
  int? _isAccept;
  int? _isClientConfirm;
  int? _serviceProviderStatus;
  int? _isComplete;
  Null _addonPrice;
  Null _addonPriceReason;
  Null _grandtotal;
  Null _rating;
  Null _ratingComment;
  int? _isCancel;
  Null _cancelBy;
  int? _cancelRequest;
  int? _bookingStatus;
  Null _completedDate;
  String? _createdAt;
  String? _updatedAt;
  User? _user;
  Null _serviceProvider;

  Data(
      {int? id,
        String? userId,
        String? userLocationId,
        String? categoryId,
        String? date,
        String? fromTime,
        String? toTime,
        String? description,
        int? status,
        Null serviceProviderId,
        String? pricePerDay,
        int? isAccept,
        int? isClientConfirm,
        int? serviceProviderStatus,
        int? isComplete,
        Null addonPrice,
        Null addonPriceReason,
        Null grandtotal,
        Null rating,
        Null ratingComment,
        int? isCancel,
        Null cancelBy,
        int? cancelRequest,
        int? bookingStatus,
        Null completedDate,
        String? createdAt,
        String? updatedAt,
        User? user,
        Null serviceProvider}) {
    if (id != null) {
      this._id = id;
    }
    if (userId != null) {
      this._userId = userId;
    }
    if (userLocationId != null) {
      this._userLocationId = userLocationId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (date != null) {
      this._date = date;
    }
    if (fromTime != null) {
      this._fromTime = fromTime;
    }
    if (toTime != null) {
      this._toTime = toTime;
    }
    if (description != null) {
      this._description = description;
    }
    if (status != null) {
      this._status = status;
    }
    if (serviceProviderId != null) {
    }
    if (pricePerDay != null) {
      this._pricePerDay = pricePerDay;
    }
    if (isAccept != null) {
      this._isAccept = isAccept;
    }
    if (isClientConfirm != null) {
      this._isClientConfirm = isClientConfirm;
    }
    if (serviceProviderStatus != null) {
      this._serviceProviderStatus = serviceProviderStatus;
    }
    if (isComplete != null) {
      this._isComplete = isComplete;
    }
    if (addonPrice != null) {
      this._addonPrice = addonPrice;
    }
    if (addonPriceReason != null) {
      this._addonPriceReason = addonPriceReason;
    }
    if (grandtotal != null) {
      this._grandtotal = grandtotal;
    }
    if (rating != null) {
      this._rating = rating;
    }
    if (ratingComment != null) {
      this._ratingComment = ratingComment;
    }
    if (isCancel != null) {
      this._isCancel = isCancel;
    }
    if (cancelBy != null) {
      this._cancelBy = cancelBy;
    }
    if (cancelRequest != null) {
      this._cancelRequest = cancelRequest;
    }
    if (bookingStatus != null) {
      this._bookingStatus = bookingStatus;
    }
    if (completedDate != null) {
      this._completedDate = completedDate;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (user != null) {
      this._user = user;
    }
    if (serviceProvider != null) {
      this._serviceProvider = serviceProvider;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get userId => _userId;
  set userId(String? userId) => _userId = userId;
  String? get userLocationId => _userLocationId;
  set userLocationId(String? userLocationId) =>
      _userLocationId = userLocationId;
  String? get categoryId => _categoryId;
  set categoryId(String? categoryId) => _categoryId = categoryId;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get fromTime => _fromTime;
  set fromTime(String? fromTime) => _fromTime = fromTime;
  String? get toTime => _toTime;
  set toTime(String? toTime) => _toTime = toTime;
  String? get description => _description;
  set description(String? description) => _description = description;
  int? get status => _status;
  set status(int? status) => _status = status;
  Null get serviceProviderId => _serviceProviderId;
  set serviceProviderId(Null serviceProviderId) =>
      _serviceProviderId = serviceProviderId;
  String? get pricePerDay => _pricePerDay;
  set pricePerDay(String? pricePerDay) => _pricePerDay = pricePerDay;
  int? get isAccept => _isAccept;
  set isAccept(int? isAccept) => _isAccept = isAccept;
  int? get isClientConfirm => _isClientConfirm;
  set isClientConfirm(int? isClientConfirm) =>
      _isClientConfirm = isClientConfirm;
  int? get serviceProviderStatus => _serviceProviderStatus;
  set serviceProviderStatus(int? serviceProviderStatus) =>
      _serviceProviderStatus = serviceProviderStatus;
  int? get isComplete => _isComplete;
  set isComplete(int? isComplete) => _isComplete = isComplete;
  Null get addonPrice => _addonPrice;
  set addonPrice(Null addonPrice) => _addonPrice = addonPrice;
  Null get addonPriceReason => _addonPriceReason;
  set addonPriceReason(Null addonPriceReason) =>
      _addonPriceReason = addonPriceReason;
  Null get grandtotal => _grandtotal;
  set grandtotal(Null grandtotal) => _grandtotal = grandtotal;
  Null get rating => _rating;
  set rating(Null rating) => _rating = rating;
  Null get ratingComment => _ratingComment;
  set ratingComment(Null ratingComment) => _ratingComment = ratingComment;
  int? get isCancel => _isCancel;
  set isCancel(int? isCancel) => _isCancel = isCancel;
  Null get cancelBy => _cancelBy;
  set cancelBy(Null cancelBy) => _cancelBy = cancelBy;
  int? get cancelRequest => _cancelRequest;
  set cancelRequest(int? cancelRequest) => _cancelRequest = cancelRequest;
  int? get bookingStatus => _bookingStatus;
  set bookingStatus(int? bookingStatus) => _bookingStatus = bookingStatus;
  Null get completedDate => _completedDate;
  set completedDate(Null completedDate) => _completedDate = completedDate;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  User? get user => _user;
  set user(User? user) => _user = user;
  Null get serviceProvider => _serviceProvider;
  set serviceProvider(Null serviceProvider) =>
      _serviceProvider = serviceProvider;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userLocationId = json['user_location_id'];
    _categoryId = json['category_id'];
    _date = json['date'];
    _fromTime = json['from_time'];
    _toTime = json['to_time'];
    _description = json['description'];
    _status = json['status'];
    _serviceProviderId = json['service_provider_id'];
    _pricePerDay = json['price_per_day'];
    _isAccept = json['is_accept'];
    _isClientConfirm = json['is_client_confirm'];
    _serviceProviderStatus = json['service_provider_status'];
    _isComplete = json['is_complete'];
    _addonPrice = json['addon_price'];
    _addonPriceReason = json['addon_price_reason'];
    _grandtotal = json['grandtotal'];
    _rating = json['rating'];
    _ratingComment = json['rating_comment'];
    _isCancel = json['is_cancel'];
    _cancelBy = json['cancel_by'];
    _cancelRequest = json['cancel_request'];
    _bookingStatus = json['booking_status'];
    _completedDate = json['completed_date'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _serviceProvider = json['service_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['user_id'] = this._userId;
    data['user_location_id'] = this._userLocationId;
    data['category_id'] = this._categoryId;
    data['date'] = this._date;
    data['from_time'] = this._fromTime;
    data['to_time'] = this._toTime;
    data['description'] = this._description;
    data['status'] = this._status;
    data['service_provider_id'] = this._serviceProviderId;
    data['price_per_day'] = this._pricePerDay;
    data['is_accept'] = this._isAccept;
    data['is_client_confirm'] = this._isClientConfirm;
    data['service_provider_status'] = this._serviceProviderStatus;
    data['is_complete'] = this._isComplete;
    data['addon_price'] = this._addonPrice;
    data['addon_price_reason'] = this._addonPriceReason;
    data['grandtotal'] = this._grandtotal;
    data['rating'] = this._rating;
    data['rating_comment'] = this._ratingComment;
    data['is_cancel'] = this._isCancel;
    data['cancel_by'] = this._cancelBy;
    data['cancel_request'] = this._cancelRequest;
    data['booking_status'] = this._bookingStatus;
    data['completed_date'] = this._completedDate;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    data['service_provider'] = this._serviceProvider;
    return data;
  }
}

class User {
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  Null _emailVerifiedAt;
  String? _pwd;
  Null _description;
  String? _gender;
  String? _userLocationId;
  String? _fcmToken;
  dynamic _latitude;
  dynamic _longitude;
  String? _isNotification;
  String? _isNightMode;
  int? _isAvailable;
  int? _roleId;
  Null _categoryId;
  int? _status;
  int? _isOnline;
  int? _isVerified;
  String? _createdAt;
  String? _updatedAt;

  User(
      {int? id,
        String? name,
        String? email,
        String? phone,
        String? image,
        Null emailVerifiedAt,
        String? pwd,
        Null description,
        String? gender,
        String? userLocationId,
        String? fcmToken,
        Null latitude,
        Null longitude,
        String? isNotification,
        String? isNightMode,
        int? isAvailable,
        int? roleId,
        Null categoryId,
        int? status,
        int? isOnline,
        int? isVerified,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (image != null) {
      this._image = image;
    }
    if (emailVerifiedAt != null) {
      this._emailVerifiedAt = emailVerifiedAt;
    }
    if (pwd != null) {
      this._pwd = pwd;
    }
    if (description != null) {
      this._description = description;
    }
    if (gender != null) {
      this._gender = gender;
    }
    if (userLocationId != null) {
      this._userLocationId = userLocationId;
    }
    if (fcmToken != null) {
      this._fcmToken = fcmToken;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (isNotification != null) {
      this._isNotification = isNotification;
    }
    if (isNightMode != null) {
      this._isNightMode = isNightMode;
    }
    if (isAvailable != null) {
      this._isAvailable = isAvailable;
    }
    if (roleId != null) {
      this._roleId = roleId;
    }
    if (categoryId != null) {
      this._categoryId = categoryId;
    }
    if (status != null) {
      this._status = status;
    }
    if (isOnline != null) {
      this._isOnline = isOnline;
    }
    if (isVerified != null) {
      this._isVerified = isVerified;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get image => _image;
  set image(String? image) => _image = image;
  Null get emailVerifiedAt => _emailVerifiedAt;
  set emailVerifiedAt(Null emailVerifiedAt) =>
      _emailVerifiedAt = emailVerifiedAt;
  String? get pwd => _pwd;
  set pwd(String? pwd) => _pwd = pwd;
  Null get description => _description;
  set description(Null description) => _description = description;
  String? get gender => _gender;
  set gender(String? gender) => _gender = gender;
  String? get userLocationId => _userLocationId;
  set userLocationId(String? userLocationId) =>
      _userLocationId = userLocationId;
  String? get fcmToken => _fcmToken;
  set fcmToken(String? fcmToken) => _fcmToken = fcmToken;
  Null get latitude => _latitude;
  set latitude(Null latitude) => _latitude = latitude;
  Null get longitude => _longitude;
  set longitude(Null longitude) => _longitude = longitude;
  String? get isNotification => _isNotification;
  set isNotification(String? isNotification) =>
      _isNotification = isNotification;
  String? get isNightMode => _isNightMode;
  set isNightMode(String? isNightMode) => _isNightMode = isNightMode;
  int? get isAvailable => _isAvailable;
  set isAvailable(int? isAvailable) => _isAvailable = isAvailable;
  int? get roleId => _roleId;
  set roleId(int? roleId) => _roleId = roleId;
  Null get categoryId => _categoryId;
  set categoryId(Null categoryId) => _categoryId = categoryId;
  int? get status => _status;
  set status(int? status) => _status = status;
  int? get isOnline => _isOnline;
  set isOnline(int? isOnline) => _isOnline = isOnline;
  int? get isVerified => _isVerified;
  set isVerified(int? isVerified) => _isVerified = isVerified;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _emailVerifiedAt = json['email_verified_at'];
    _pwd = json['pwd'];
    _description = json['description'];
    _gender = json['gender'];
    _userLocationId = json['user_location_id'];
    _fcmToken = json['fcm_token'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _isNotification = json['is_notification'];
    _isNightMode = json['is_night_mode'];
    _isAvailable = json['is_available'];
    _roleId = json['role_id'];
    _categoryId = json['category_id'];
    _status = json['status'];
    _isOnline = json['is_online'];
    _isVerified = json['is_verified'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['phone'] = this._phone;
    data['image'] = this._image;
    data['email_verified_at'] = this._emailVerifiedAt;
    data['pwd'] = this._pwd;
    data['description'] = this._description;
    data['gender'] = this._gender;
    data['user_location_id'] = this._userLocationId;
    data['fcm_token'] = this._fcmToken;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['is_notification'] = this._isNotification;
    data['is_night_mode'] = this._isNightMode;
    data['is_available'] = this._isAvailable;
    data['role_id'] = this._roleId;
    data['category_id'] = this._categoryId;
    data['status'] = this._status;
    data['is_online'] = this._isOnline;
    data['is_verified'] = this._isVerified;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}
