import 'package:b_selfcare/src/data/models/campaign/campaign_model.dart';
import 'package:b_selfcare/src/data/models/meta_model.dart';

class DataCampaignResponseModel {
  bool? success;
  String? message;
  MetaModel? meta;
  List<CampaignModel>? campaigns;

  DataCampaignResponseModel({this.success, this.message,this.meta,this.campaigns});

  DataCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      campaigns = <CampaignModel>[];
      json['data'].forEach((v) {
        campaigns!.add(CampaignModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (meta != null) {
      map['meta'] = meta!.toJson();
    }
    if (campaigns != null) {
      map['data'] = campaigns!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

