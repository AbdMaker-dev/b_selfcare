class EmployeeModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? position;
  String? status;
  int? groupId;
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
      this.groupId,
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
    groupId = json['group_id'];
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
    data['group_id'] = this.groupId;
    data['fleet_numbers_count'] = this.fleetNumbersCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
