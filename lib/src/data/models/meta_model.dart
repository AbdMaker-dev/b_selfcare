class MetaModel {
  int? currentPage;
  int? perPage;
  int? total;
  int? lastPage;

  MetaModel(
      {this.currentPage,
        this.perPage,
        this.total,
        this.lastPage
      });

  MetaModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    perPage = json['per_page'];
    total = json['total'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    data['last_page'] = this.lastPage;
    return data;
  }
}
