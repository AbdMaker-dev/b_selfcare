class ErrorModel {
  String? message;
  int? code;

  ErrorModel({this.message, this.code});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'] !=null ? int.parse(json['code'].toString()) : json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}