import 'package:b_selfcare/src/data/models/employee/fleet_number_model.dart';
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
  List<FleetNumberModel>? fleetNumbers;
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
        this.fleetNumbers,
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
    if (json['fleet_numbers'] != null) {
      fleetNumbers = <FleetNumberModel>[];
      json['fleet_numbers'].forEach((v) {
        fleetNumbers!.add(FleetNumberModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['position'] = position;
    data['status'] = status;
    if (group != null) {
      data['group'] = group!.toJson();
    }
    data['fleet_numbers_count'] = fleetNumbersCount;
    if (fleetNumbers != null) {
      data['fleet_numbers'] = fleetNumbers!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
