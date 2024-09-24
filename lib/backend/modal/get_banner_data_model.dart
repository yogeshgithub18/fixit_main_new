class GetBannerDataModel {
  bool? status;
  String? message;
  List<BannerData>? data;
  List<SubbannerData>? subbannerData;
  BannerInformation? bannerInformation;

  GetBannerDataModel({this.status, this.message, this.data,this.bannerInformation,this.subbannerData});

  GetBannerDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
      });
    }
    if (json['subbanner_data'] != null) {
      subbannerData = <SubbannerData>[];
      json['subbanner_data'].forEach((v) {
        subbannerData!.add(new SubbannerData.fromJson(v));
      });
    }
    bannerInformation = json['banner_information'] != null
        ? new BannerInformation.fromJson(json['banner_information'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.subbannerData != null) {
      data['subbanner_data'] =
          this.subbannerData!.map((v) => v.toJson()).toList();
    }
    if (this.bannerInformation != null) {
      data['banner_information'] = this.bannerInformation!.toJson();
    }
    return data;
  }
}

class BannerData {
  int? id;
  String? name;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;

  BannerData(
      {this.id,
        this.name,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class BannerInformation {
  bool? bannerSlideStatus;
  int? bannerDuration;

  BannerInformation({this.bannerSlideStatus, this.bannerDuration});

  BannerInformation.fromJson(Map<String, dynamic> json) {
    bannerSlideStatus = json['banner_slide_status'];
    bannerDuration = json['banner_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_slide_status'] = this.bannerSlideStatus;
    data['banner_duration'] = this.bannerDuration;
    return data;
  }
}
class SubbannerData {
  int? id;
  String? title;
  String? subtitle;
  String? langId;
  String? categoryId;
  String? description;
  String? subcategoryId;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;
  String? categoryName;
  String? categoryDescription;
  String? subcategoryName;
  String? subcategoryDescription;
  Category? category;
  Subcategory? subcategory;

  SubbannerData(
      {this.id,
        this.title,
        this.subtitle,
        this.langId,
        this.categoryId,
        this.description,
        this.subcategoryId,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.isDeleted,
        this.categoryName,
        this.categoryDescription,
        this.subcategoryName,
        this.subcategoryDescription,
        this.category,
        this.subcategory});

  SubbannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    langId = json['lang_id'];
    categoryId = json['category_id'];
    description = json['description'];
    subcategoryId = json['subcategory_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
    categoryName = json['category_name'];
    categoryDescription = json['category_description'];
    subcategoryName = json['subcategory_name'];
    subcategoryDescription = json['subcategory_description'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    subcategory = json['subcategory'] != null
        ? new Subcategory.fromJson(json['subcategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['lang_id'] = this.langId;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['subcategory_id'] = this.subcategoryId;
    data['image'] = this.image;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_deleted'] = this.isDeleted;
    data['category_name'] = this.categoryName;
    data['category_description'] = this.categoryDescription;
    data['subcategory_name'] = this.subcategoryName;
    data['subcategory_description'] = this.subcategoryDescription;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.toJson();
    }
    return data;
  }
}

class Category {
  int? id;
  String? orderNo;
  int? langId;
  String? name;
  String? arName;
  String? kuName;
  String? image;
  String? darkImage;
  String? price;
  String? description;
  String? arDescription;
  String? kuDescription;
  int? status;
  int? isDeleted;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.orderNo,
        this.langId,
        this.name,
        this.arName,
        this.kuName,
        this.image,
        this.darkImage,
        this.price,
        this.description,
        this.arDescription,
        this.kuDescription,
        this.status,
        this.isDeleted,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    langId = json['lang_id'];
    name = json['name'];
    arName = json['ar_name'];
    kuName = json['ku_name'];
    image = json['image'];
    darkImage = json['dark_image'];
    price = json['price'];
    description = json['description'];
    arDescription = json['ar_description'];
    kuDescription = json['ku_description'];
    status = json['status'];
    isDeleted = json['is_deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['lang_id'] = this.langId;
    data['name'] = this.name;
    data['ar_name'] = this.arName;
    data['ku_name'] = this.kuName;
    data['image'] = this.image;
    data['dark_image'] = this.darkImage;
    data['price'] = this.price;
    data['description'] = this.description;
    data['ar_description'] = this.arDescription;
    data['ku_description'] = this.kuDescription;
    data['status'] = this.status;
    data['is_deleted'] = this.isDeleted;
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