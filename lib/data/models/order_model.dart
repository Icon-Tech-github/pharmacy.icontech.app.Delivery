// To parse this JSON data, do
//
//     final orderData = orderDataFromJson(jsonString);

import 'dart:convert';

import '../../local_storage.dart';
import 'order_details_model.dart';

OrderData orderDataFromJson(String str) => OrderData.fromJson(json.decode(str));

String orderDataToJson(OrderData data) => json.encode(data.toJson());

class OrderData {
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
  PaymentMethod paymentMethod;
  Client client;
  OrderDetailsModelAddress address;
  OrderMethod orderMethod;
  Branch branch;

  OrderData({
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
    required this.paymentMethod,
    required this.client,
    required this.address,
    required this.orderMethod,
    required this.branch,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    orderNo: json["order_no"],
    linkCode: json["link_code"],
    subtotal: double.parse(json["subtotal"].toString()),
    discount:  double.parse(json["discount"].toString()),
    discountType: json["discount_type"].toString(),
    tax: double.parse(json["tax"].toString()),
    deliveryFee:  double.parse(json["delivery_fee"].toString()),
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
    paymentMethod: PaymentMethod.fromJson(json["payment_method"]),
    client: Client.fromJson(json["client"]),
    address: OrderDetailsModelAddress.fromJson(json["address"]),
    orderMethod: OrderMethod.fromJson(json["order_method"]),
    branch: Branch.fromJson(json["branch"]),
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
    "payment_method": paymentMethod.toJson(),
    "client": client.toJson(),
    "address": address.toJson(),
    "order_method": orderMethod.toJson(),
    "branch": branch.toJson(),
  };
}

// class OrderDataAddress {
//   int id;
//   int clientId;
//   String title;
//   int cityId;
//   int zoneId;
//   int subZoneId;
//   String? block;
//   String street;
//   String houseNumber;
//   String? notes;
//   int addressDefault;
//   String? lat;
//   String? lng;
//
//   OrderDataAddress({
//     required this.id,
//     required this.clientId,
//     required this.title,
//     required this.cityId,
//     required this.zoneId,
//     required this.subZoneId,
//      this.block,
//     required this.street,
//     required this.houseNumber,
//      this.notes,
//     required this.addressDefault,
//      this.lat,
//      this.lng,
//   });
//
//   factory OrderDataAddress.fromJson(Map<String, dynamic> json) => OrderDataAddress(
//     id: json["id"],
//     clientId: json["client_id"],
//     title: json["title"],
//     cityId: json["city_id"],
//     zoneId: json["zone_id"],
//     subZoneId: json["sub_zone_id"],
//     block: json["block"],
//     street: json["street"],
//     houseNumber: json["house_number"],
//     notes: json["notes"],
//     addressDefault: json["default"],
//     lat: json["lat"],
//     lng: json["lng"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "client_id": clientId,
//     "title": title,
//     "city_id": cityId,
//     "zone_id": zoneId,
//     "sub_zone_id": subZoneId,
//     "block": block,
//     "street": street,
//     "house_number": houseNumber,
//     "notes": notes,
//     "default": addressDefault,
//     "lat": lat,
//     "lng": lng,
//   };
// }

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
  dynamic rate;

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
    rate: json["rate"],
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
  };
}

class TitleClass {
  String en;
  String ar;
  String ?lang;

  TitleClass({
    required this.en,
    required this.ar,
    this.lang

  });

  factory TitleClass.fromJson(Map<String, dynamic> json) => TitleClass(
    en: json["en"],
    ar: json["ar"],
    lang: LocalStorage.getData(key: "lang") == 'ar'?  json["ar"]: json["en"],

  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "ar": ar,
  };
}

class Client {
  int id;
  String name;
  String? phone;

  Client({
    required this.id,
    required this.name,
     this.phone,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
  };
}

class OrderMethod {
  int id;
  TitleClass title;
  int isActive;
  dynamic image;
  String createdAt;

  OrderMethod({
    required this.id,
    required this.title,
    required this.isActive,
    required this.image,
    required this.createdAt,
  });

  factory OrderMethod.fromJson(Map<String, dynamic> json) => OrderMethod(
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

class PaymentMethod {
  int id;
  TitleClass title;

  PaymentMethod({
    required this.id,
    required this.title,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
    id: json["id"],
    title: TitleClass.fromJson(json["title"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
  };
}
