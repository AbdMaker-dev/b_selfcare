import 'package:b_selfcare/src/data/models/group/group_model.dart';

class EmployeeModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? position;
  String? status;
  GroupModel? group;
  int? fleetNumbersCount;
  String? createdAt;
  String? updatedAt;

  EmployeeModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.position,
      this.status,
      this.group,
      this.fleetNumbersCount,
      this.createdAt,
      this.updatedAt
      });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    position = json['position'];
    status = json['status'];
    group = json['group'] != null ? GroupModel.fromJson(json['group']) : null;
    fleetNumbersCount = json['fleet_numbers_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['position'] = this.position;
    data['status'] = this.status;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    data['fleet_numbers_count'] = this.fleetNumbersCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
