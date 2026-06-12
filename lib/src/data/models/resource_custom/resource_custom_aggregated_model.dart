import 'package:b_selfcare/src/data/models/resource_custom/aggregated_model.dart';

class ResourceCustomAggregatedModel {
  String? msisdn;
  int? mainCreditFcfa;
  List<AggregatedModel>? aggregateds;

  ResourceCustomAggregatedModel({this.aggregateds, this.msisdn,this.mainCreditFcfa});

  ResourceCustomAggregatedModel.fromJson(Map<String, dynamic> json) {
    if (json['aggregated'] != null) {
      aggregateds = <AggregatedModel>[];
      json['aggregated'].forEach((v) {
        aggregateds!.add(AggregatedModel.fromJson(v));
      });
    }
    msisdn = json['msisdn'];
    mainCreditFcfa = json['main_credit_fcfa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (aggregateds != null) {
      data['aggregated'] = aggregateds!.map((v) => v.toJson()).toList();
    }
    data['free_units'] = msisdn;
    data['main_credit_fcfa'] = mainCreditFcfa;
    return data;
  }
}
