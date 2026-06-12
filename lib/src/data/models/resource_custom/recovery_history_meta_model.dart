import 'package:b_selfcare/src/data/models/resource_custom/recovery_status_model.dart';

class RecoveryHistoryMetaModel {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  int? from;
  int? to;
  List<RecoveryStatusModel>? availableStatuses;

  RecoveryHistoryMetaModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.from,
    this.to,
    this.availableStatuses,
  });

  RecoveryHistoryMetaModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
    from = json['from'];
    to = json['to'];
    if (json['available_statuses'] != null) {
      availableStatuses = <RecoveryStatusModel>[];
      json['available_statuses'].forEach((v) {
        availableStatuses!.add(RecoveryStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['total'] = total;
    map['from'] = from;
    map['to'] = to;
    if (availableStatuses != null) {
      map['available_statuses'] = availableStatuses!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
