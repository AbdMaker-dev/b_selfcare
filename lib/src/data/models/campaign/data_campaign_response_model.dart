import 'data_campaign_model.dart';

class DataCampaignResponseModel {
  bool? success;
  String? message;
  DataCampaignModel? data;

  DataCampaignResponseModel({this.success, this.message, this.data});

  DataCampaignResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DataCampaignModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}
