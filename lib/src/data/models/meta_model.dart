class MetaModel {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;
  int? from;
  int? to;
  List<StatusOption>? availableStatuses;
  List<StatusOption>? availableStatusesOptions;

  MetaModel(
      {this.currentPage,
        this.perPage,
        this.total,
        this.lastPage,
        this.from,
        this.to,
        this.availableStatuses,
        this.availableStatusesOptions,
      });

  MetaModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
    from = json['from'];
    to = json['to'];
    final rawStatuses = json['available_statuses'];
    if (rawStatuses is List && rawStatuses.isNotEmpty && rawStatuses.first is Map) {
      availableStatuses = rawStatuses.whereType<Map<String, dynamic>>().map(StatusOption.fromJson).toList();
    }
    availableStatusesOptions = json['available_statuses_options'] != null? (json['available_statuses_options'] as List).map((e) => StatusOption.fromJson(e)).toList(): null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['last_page'] = this.lastPage;
    data['to'] = this.to;
    data['from'] = this.from;
    if (availableStatuses != null) {
      data['available_statuses'] =
          this.availableStatuses!.map((e) => e.toJson()).toList();
    }
    if (availableStatusesOptions != null) {
      data['available_statuses_options'] =
          this.availableStatusesOptions!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class StatusOption {
  String? value;
  String? label;

  StatusOption({this.value, this.label});

  StatusOption.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    return {
      'value': this.value,
      'label': this.label,
    };
  }
}
