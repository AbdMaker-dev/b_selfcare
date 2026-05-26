class RoleModel {
  final int id;
  final int? companyId;
  final String? name;
  final String? displayName;
  final String? description;
  final bool isSystem;

  RoleModel({
    required this.id,
    this.companyId,
    this.name,
    this.displayName,
    this.description,
    this.isSystem = false,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id:          json['id'] as int,
      companyId:   json['company_id'] as int?,
      name:        json['name'] as String?,
      displayName: json['display_name'] as String?,
      description: json['description'] as String?,
      isSystem:    json['is_system'] as bool? ?? false,
    );
  }
}
