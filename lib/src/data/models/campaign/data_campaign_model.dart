import 'package:b_selfcare/src/data/models/meta_model.dart';
import 'campaign_model.dart';

class DataCampaignModel {
  List<CampaignModel>? campaigns;
  MetaModel? meta;

  DataCampaignModel({this.campaigns, this.meta});

  DataCampaignModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      campaigns = <CampaignModel>[];
      json['data'].forEach((v) {
        campaigns!.add(CampaignModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (campaigns != null) {
      data['data'] = campaigns!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
