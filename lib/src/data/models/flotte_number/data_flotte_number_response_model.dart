
import 'package:b_selfcare/src/data/models/flotte_number/data_flotte_number_model.dart';

class DataFlotteNumberResponseModel {
  bool? success;
  String? message;
  DataFlotteNumberModel? data;

  DataFlotteNumberResponseModel({this.success, this.message, this.data});

  DataFlotteNumberResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataFlotteNumberModel.fromJson(json['data']) : null;
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

