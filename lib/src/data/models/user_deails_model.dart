class UserDetailsModel {
  bool? error;
  String? message;
  String? messageCode;
  String? accessToken;
  String? tokenType;
  int? expiresIn;

  UserDetailsModel(
      {this.error,
      this.message,
      this.messageCode,
      this.accessToken,
      this.tokenType,});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    messageCode = json['message_code'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    data['message_code'] = this.messageCode;
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    data['expires_in'] = this.expiresIn;
    return data;
  }
}
