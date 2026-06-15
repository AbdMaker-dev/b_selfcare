import 'package:b_selfcare/src/data/models/resource_custom/recovery_history_meta_model.dart';
import 'package:b_selfcare/src/data/models/resource_custom/recovery_history_model.dart';

class DataRecoveryHistoryResponseModel {
  bool? success;
  String? message;
  List<RecoveryHistoryModel>? data;
  RecoveryHistoryMetaModel? meta;

  DataRecoveryHistoryResponseModel({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  DataRecoveryHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RecoveryHistoryModel>[];
      json['data'].forEach((v) {
        data!.add(RecoveryHistoryModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? RecoveryHistoryMetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta!.toJson();
    }
    return map;
  }
}
