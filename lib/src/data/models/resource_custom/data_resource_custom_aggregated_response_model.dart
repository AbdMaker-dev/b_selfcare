import 'package:b_selfcare/src/data/models/resource_custom/resource_custom_aggregated_model.dart';

class DataResourceCustomAggregatedResponseModel {
  bool? success;
  String? message;
  ResourceCustomAggregatedModel? data;

  DataResourceCustomAggregatedResponseModel({this.success, this.message, this.data});

  DataResourceCustomAggregatedResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ResourceCustomAggregatedModel.fromJson(json['data']) : null;
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

