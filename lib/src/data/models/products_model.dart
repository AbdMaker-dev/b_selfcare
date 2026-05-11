class ProductsModel {
  int? id;
  String? name;
  String? description;
  bool? isActive;
  List<Quotas>? quotas;

  ProductsModel(
      {this.id, this.name, this.description, this.isActive, this.quotas});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isActive = json['is_active'];
    if (json['quotas'] != null) {
      quotas = <Quotas>[];
      json['quotas'].forEach((v) {
        quotas!.add(new Quotas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['is_active'] = this.isActive;
    if (this.quotas != null) {
      data['quotas'] = this.quotas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quotas {
  int? walletId;
  String? name;
  String? code;
  String? category;
  String? unit;
  int? quota;
  int? price;

  Quotas({this.walletId, this.quota, this.price, this.category, this.unit, this.name, this.code});

  Quotas.fromJson(Map<String, dynamic> json) {
    walletId = json['wallet_id'];
    quota = json['quota'];
    price = json['price'];
    category = json['category']??json['wallet']?['category'];
    unit = json['unit']??json['wallet']?['unit'];
    name = json['name']??json['wallet']?['name'];
    code = json['code']??json['wallet']?['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_id'] = this.walletId;
    data['quota'] = this.quota;
    data['price'] = this.price;
    return data;
  }
}
