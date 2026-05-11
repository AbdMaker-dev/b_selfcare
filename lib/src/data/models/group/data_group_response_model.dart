import 'data_group_model.dart';

class DataGroupResponseModel {
  bool? success;
  String? message;
  DataGroupModel? data;

  DataGroupResponseModel({this.success, this.message, this.data});

  DataGroupResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataGroupModel.fromJson(json['data']) : null;
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

