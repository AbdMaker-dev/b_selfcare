import 'package:b_selfcare/src/data/models/products_model.dart';

class GroupModel {
  int? id;
  String? name;
  String? description;
  int? productId;
  ProductsModel? product;
  int? employeesCount;
  String? createdAt;
  String? updatedAt;

  GroupModel(
      {this.id,
      this.name,
      this.description,
      this.productId,
      this.product,
      this.employeesCount,
        this.createdAt,
        this.updatedAt
      });

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    productId = json['product_id'];
    employeesCount = json['employees_count'];
    product = json['product'] != null ? ProductsModel.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['product_id'] = this.productId;
    data['employees_count'] = this.employeesCount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
