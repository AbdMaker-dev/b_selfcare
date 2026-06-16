import 'package:b_selfcare/src/data/models/meta_model.dart';

class ProvisioningLogsResponseModel {
  bool? success;
  String? message;
  ProvisioningLogsDataModel? data;

  ProvisioningLogsResponseModel({this.success, this.message, this.data});

  ProvisioningLogsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProvisioningLogsDataModel.fromJson(json['data']) : null;
  }
}

class ProvisioningLogsDataModel {
  List<ProvisioningLogModel>? items;
  ProvisioningLogsSummaryModel? summary;
  ProvisioningLogsPaginationModel? pagination;

  ProvisioningLogsDataModel({this.items, this.summary, this.pagination});

  ProvisioningLogsDataModel.fromJson(Map<String, dynamic> json) {
    items = (json['items'] as List<dynamic>?)
        ?.whereType<Map<String, dynamic>>()
        .map(ProvisioningLogModel.fromJson)
        .toList();
    summary = json['summary'] != null ? ProvisioningLogsSummaryModel.fromJson(json['summary']) : null;
    pagination = json['pagination'] != null ? ProvisioningLogsPaginationModel.fromJson(json['pagination']) : null;
  }
}

class ProvisioningLogModel {
  int? id;
  String? phoneNumber;
  String? productName;
  dynamic cbsOfferingId;
  dynamic cbsPurchaseSeq;
  String? status;
  int? attempts;
  String? executedAt;
  String? errorMessage;
  String? triggerType;
  String? amountDebited;

  ProvisioningLogModel({
    this.id,
    this.phoneNumber,
    this.productName,
    this.cbsOfferingId,
    this.cbsPurchaseSeq,
    this.status,
    this.attempts,
    this.executedAt,
    this.errorMessage,
    this.triggerType,
    this.amountDebited,
  });

  ProvisioningLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    productName = json['product_name'];
    cbsOfferingId = json['cbs_offering_id'];
    cbsPurchaseSeq = json['cbs_purchase_seq'];
    status = json['status'];
    attempts = json['attempts'];
    executedAt = json['executed_at'];
    errorMessage = json['error_message'];
    triggerType = json['trigger_type'];
    amountDebited = json['amount_debited'];
  }
}

class ProvisioningLogsSummaryModel {
  int? total;
  int? success;
  int? failed;
  int? pending;

  ProvisioningLogsSummaryModel({this.total, this.success, this.failed, this.pending});

  ProvisioningLogsSummaryModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    success = json['success'];
    failed = json['failed'];
    pending = json['pending'];
  }
}

class ProvisioningLogsPaginationModel {
  int? total;
  int? perPage;
  int? currentPage;
  int? lastPage;
  List<StatusOption>? availableStatuses;

  ProvisioningLogsPaginationModel({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.availableStatuses,
  });

  ProvisioningLogsPaginationModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    final raw = json['available_statuses'];
    if (raw is List) {
      availableStatuses = raw.whereType<Map<String, dynamic>>().map(StatusOption.fromJson).toList();
    }
  }
}
