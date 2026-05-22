import 'package:b_selfcare/src/data/models/group/data_employe_import_model.dart';

class DataImportResponseModel {
  bool? success;
  String? message;
  DataEmployeImportModel? dataImport;

  DataImportResponseModel({this.success, this.message,this.dataImport});

  DataImportResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    dataImport = json['data'] != null ? DataEmployeImportModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (dataImport != null) {
      data['meta'] = dataImport!.toJson();
    }
    return data;
  }
}

