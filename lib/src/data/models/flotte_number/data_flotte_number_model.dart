import 'package:b_selfcare/src/data/models/flotte_number/flotte_number_model.dart';
import 'package:b_selfcare/src/data/models/meta_model.dart';

class DataFlotteNumberModel {
  List<FlotteNumberModel>? numbers;
  MetaModel? meta;

  DataFlotteNumberModel({this.numbers, this.meta});

  DataFlotteNumberModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      numbers = <FlotteNumberModel>[];
      json['data'].forEach((v) {
        numbers!.add(FlotteNumberModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (numbers != null) {
      data['data'] = numbers!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
