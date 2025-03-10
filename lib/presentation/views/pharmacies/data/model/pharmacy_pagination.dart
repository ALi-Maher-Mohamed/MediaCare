// import 'pharmacy_model.dart';

// class PaginationModel {
//   final int currentPage;
//   final int lastPage;
//   final String? nextPageUrl;
//   final List<PharmacyModel> pharmacies;

//   PaginationModel({
//     required this.currentPage,
//     required this.lastPage,
//     required this.nextPageUrl,
//     required this.pharmacies,
//   });

//   factory PaginationModel.fromJson(Map<String, dynamic> json) {
//     return PaginationModel(
//       currentPage: json['current_page'],
//       lastPage: json['last_page'],
//       nextPageUrl: json['next_page_url'],
//       pharmacies: (json['data'] as List)
//           .map((pharmacy) => PharmacyModel.fromJson(pharmacy))
//           .toList(),
//     );
//   }
// }
