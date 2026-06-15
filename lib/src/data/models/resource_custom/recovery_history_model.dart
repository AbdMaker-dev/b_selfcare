import 'package:b_selfcare/src/data/models/resource_custom/recovered_resources_model.dart';

class RecoveryHistoryModel {
  int? id;
  int? fleetNumberId;
  int? employeeId;
  RecoveredResourcesModel? recoveredResources;
  String? amountCredited;
  String? cbsReference;
  String? status;
  String? errorMessage;
  int? performedBy;
  String? createdAt;

  RecoveryHistoryModel({
    this.id,
    this.fleetNumberId,
    this.employeeId,
    this.recoveredResources,
    this.amountCredited,
    this.cbsReference,
    this.status,
    this.errorMessage,
    this.performedBy,
    this.createdAt,
  });

  RecoveryHistoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fleetNumberId = json['fleet_number_id'];
    employeeId = json['employee_id'];
    recoveredResources = json['recovered_resources'] != null
        ? RecoveredResourcesModel.fromJson(json['recovered_resources'])
        : null;
    amountCredited = json['amount_credited'];
    cbsReference = json['cbs_reference'];
    status = json['status'];
    errorMessage = json['error_message'];
    performedBy = json['performed_by'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['id'] = id;
    map['fleet_number_id'] = fleetNumberId;
    map['employee_id'] = employeeId;
    if (recoveredResources != null) {
      map['recovered_resources'] = recoveredResources!.toJson();
    }
    map['amount_credited'] = amountCredited;
    map['cbs_reference'] = cbsReference;
    map['status'] = status;
    map['error_message'] = errorMessage;
    map['performed_by'] = performedBy;
    map['created_at'] = createdAt;
    return map;
  }
}
