// Symptom Medication Model
class SymptomMedication {
  final String? name;
  final String? dosage;
  final String? notes;

  SymptomMedication({
    this.name,
    this.dosage,
    this.notes,
  });

  factory SymptomMedication.fromJson(Map<dynamic, dynamic> json) {
    return SymptomMedication(
      name: _convertToString(json['name']) ?? 'غير محدد',
      dosage: _convertToString(json['dosage']) ?? 'غير محدد',
      notes: _convertToString(json['notes']) ?? 'لا توجد ملاحظات',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'notes': notes,
    };
  }

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }
}

// Main Symptom Analysis Data Model
class SymptomAnalysisData {
  final String? imageAnalysis;
  final String? diagnosis;
  final String? recommendedSpecialization;
  final String? advice;
  final int? confidenceScore;
  final String? message;
  final List<SymptomMedication> suggestedMedications;
  final String? medicationWarning;

  SymptomAnalysisData({
    this.imageAnalysis,
    this.diagnosis,
    this.recommendedSpecialization,
    this.advice,
    this.confidenceScore,
    this.message,
    this.suggestedMedications = const [],
    this.medicationWarning,
  });

  factory SymptomAnalysisData.fromJson(Map<String, dynamic> json) {
    return SymptomAnalysisData(
      imageAnalysis:
          _convertToString(json['imageAnalysis']) ?? 'لا توجد تحليل للصورة',
      diagnosis: _convertToString(json['diagnosis']) ?? 'غير محدد',
      recommendedSpecialization:
          _convertToString(json['recommendedSpecialization']) ?? 'غير محدد',
      advice: _convertToString(json['advice']) ?? 'لا توجد نصائح',
      confidenceScore: json['confidence_score'] as int? ?? 0,
      message: _convertToString(json['message']) ?? 'لا توجد رسالة',
      suggestedMedications: (json['suggested_medications'] as List? ?? [])
          .map((med) => med is Map
              ? SymptomMedication.fromJson(med)
              : SymptomMedication())
          .toList(),
      medicationWarning:
          _convertToString(json['medication_warning']) ?? 'لا يوجد تحذير',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageAnalysis': imageAnalysis,
      'diagnosis': diagnosis,
      'recommendedSpecialization': recommendedSpecialization,
      'advice': advice,
      'confidence_score': confidenceScore,
      'message': message,
      'suggested_medications':
          suggestedMedications.map((med) => med.toJson()).toList(),
      'medication_warning': medicationWarning,
    };
  }

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    if (value is num) return value.toString();
    return value.toString();
  }
}
