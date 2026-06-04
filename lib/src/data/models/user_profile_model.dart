class UserProfileModel {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? msisdn;
  final String? status;
  final String? language;
  final String? avatar;
  final bool? mfaEnabled;
  final String? emailVerifiedAt;
  final String? lastLoginAt;
  final String? invitedAt;
  final int? companyId;
  final UserCompanyModel? company;
  final List<UserRoleModel> roles;
  final String? createdAt;

  UserProfileModel({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.msisdn,
    this.status,
    this.language,
    this.avatar,
    this.mfaEnabled,
    this.emailVerifiedAt,
    this.lastLoginAt,
    this.invitedAt,
    this.companyId,
    this.company,
    this.roles = const [],
    this.createdAt,
  });

  String get fullName {
    if (firstName != null && lastName != null) return '$firstName $lastName';
    return name ?? '';
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      msisdn: json['msisdn'],
      status: json['status'],
      language: json['language'],
      avatar: json['avatar'],
      mfaEnabled: json['mfa_enabled'],
      emailVerifiedAt: json['email_verified_at'],
      lastLoginAt: json['last_login_at'],
      invitedAt: json['invited_at'],
      companyId: json['company_id'],
      company: json['company'] != null ? UserCompanyModel.fromJson(json['company']) : null,
      roles: (json['roles'] as List<dynamic>?)
              ?.whereType<Map<String, dynamic>>()
              .map(UserRoleModel.fromJson)
              .toList() ??
          [],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'msisdn': msisdn,
        'status': status,
        'language': language,
        'avatar': avatar,
        'mfa_enabled': mfaEnabled,
        'email_verified_at': emailVerifiedAt,
        'last_login_at': lastLoginAt,
        'invited_at': invitedAt,
        'company_id': companyId,
        'company': company?.toJson(),
        'roles': roles.map((r) => r.toJson()).toList(),
        'created_at': createdAt,
      };
}

class UserCompanyModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? logoUrl;
  final String? status;
  final String? currentBalance;
  final String? formattedBalance;
  final String? cbsAccountId;
  final String? cbsNbAccount;
  final String? email;
  final String? phone;
  final String? address;
  final PricePlanCategoryModel? pricePlanCategory;

  UserCompanyModel({
    this.id,
    this.name,
    this.slug,
    this.logoUrl,
    this.status,
    this.currentBalance,
    this.formattedBalance,
    this.cbsAccountId,
    this.cbsNbAccount,
    this.email,
    this.phone,
    this.address,
    this.pricePlanCategory,
  });

  factory UserCompanyModel.fromJson(Map<String, dynamic> json) {
    return UserCompanyModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      logoUrl: json['logo_url'],
      status: json['status'],
      currentBalance: json['current_balance']?.toString(),
      formattedBalance: json['formatted_balance'],
      cbsAccountId: json['cbs_account_id'],
      cbsNbAccount: json['cbs_nb_account'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      pricePlanCategory: json['pricePlanCategory'] != null
          ? PricePlanCategoryModel.fromJson(json['pricePlanCategory'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'logo_url': logoUrl,
        'status': status,
        'current_balance': currentBalance,
        'formatted_balance': formattedBalance,
        'cbs_account_id': cbsAccountId,
        'cbs_nb_account': cbsNbAccount,
        'email': email,
        'phone': phone,
        'address': address,
        'pricePlanCategory': pricePlanCategory?.toJson(),
      };
}

class PricePlanCategoryModel {
  final String? id;
  final String? name;
  final String? description;

  PricePlanCategoryModel({this.id, this.name, this.description});

  factory PricePlanCategoryModel.fromJson(Map<String, dynamic> json) {
    return PricePlanCategoryModel(
      id: json['id']?.toString(),
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };
}

class UserRoleModel {
  final int? id;
  final String? name;
  final String? displayName;

  UserRoleModel({this.id, this.name, this.displayName});

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      id: json['id'],
      name: json['name'],
      displayName: json['display_name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'display_name': displayName,
      };
}
