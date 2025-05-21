class PaginatedMainCategories {
  final int currentPage;
  final List<MainCategory> data;
  final int lastPage;
  final String? nextPageUrl;

  PaginatedMainCategories({
    required this.currentPage,
    required this.data,
    required this.lastPage,
    this.nextPageUrl,
  });

  factory PaginatedMainCategories.fromJson(Map<String, dynamic> json) {
    return PaginatedMainCategories(
      currentPage: json['current_page'] as int,
      data: (json['data'] as List)
          .map((item) => MainCategory.fromJson(item))
          .toList(),
      lastPage: json['last_page'] as int,
      nextPageUrl: json['next_page_url'] as String?,
    );
  }
}


class MainCategory {
  final int? id;
  final String? name;
  final String? slug;
  final String? icon;
  final int? parentId;
  final int? position;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? homeStatus;
  final int? priority;
  final List<dynamic>? translations;

  MainCategory({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.parentId,
    this.position,
    this.createdAt,
    this.updatedAt,
    this.homeStatus,
    this.priority,
    this.translations,
  });

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      icon: json['icon'] as String?,
      parentId: json['parent_id'] as int?,
      position: json['position'] as int?,
      createdAt: json['created_at'] != null 
          ? DateTime.tryParse(json['created_at'] as String) 
          : null,
      updatedAt: json['updated_at'] != null 
          ? DateTime.tryParse(json['updated_at'] as String) 
          : null,
      homeStatus: json['home_status'] as int?,
      priority: json['priority'] as int?,
      translations: json['translations'] as List<dynamic>?,
    );
  }
}