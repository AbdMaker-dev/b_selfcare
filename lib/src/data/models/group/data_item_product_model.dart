import 'package:b_selfcare/src/data/models/group/item_product.dart';


class DataItemProductModel {
  List<ItemProduct>? items;
  String? type;
  String? label;

  DataItemProductModel({this.items, this.type,this.label});

  DataItemProductModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    if (json['items'] != null) {
      items = <ItemProduct>[];
      json['items'].forEach((v) {
        items!.add(ItemProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['label'] = label;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
