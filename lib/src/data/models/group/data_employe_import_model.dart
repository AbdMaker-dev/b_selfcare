class DataEmployeImportModel {
  int? totalCount;
  String? importId;
  String? status;

  DataEmployeImportModel({
    this.totalCount,
    this.importId,
    this.status,
  });

  DataEmployeImportModel.fromJson(Map<String, dynamic> json) {
    totalCount = json['total_count'];
    importId = json['import_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_count'] = totalCount;
    data['import_id'] = importId;
    data['status'] = status;
    return data;
  }
}
