class FavListResponse {
  bool? status;
  String? message;
  List<FavData>? data;

  FavListResponse({this.status, this.message, this.data});

  FavListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data!.add(new FavData.fromJson(v));
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

class FavData {
  int? id;
  String? userId;
  String? categoriesId;
  String? subcategoriesId;
  int? status;
  String? createdAt;
  String? updatedAt;
  Category? category;
  Subcategory? subcategory;

  FavData(
      {this.id,
        this.userId,
        this.categoriesId,
        this.subcategoriesId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.subcategory});

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoriesId = json['categories_id'];
    subcategoriesId = json['subcategories_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['user_id'] = this.userId;
    data['categories_id'] = this.categoriesId;
    data['subcategories_id'] = this.subcategoriesId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  String? price;

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
        this.price,
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
    price = json['price'];
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
    data['price'] = this.price;
    return data;
  }
}
