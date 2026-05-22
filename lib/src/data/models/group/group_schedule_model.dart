class GroupScheduleModel {
  int? id;
  String? frequency;
  int? dayOfWeek;
  int? dayOfMonth;
  String? startDate;
  String? endDate;
  String? status;
  String? nextExecution;

  GroupScheduleModel({
    this.id,
    this.frequency,
    this.dayOfWeek,
    this.dayOfMonth,
    this.startDate,
    this.endDate,
    this.status,
    this.nextExecution,
  });

  GroupScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    frequency = json['frequency'];
    dayOfWeek = json['day_of_week'];
    dayOfMonth = json['day_of_month'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    status = json['status'];
    nextExecution = json['next_execution'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'frequency': frequency,
      'day_of_week': dayOfWeek,
      'day_of_month': dayOfMonth,
      'start_date': startDate,
      'end_date': endDate,
      'status': status,
      'next_execution': nextExecution,
    };
  }
}
