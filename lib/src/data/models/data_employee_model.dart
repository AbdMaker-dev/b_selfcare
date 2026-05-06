import 'package:b_selfcare/src/data/models/meta_model.dart';
import 'employee_model.dart';

class DataEmployeeModel {
  List<EmployeeModel>? employees;
  MetaModel? meta;

  DataEmployeeModel({this.employees, this.meta});

  DataEmployeeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      employees = <EmployeeModel>[];
      json['data'].forEach((v) {
        employees!.add(EmployeeModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (employees != null) {
      data['data'] = employees!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
