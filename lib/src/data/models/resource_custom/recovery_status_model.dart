class RecoveryStatusModel {
  String? value;
  String? label;
  String? color;

  RecoveryStatusModel({this.value, this.label, this.color});

  RecoveryStatusModel.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'label': label,
      'color': color,
    };
  }
}
