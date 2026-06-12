import 'package:b_selfcare/src/data/models/resource_custom/recovered_bundle_model.dart';

class RecoveredResourcesModel {
  List<RecoveredBundleModel>? bundles;
  int? mainCreditFcfa;

  RecoveredResourcesModel({this.bundles, this.mainCreditFcfa});

  RecoveredResourcesModel.fromJson(Map<String, dynamic> json) {
    if (json['bundles'] != null) {
      bundles = <RecoveredBundleModel>[];
      json['bundles'].forEach((v) {
        bundles!.add(RecoveredBundleModel.fromJson(v));
      });
    }
    mainCreditFcfa = json['main_credit_fcfa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (bundles != null) {
      map['bundles'] = bundles!.map((v) => v.toJson()).toList();
    }
    map['main_credit_fcfa'] = mainCreditFcfa;
    return map;
  }
}
