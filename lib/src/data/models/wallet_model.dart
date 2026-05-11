class WalletModel {
  int? id;
  String? code;
  String? name;
  String? description;
  String? category;
  String? unit;
  bool? isActive;
  String? createdBy;

  WalletModel({
    this.id,
    this.code,
    this.name,
    this.description,
    this.category,
    this.unit,
    this.isActive,
    this.createdBy,
  });

  WalletModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    unit = json['unit'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'category': category,
      'unit': unit,
      'is_active': isActive,
      'created_by': createdBy,
    };
  }
}
