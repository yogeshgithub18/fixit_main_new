class ServiceProviderResponse {
  bool? status;
  String? message;
  List<ServiceProvider>? data;

  ServiceProviderResponse({this.status, this.message, this.data});

  ServiceProviderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ServiceProvider>[];
      json['data'].forEach((v) {
        data!.add(new ServiceProvider.fromJson(v));
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

class ServiceProvider {
  int? id;
  String? name;
  String? image;
  String? dark_image;
  String? price;
  String? description;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Subcategories>? subcategories;

  ServiceProvider(
      {this.id,
        this.name,
        this.image,
        this.price,
        this.dark_image,
        this.description,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.subcategories});

  ServiceProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    dark_image = json['dark_image'];
    price = json['price'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['subcategories'] != null) {
      subcategories = <Subcategories>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['dark_image'] = this.dark_image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Subcategories {
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
  int? is_favourite;


  Subcategories({this.id,
    this.langId,
    this.name,
    this.arName,
    this.kuName,
    this.catId,
    this.description,
    this.arDescription,
    this.image,
    this.darkImage,
    this.is_favourite,
    this.kuDescription,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDeleted});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langId = json['lang_id'];
    name = json['name'];
    arName = json['ar_name'];
    kuName = json['ku_name'];
    catId = json['cat_id'];
    is_favourite = json['is_favourite'];
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
    data['is_favourite'] = this.is_favourite;
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