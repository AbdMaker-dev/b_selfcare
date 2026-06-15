class AggregatedModel {
  final String? measureUnit;
  final String? label;
  final int? totalAmount;
  final String? formattedTotalAmount;

  AggregatedModel({
     this.label,
     this.totalAmount,
     this.measureUnit,
     this.formattedTotalAmount,
  });

  factory AggregatedModel.fromJson(Map<String, dynamic> json) {
    return AggregatedModel(
      label: json['label'],
      totalAmount: json['total_amount'],
      measureUnit: json['measure_unit'],
      formattedTotalAmount: json['formatted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_amount': totalAmount,
      'measure_unit': measureUnit,
      'label': label,
      'formatted': formattedTotalAmount,
    };
  }
}