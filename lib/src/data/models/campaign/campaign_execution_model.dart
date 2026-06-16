import 'package:b_selfcare/src/data/models/meta_model.dart';

class CampaignExecutionsResponseModel {
  bool? success;
  String? message;
  CampaignExecutionsDataModel? data;

  CampaignExecutionsResponseModel({this.success, this.message, this.data});

  CampaignExecutionsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CampaignExecutionsDataModel.fromJson(json['data']) : null;
  }
}

class CampaignExecutionsDataModel {
  List<CampaignExecutionModel>? executions;
  MetaModel? meta;

  CampaignExecutionsDataModel({this.executions, this.meta});

  CampaignExecutionsDataModel.fromJson(Map<String, dynamic> json) {
    final raw = json['data'] ?? json['executions'];
    executions = (raw as List<dynamic>?)
        ?.whereType<Map<String, dynamic>>()
        .map(CampaignExecutionModel.fromJson)
        .toList();
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
  }
}

class CampaignExecutionModel {
  int? id;
  int? campaignId;
  String? campaignName;
  String? scheduledDate;
  String? actualDate;
  String? status;
  String? triggeredBy;
  int? nbSuccess;
  int? nbError;
  int? nbSkipped;
  int? totalNumbers;
  dynamic amountDebited;
  String? message;
  String? createdAt;

  CampaignExecutionModel({
    this.id,
    this.campaignId,
    this.campaignName,
    this.scheduledDate,
    this.actualDate,
    this.status,
    this.triggeredBy,
    this.nbSuccess,
    this.nbError,
    this.nbSkipped,
    this.totalNumbers,
    this.amountDebited,
    this.message,
    this.createdAt,
  });

  CampaignExecutionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    campaignId = json['campaign_id'];
    campaignName = json['campaign_name'];
    scheduledDate = json['scheduled_date'];
    actualDate = json['actual_date'];
    status = json['status'];
    triggeredBy = json['triggered_by'];
    nbSuccess = json['nb_success'];
    nbError = json['nb_error'];
    nbSkipped = json['nb_skipped'];
    totalNumbers = json['total_numbers'];
    amountDebited = json['amount_debited'];
    message = json['message'];
    createdAt = json['created_at'];
  }
}
