import 'package:b_selfcare/src/data/models/resource_custom/free_unit_model.dart';

class ResourceCustomModel {
  String? msisdn;
  int? mainCreditFcfa;
  List<FreeUnitModel>? freeUnits;

  ResourceCustomModel({this.freeUnits, this.msisdn,this.mainCreditFcfa});

  ResourceCustomModel.fromJson(Map<String, dynamic> json) {
    if (json['free_units'] != null) {
      freeUnits = <FreeUnitModel>[];
      json['free_units'].forEach((v) {
        freeUnits!.add(FreeUnitModel.fromJson(v));
      });
    }
    msisdn = json['msisdn'];
    mainCreditFcfa = json['main_credit_fcfa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (freeUnits != null) {
      data['free_units'] = freeUnits!.map((v) => v.toJson()).toList();
    }
    data['msisdn'] = msisdn;
    data['main_credit_fcfa'] = mainCreditFcfa;
    return data;
  }
}
