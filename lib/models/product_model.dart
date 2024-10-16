import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String productName;
  String productType;
  int price;
  String unit;

  ProductModel(
      {required this.id,
      required this.productName,
      required this.productType,
      required this.price,
      required this.unit});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json["_id"] ?? 'unknown_id', // ถ้าค่า id เป็น null จะใช้ค่าเริ่มต้น
      productName: json["product_name"] ??
          'Unnamed Product', // ถ้าค่า productName เป็น null จะใช้ค่าเริ่มต้น
      productType: json["product_type"] ??
          'Unknown Type', // ถ้าค่า productType เป็น null จะใช้ค่าเริ่มต้น
      price: json["price"] ?? 0, // ถ้าค่า price เป็น null จะให้ค่าเป็น 0
      unit: json["unit"] ??
          'Unknown Unit' // ถ้าค่า unit เป็น null จะใช้ค่าเริ่มต้น
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "product_name": productName,
        "product_type": productType,
        "price": price,
        "unit": unit
      };
}
