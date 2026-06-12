class RecoveredBundleModel {
  int? cbsAmount;
  String? walletUnit;
  String? freeUnitType;

  RecoveredBundleModel({this.cbsAmount, this.walletUnit, this.freeUnitType});

  RecoveredBundleModel.fromJson(Map<String, dynamic> json) {
    cbsAmount = json['cbs_amount'];
    walletUnit = json['wallet_unit'];
    freeUnitType = json['free_unit_type'];
  }

  Map<String, dynamic> toJson() {
    return {
      'cbs_amount': cbsAmount,
      'wallet_unit': walletUnit,
      'free_unit_type': freeUnitType,
    };
  }
}
