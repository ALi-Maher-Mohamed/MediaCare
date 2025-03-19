// Medicine Detail Model
class MedicineDetail {
  final String? medicineName;
  final String? medicineNameArabic;
  final List<String>? indications;
  final String? dosageInstructions;
  final List<String>? sideEffects;
  final List<String>? precautions;
  final List<String>? additionalInformation;
  final String? disclaimer;
  final bool? success;

  MedicineDetail({
    this.medicineName,
    this.medicineNameArabic,
    this.indications,
    this.dosageInstructions,
    this.sideEffects,
    this.precautions,
    this.additionalInformation,
    this.disclaimer,
    this.success,
  });

  factory MedicineDetail.fromJson(Map<dynamic, dynamic> json) {
    return MedicineDetail(
      medicineName: _convertToString(json['medicineName']),
      medicineNameArabic: _convertToString(json['medicineNameArabic']),
      indications: _convertToList(json['indications']),
      dosageInstructions: _convertToString(json['dosageInstructions']),
      sideEffects: _convertToList(json['sideEffects']),
      precautions: _convertToList(json['precautions']),
      additionalInformation: _convertToList(json['additionalInformation']),
      disclaimer: _convertToString(json['disclaimer']),
      success: json['success'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicineName': medicineName,
      'medicineNameArabic': medicineNameArabic,
      'indications': indications,
      'dosageInstructions': dosageInstructions,
      'sideEffects': sideEffects,
      'precautions': precautions,
      'additionalInformation': additionalInformation,
      'disclaimer': disclaimer,
      'success': success,
    };
  }

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString();
    return value.toString();
  }

  static List<String>? _convertToList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((item) => _convertToString(item) ?? '').toList();
    }
    if (value is String) {
      return [value.trim()];
    }
    return null;
  }
}
