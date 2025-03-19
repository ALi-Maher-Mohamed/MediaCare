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

  // ✅ تحويل أي قيمة إلى String بشكل آمن
  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString();
    return value.toString();
  }

  // ✅ تحويل الحقول التي يجب أن تكون `List<String>` إلى قائمة آمنة
  static List<String>? _convertToList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((item) => _convertToString(item) ?? '').toList();
    }
    if (value is String) {
      return [
        value.trim()
      ]; // إذا كان نصًا واحدًا، نحوله إلى قائمة تحتوي على عنصر واحد
    }
    return null;
  }
}
