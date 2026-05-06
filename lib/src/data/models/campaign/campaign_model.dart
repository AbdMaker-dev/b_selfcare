class CampaignModel {
  int? id;
  String? name;
  String? description;
  String? frequency;
  int? dayOfWeek;
  int? dayOfMonth;
  String? startDate;
  String? endDate;
  String? nextExecution;
  String? status;
  String? estimatedCost;
  int? productId;
  String? createdAt;

  CampaignModel(
      {this.id,
      this.name,
      this.description,
      this.frequency,
      this.dayOfWeek,
      this.dayOfMonth,
      this.startDate,
      this.endDate,
      this.nextExecution,
      this.status,
      this.estimatedCost,
      this.productId,
      this.createdAt
      });

  CampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    frequency = json['frequency'];
    dayOfWeek = json['day_of_week'];
    dayOfMonth = json['day_of_month'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    nextExecution = json['next_execution'];
    estimatedCost = json['estimated_cost'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['frequency'] = this.frequency;
    data['day_of_week'] = this.dayOfWeek;
    data['day_of_month'] = this.dayOfMonth;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_at'] = this.createdAt;
    data['next_execution'] = this.nextExecution;
    data['estimated_cost'] = this.estimatedCost;
    data['product_id'] = this.productId;
    return data;
  }
}
