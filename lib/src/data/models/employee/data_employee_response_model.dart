import 'data_employee_model.dart';

class DataEmployeeResponseModel {
  bool? success;
  String? message;
  DataEmployeeModel? data;

  DataEmployeeResponseModel({this.success, this.message, this.data});

  DataEmployeeResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataEmployeeModel.fromJson(json['data']) : null;
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

