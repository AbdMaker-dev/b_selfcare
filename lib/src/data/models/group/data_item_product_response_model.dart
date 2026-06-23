import 'package:b_selfcare/src/data/models/group/data_item_product_model.dart';

class DataItemProductResponseModel {
  bool? success;
  String? message;
  List<DataItemProductModel>? data;

  DataItemProductResponseModel({this.success, this.message, this.data});

  DataItemProductResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataItemProductModel>[];
      json['data'].forEach((v) {
        data!.add(DataItemProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
