// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'order_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  int id;
  String orderNo;
  String linkCode;
  double subtotal;
  double discount;
  dynamic discountType;
  double tax;
  double deliveryFee;
  double total;
  int quantity;
  DateTime deliveryDate;
  dynamic notes;
  int clientId;
  int orderStatusId;
  int branchId;
  int paymentMethodId;
  int orderMethodId;
  dynamic couponId;
  int cityId;
  int zoneId;
  int subZoneId;
  String createdAt;
  String updatedAt;
  int addressId;
  int driverId;
  OrderStatus orderStatus;
  OrderDetailsModelAddress address;
  Branch branch;
  Method paymentMethod;
  List<Detail> details;
  Method orderMethod;

  OrderDetailsModel({
    required this.id,
    required this.orderNo,
    required this.linkCode,
    required this.subtotal,
    required this.discount,
    required this.discountType,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.quantity,
    required this.deliveryDate,
    required this.notes,
    required this.clientId,
    required this.orderStatusId,
    required this.branchId,
    required this.paymentMethodId,
    required this.orderMethodId,
    required this.couponId,
    required this.cityId,
    required this.zoneId,
    required this.subZoneId,
    required this.createdAt,
    required this.updatedAt,
    required this.addressId,
    required this.driverId,
    required this.orderStatus,
    required this.address,
    required this.branch,
    required this.paymentMethod,
    required this.details,
    required this.orderMethod,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
    id: json["id"],
    orderNo: json["order_no"],
    linkCode: json["link_code"],
    subtotal: double.parse(json["subtotal"].toString()),
    discount: double.parse(json["discount"].toString()),
    discountType: json["discount_type"],
    tax: double.parse(json["tax"].toString()),
    deliveryFee: double.parse(json["delivery_fee"].toString()),
    total: double.parse(json["total"].toString()),
    quantity: json["quantity"],
    deliveryDate: DateTime.parse(json["delivery_date"]),
    notes: json["notes"],
    clientId: json["client_id"],
    orderStatusId: json["order_status_id"],
    branchId: json["branch_id"],
    paymentMethodId: json["payment_method_id"],
    orderMethodId: json["order_method_id"],
    couponId: json["coupon_id"],
    cityId: json["city_id"],
    zoneId: json["zone_id"],
    subZoneId: json["sub_zone_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    addressId: json["address_id"],
    driverId: json["driver_id"],
    orderStatus: OrderStatus.fromJson(json["order_status"]),
    address: OrderDetailsModelAddress.fromJson(json["address"]),
    branch: Branch.fromJson(json["branch"]),
    paymentMethod: Method.fromJson(json["payment_method"]),
    details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    orderMethod: Method.fromJson(json["order_method"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_no": orderNo,
    "link_code": linkCode,
    "subtotal": subtotal,
    "discount": discount,
    "discount_type": discountType,
    "tax": tax,
    "delivery_fee": deliveryFee,
    "total": total,
    "quantity": quantity,
    "delivery_date": "${deliveryDate.year.toString().padLeft(4, '0')}-${deliveryDate.month.toString().padLeft(2, '0')}-${deliveryDate.day.toString().padLeft(2, '0')}",
    "notes": notes,
    "client_id": clientId,
    "order_status_id": orderStatusId,
    "branch_id": branchId,
    "payment_method_id": paymentMethodId,
    "order_method_id": orderMethodId,
    "coupon_id": couponId,
    "city_id": cityId,
    "zone_id": zoneId,
    "sub_zone_id": subZoneId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "address_id": addressId,
    "driver_id": driverId,
    "order_status": orderStatus.toJson(),
    "address": address.toJson(),
    "branch": branch.toJson(),
    "payment_method": paymentMethod.toJson(),
    "details": List<dynamic>.from(details.map((x) => x.toJson())),
    "order_method": orderMethod.toJson(),
  };
}

class OrderDetailsModelAddress {
  int id;
  int clientId;
  String title;
  int cityId;
  int zoneId;
  int subZoneId;
  String? block;
  String? street;
  String? houseNumber;
  String? notes;
  int addressDefault;
  String? lat;
  String? lng;
  City ?city;
  Zone ?zone;
  Zone ?subZone;

  OrderDetailsModelAddress({
    required this.id,
    required this.clientId,
    required this.title,
    required this.cityId,
    required this.zoneId,
    required this.subZoneId,
     this.block,
    required this.street,
    required this.houseNumber,
     this.notes,
    required this.addressDefault,
     this.lat,
     this.lng,
     this.city,
     this.zone,
     this.subZone,
  });

  factory OrderDetailsModelAddress.fromJson(Map<String, dynamic> json) => OrderDetailsModelAddress(
    id: json["id"],
    clientId: json["client_id"],
    title: json["title"],
    cityId: json["city_id"],
    zoneId: json["zone_id"],
    subZoneId: json["sub_zone_id"],
    block: json["block"],
    street: json["street"],
    houseNumber: json["house_number"],
    notes: json["notes"],
    addressDefault: json["default"],
    lat: json["lat"],
    lng: json["lng"],
    city: json["city"] == null ?null:City.fromJson(json["city"]),
    zone: json["zone"] == null ?null:Zone.fromJson(json["zone"]),
    subZone:json["sub_zone"] == null ?null: Zone.fromJson(json["sub_zone"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "client_id": clientId,
    "title": title,
    "city_id": cityId,
    "zone_id": zoneId,
    "sub_zone_id": subZoneId,
    "block": block,
    "street": street,
    "house_number": houseNumber,
    "notes": notes,
    "default": addressDefault,
    "lat": lat,
    "lng": lng,
    "city": city!.toJson(),
    "zone": zone!.toJson(),
    "sub_zone": subZone!.toJson(),
  };
}

class City {
  int id;
  TitleClass title;
  int isActive;
  int countryId;
  String createdAt;
  String updatedAt;

  City({
    required this.id,
    required this.title,
    required this.isActive,
    required this.countryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    isActive: json["is_active"],
    countryId: json["country_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "is_active": isActive,
    "country_id": countryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}



class Zone {
  int id;
  TitleClass title;
  int isActive;
  String deliveryFee;
  int? zoneId;
  String createdAt;
  String updatedAt;
  int? cityId;

  Zone({
    required this.id,
    required this.title,
    required this.isActive,
    required this.deliveryFee,
    this.zoneId,
    required this.createdAt,
    required this.updatedAt,
    this.cityId,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    isActive: json["is_active"],
    deliveryFee: json["delivery_fee"],
    zoneId: json["zone_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "is_active": isActive,
    "delivery_fee": deliveryFee,
    "zone_id": zoneId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "city_id": cityId,
  };
}

class Branch {
  int id;
  TitleClass title;
  String phone;
  int isActive;
  dynamic image;
  TitleClass address;
  String taxNumber;
  String doctorPhone;
  String createdAt;
  String updatedAt;
  int companyId;
  int cityId;
  int zoneId;
  int subZoneId;
  double rate;
  City city;
  Zone zone;
  Zone subZone;
  Company company;
  String? lat;
  String? lng;


  Branch({
    required this.id,
    required this.title,
    required this.phone,
    required this.isActive,
    required this.image,
    required this.address,
    required this.taxNumber,
    required this.doctorPhone,
    required this.createdAt,
    required this.updatedAt,
    required this.companyId,
    required this.cityId,
    required this.zoneId,
    required this.subZoneId,
    required this.rate,
    required this.city,
    required this.zone,
    required this.subZone,
    required this.company,
    this.lat,
    this.lng,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    phone: json["phone"],
    isActive: json["is_active"],
    image: json["image"],
    address: TitleClass.fromJson(json["address"]),
    taxNumber: json["tax_number"],
    doctorPhone: json["doctor_phone"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    companyId: json["company_id"],
    cityId: json["city_id"],
    zoneId: json["zone_id"],
    subZoneId: json["sub_zone_id"],
    rate: json["rate"]?.toDouble(),
    city: City.fromJson(json["city"]),
    zone: Zone.fromJson(json["zone"]),
    subZone: Zone.fromJson(json["sub_zone"]),
    company: Company.fromJson(json["company"]),
    lat: json["lat"],
    lng: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "phone": phone,
    "is_active": isActive,
    "image": image,
    "address": address.toJson(),
    "tax_number": taxNumber,
    "doctor_phone": doctorPhone,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "company_id": companyId,
    "city_id": cityId,
    "zone_id": zoneId,
    "sub_zone_id": subZoneId,
    "rate": rate,
    "city": city.toJson(),
    "zone": zone.toJson(),
    "sub_zone": subZone.toJson(),
    "company": company.toJson(),
    "lat": lat,
    "lng": lng,
  };
}

class Company {
  int id;
  TitleClass title;
  TitleClass serviceAgreement;
  String phone;
  String email;
  String taxNumber;
  int isActive;
  String? image;
  String createdAt;
  String updatedAt;

  Company({
    required this.id,
    required this.title,
    required this.serviceAgreement,
    required this.phone,
    required this.email,
    required this.taxNumber,
    required this.isActive,
     this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    serviceAgreement: TitleClass.fromJson(json["service_agreement"]),
    phone: json["phone"],
    email: json["email"],
    taxNumber: json["tax_number"],
    isActive: json["is_active"],
    image: json["image"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "service_agreement": serviceAgreement.toJson(),
    "phone": phone,
    "email": email,
    "tax_number": taxNumber,
    "is_active": isActive,
    "image": image,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class Detail {
  int id;
  double total; // تغيير من int إلى double
  double price; // تغيير من int إلى double
  int quantity;
  dynamic note;
  int orderId;
  int productId;
  String createdAt;
  String updatedAt;
  Product product;

  Detail({
    required this.id,
    required this.total,
    required this.price,
    required this.quantity,
    required this.note,
    required this.orderId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: _parseInt(json["id"]), // تحويل إلى int
    total: _parseDouble(json["total"]), // تحويل إلى double
    price: _parseDouble(json["price"]), // تحويل إلى double
    quantity: _parseInt(json["quantity"]), // تحويل إلى int
    note: json["note"],
    orderId: _parseInt(json["order_id"]), // تحويل إلى int
    productId: _parseInt(json["product_id"]), // تحويل إلى int
    createdAt: json["created_at"] as String,
    updatedAt: json["updated_at"] as String,
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "price": price,
    "quantity": quantity,
    "note": note,
    "order_id": orderId,
    "product_id": productId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product": product.toJson(),
  };

  // دالة مساعدة لتحويل القيمة إلى int بشكل آمن
  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? 0; // إذا فشل التحويل، يتم إرجاع 0 كقيمة افتراضية
    } else {
      throw FormatException("Invalid type for int: $value");
    }
  }

  // دالة مساعدة لتحويل القيمة إلى double بشكل آمن
  static double _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0; // إذا فشل التحويل، يتم إرجاع 0.0 كقيمة افتراضية
    } else {
      throw FormatException("Invalid type for double: $value");
    }
  }
}
class Product {
  int id;
  TitleClass title;
  TitleClass description;
  TitleClass howToUse;
  TitleClass usedFor;
  TitleClass precautions;
  TitleClass sideEffect;
  TitleClass howToStore;
  TitleClass furtherInformation;
  String? comment;
  String? upc;
  int size;
  int commissionType;
  double price; // تغيير من int إلى double
  double newPrice; // تغيير من int إلى double
  int isActive;
  int isSlider;
  int categoryId;
  String createdAt;
  String updatedAt;
  int unitId;
  int brandId;
  int formId;
  int typeId;
  String? bannerImage;
  int inFavourite;
  List<ImageModel> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.howToUse,
    required this.usedFor,
    required this.precautions,
    required this.sideEffect,
    required this.howToStore,
    required this.furtherInformation,
    this.comment,
    this.upc,
    required this.size,
    required this.commissionType,
    required this.price,
    required this.newPrice,
    required this.isActive,
    required this.isSlider,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.unitId,
    required this.brandId,
    required this.formId,
    required this.typeId,
    this.bannerImage,
    required this.inFavourite,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: _parseInt(json["id"]), // تحويل إلى int
    title: TitleClass.fromJson(json["title"]),
    description: TitleClass.fromJson(json["description"]),
    howToUse: TitleClass.fromJson(json["how_to_use"]),
    usedFor: TitleClass.fromJson(json["used_for"]),
    precautions: TitleClass.fromJson(json["precautions"]),
    sideEffect: TitleClass.fromJson(json["side_effect"]),
    howToStore: TitleClass.fromJson(json["how_to_store"]),
    furtherInformation: TitleClass.fromJson(json["further_information"]),
    comment: json["comment"],
    upc: json["upc"],
    size: _parseInt(json["size"]), // تحويل إلى int
    commissionType: _parseInt(json["commission_type"]), // تحويل إلى int
    price: _parseDouble(json["price"]), // تحويل إلى double
    newPrice: _parseDouble(json["new_price"]), // تحويل إلى double
    isActive: _parseInt(json["is_active"]), // تحويل إلى int
    isSlider: _parseInt(json["is_slider"]), // تحويل إلى int
    categoryId: _parseInt(json["category_id"]), // تحويل إلى int
    createdAt: json["created_at"] as String,
    updatedAt: json["updated_at"] as String,
    unitId: _parseInt(json["unit_id"]), // تحويل إلى int
    brandId: _parseInt(json["brand_id"]), // تحويل إلى int
    formId: _parseInt(json["form_id"]), // تحويل إلى int
    typeId: _parseInt(json["type_id"]), // تحويل إلى int
    bannerImage: json["banner_image"],
    inFavourite: _parseInt(json["in_favourite"]), // تحويل إلى int
    images: List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "description": description.toJson(),
    "how_to_use": howToUse.toJson(),
    "used_for": usedFor.toJson(),
    "precautions": precautions.toJson(),
    "side_effect": sideEffect.toJson(),
    "how_to_store": howToStore.toJson(),
    "further_information": furtherInformation.toJson(),
    "comment": comment,
    "upc": upc,
    "size": size,
    "commission_type": commissionType,
    "price": price,
    "new_price": newPrice,
    "is_active": isActive,
    "is_slider": isSlider,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "unit_id": unitId,
    "brand_id": brandId,
    "form_id": formId,
    "type_id": typeId,
    "banner_image": bannerImage,
    "in_favourite": inFavourite,
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
  };

  static int _parseInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    } else {
      throw FormatException("Invalid type for int: $value");
    }
  }

  static double _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    } else {
      throw FormatException("Invalid type for double: $value");
    }
  }
}

class ImageModel {
  int id;
  String image;
  int isActive;

  ImageModel({
    required this.id,
    required this.image,
    required this.isActive,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    id: json["id"],
    image: json["image"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "is_active": isActive,
  };
}

class Method {
  int id;
  TitleClass title;
  int isActive;
  String? image;
  String createdAt;

  Method({
    required this.id,
    required this.title,
    required this.isActive,
    required this.image,
    required this.createdAt,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    isActive: json["is_active"],
    image: json["image"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "is_active": isActive,
    "image": image,
    "created_at": createdAt,
  };
}

class OrderStatus {
  int id;
  TitleClass title;
  String createdAt;

  OrderStatus({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "created_at": createdAt,
  };
}
