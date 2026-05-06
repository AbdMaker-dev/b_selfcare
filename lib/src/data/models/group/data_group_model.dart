import 'package:b_selfcare/src/data/models/meta_model.dart';

import 'group_model.dart';

class DataGroupModel {
  List<GroupModel>? groups;
  MetaModel? meta;

  DataGroupModel({this.groups, this.meta});

  DataGroupModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      groups = <GroupModel>[];
      json['data'].forEach((v) {
        groups!.add(GroupModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? MetaModel.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (groups != null) {
      data['data'] = groups!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
