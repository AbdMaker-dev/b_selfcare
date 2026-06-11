import 'package:b_selfcare/src/data/models/resource_custom/resource_custom_model.dart';

class DataResourceCustomResponseModel {
  bool? success;
  String? message;
  ResourceCustomModel? data;

  DataResourceCustomResponseModel({this.success, this.message, this.data});

  DataResourceCustomResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ResourceCustomModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}

