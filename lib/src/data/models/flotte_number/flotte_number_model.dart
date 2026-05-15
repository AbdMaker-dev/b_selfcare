import 'package:b_selfcare/src/data/models/employee/employee_model.dart';

class FlotteNumberModel {
  int? id;
  String? msisdn;
  String? iccid;
  String? status;
  String? assignmentDate;
  String? createdAt;
  EmployeeModel? employee;

  FlotteNumberModel({this.id, this.msisdn,this.iccid,this.status,this.assignmentDate,this.createdAt, this.employee});

  FlotteNumberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msisdn = json['msisdn'];
    iccid = json['iccid'];
    status = json['status'];
    assignmentDate = json['assignment_date'];
    createdAt = json['created_at'];
    employee = json['employee'] != null ? EmployeeModel.fromJson(json['employee']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['msisdn'] = msisdn;
    map['iccid'] = iccid;
    map['status'] = status;
    map['assignment_date'] = assignmentDate;
    map['created_at'] = createdAt;
    if (employee != null) {
      map['employee'] = employee!.toJson();
    }
    return map;
  }
}

