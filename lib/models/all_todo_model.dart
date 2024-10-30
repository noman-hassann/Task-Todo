class AllTodoModel {
  int? code;
  bool? success;
  int? timestamp;
  String? message;
  List<Items>? items;
  Meta? meta;

  AllTodoModel(
      {this.code,
      this.success,
      this.timestamp,
      this.message,
      this.items,
      this.meta});

  AllTodoModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    timestamp = json['timestamp'];
    message = json['message'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['timestamp'] = timestamp;
    data['message'] = message;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? sId;
  String? title;
  String? description;
  bool? isCompleted;
  bool? isSynced;

  // Constructor with default value for isSynced
  Items({
    this.sId,
    this.title,
    this.description,
    this.isCompleted,
    this.isSynced = false, // Default value
  });

  // Create an Items instance from JSON
  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
    isSynced = json['is_synced'] ?? false; // Use default if null
  }

  // Create an Items instance from a database map
  factory Items.fromMap(Map<String, dynamic> map) {
    return Items(
      sId: map['id'], // Map to the corresponding database column name
      title: map['title'],
      description: map['description'],
      isCompleted: map['is_completed'] == 1, // Convert int to bool
      isSynced: map['is_synced'] == 1, // Convert int to bool
    );
  }

  // Convert an Items instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    data['is_synced'] = isSynced; // Include in toJson
    return data;
  }

  // CopyWith method
  Items copyWith({
    String? sId,
    String? title,
    String? description,
    bool? isCompleted,
    bool? isSynced,
  }) {
    return Items(
      sId: sId ?? this.sId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  // Add toMap method to convert an Items instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': sId,
      'title': title,
      'description': description,
      'is_completed': isCompleted == true ? 1 : 0, // Convert bool to int
      'is_synced': isSynced == true ? 1 : 0, // Convert bool to int
      // Removed created_at and updated_at as they are not needed
    };
  }
}

class Meta {
  int? totalItems;
  int? totalPages;
  int? perPageItem;
  int? currentPage;
  int? pageSize;
  bool? hasMorePage;

  Meta(
      {this.totalItems,
      this.totalPages,
      this.perPageItem,
      this.currentPage,
      this.pageSize,
      this.hasMorePage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalPages = json['total_pages'];
    perPageItem = json['per_page_item'];
    currentPage = json['current_page'];
    pageSize = json['page_size'];
    hasMorePage = json['has_more_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_items'] = totalItems;
    data['total_pages'] = totalPages;
    data['per_page_item'] = perPageItem;
    data['current_page'] = currentPage;
    data['page_size'] = pageSize;
    data['has_more_page'] = hasMorePage;
    return data;
  }
}
