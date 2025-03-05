import 'data.dart';

class LaboratoryPagination {
  final int currentPage;
  final List<LaboratoryModel> laboratories;
  final String? nextPageUrl;

  LaboratoryPagination({
    required this.currentPage,
    required this.laboratories,
    this.nextPageUrl,
  });

  factory LaboratoryPagination.fromJson(Map<String, dynamic> json) {
    return LaboratoryPagination(
      currentPage: json['current_page'],
      laboratories: (json['data'] as List)
          .map((lab) => LaboratoryModel.fromJson(lab))
          .toList(),
      nextPageUrl: json['next_page_url'],
    );
  }
}
