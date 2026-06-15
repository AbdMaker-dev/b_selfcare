class FreeUnitModel {
  final String? freeUnitType;
  final int? totalAmount;
  final String? measureUnit;
  final String? measureUnitLabel;
  final String? formattedTotalAmount;
  final String? walletDescription;
  final String? unit;

  FreeUnitModel({
     this.freeUnitType,
     this.totalAmount,
     this.measureUnit,
     this.measureUnitLabel,
     this.formattedTotalAmount,
     this.walletDescription,
     this.unit,
  });

  factory FreeUnitModel.fromJson(Map<String, dynamic> json) {
    return FreeUnitModel(
      freeUnitType: json['free_unit_type'],
      totalAmount: json['total_amount'],
      measureUnit: json['measure_unit'],
      measureUnitLabel: json['measure_unit_label'],
      formattedTotalAmount: json['formatted_total_amount'],
      walletDescription: json['wallet_description'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'free_unit_type': freeUnitType,
      'total_amount': totalAmount,
      'measure_unit': measureUnit,
      'measure_unit_label': measureUnitLabel,
      'formatted_total_amount': formattedTotalAmount,
      'wallet_description': walletDescription,
      'unit': unit,
    };
  }
}