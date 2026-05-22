import 'package:b_selfcare/src/data/models/group/group_schedule_model.dart';
import 'package:b_selfcare/src/data/models/products_model.dart';

class GroupModel {
  int? id;
  String? name;
  String? description;
  int? productId;
  ProductsModel? product;
  GroupScheduleModel? campaign;
  int? employeesCount;
  String? frequency;
  int? dayOfWeek;
  int? dayOfMonth;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;

  GroupModel({
    this.id,
    this.name,
    this.description,
    this.productId,
    this.product,
    this.campaign,
    this.employeesCount,
    this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    productId = json['product_id'];
    employeesCount = json['employees_count'];
    product = json['product'] != null ? ProductsModel.fromJson(json['product']) : null;
    campaign = json['campaign'] != null ? GroupScheduleModel.fromJson(json['campaign']) : null;
    frequency = json['frequency'];
    dayOfWeek = json['day_of_week'];
    dayOfMonth = json['day_of_month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['product_id'] = productId;
    data['employees_count'] = employeesCount;
    data['frequency'] = frequency;
    data['day_of_week'] = dayOfWeek;
    data['day_of_month'] = dayOfMonth;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (campaign != null) {
      data['campaign'] = campaign!.toJson();
    }
    return data;
  }
}
