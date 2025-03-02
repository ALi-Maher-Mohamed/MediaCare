class DepartmentResponse {
  final bool success;
  final String message;
  final PaginationData data;

  DepartmentResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) {
    return DepartmentResponse(
      success: json['success'],
      message: json['message'],
      data: PaginationData.fromJson(json['data']),
    );
  }
}

class PaginationData {
  final int currentPage;
  final List<Department> departments;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<PaginationLink> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  PaginationData({
    required this.currentPage,
    required this.departments,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      currentPage: json['current_page'],
      departments: (json['data'] as List)
          .map((department) => Department.fromJson(department))
          .toList(),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: (json['links'] as List)
          .map((link) => PaginationLink.fromJson(link))
          .toList(),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Department {
  final String id;
  final String title;
  final String description;
  final String icon;

  Department({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      icon: json['icon'],
    );
  }
}

class PaginationLink {
  final String? url;
  final String label;
  final bool active;

  PaginationLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory PaginationLink.fromJson(Map<String, dynamic> json) {
    return PaginationLink(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}