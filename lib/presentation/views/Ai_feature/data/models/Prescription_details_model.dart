// Medication Model
class Medication {
  final String? name;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? purpose;
  final String? warnings;

  Medication({
    this.name,
    this.dosage,
    this.frequency,
    this.duration,
    this.purpose,
    this.warnings,
  });

  factory Medication.fromJson(Map<dynamic, dynamic> json) {
    return Medication(
      name: json['name'] as String? ?? 'غير محدد',
      dosage: json['dosage'] as String? ?? 'غير محدد',
      frequency: json['frequency'] as String? ?? 'غير محدد',
      duration: json['duration'] as String? ?? 'غير محدد',
      purpose: json['purpose'] as String? ?? 'غير محدد',
      warnings: json['warnings'] as String? ?? 'لا يوجد تحذيرات',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'duration': duration,
      'purpose': purpose,
      'warnings': warnings,
    };
  }
}

// Prescription Details Model
class PrescriptionDetails {
  final String? doctorName;
  final String? patientName;
  final String? patientAge;
  final String? prescriptionDate;

  PrescriptionDetails({
    this.doctorName,
    this.patientName,
    this.patientAge,
    this.prescriptionDate,
  });

  factory PrescriptionDetails.fromJson(Map<String, dynamic>? json) {
    return PrescriptionDetails(
      doctorName: json?['doctorName'] as String? ?? 'غير محدد',
      patientName: json?['patientName'] as String? ?? 'غير محدد',
      patientAge: json?['patientAge'] as String? ?? 'غير محدد',
      prescriptionDate: json?['prescriptionDate'] as String? ?? 'غير محدد',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'patientName': patientName,
      'patientAge': patientAge,
      'prescriptionDate': prescriptionDate,
    };
  }
}

// Main Analysis Data Model
class AnalysisData {
  final List<Medication> medications;
  final PrescriptionDetails prescriptionDetails;
  final Map<String, String?> generalAdvice;
  final String? message;
  final String? warning;

  AnalysisData({
    required this.medications,
    required this.prescriptionDetails,
    required this.generalAdvice,
    this.message,
    this.warning,
  });

  factory AnalysisData.fromJson(Map<String, dynamic> json) {
    return AnalysisData(
      medications: (json['medications'] as List? ?? [])
          .map((med) => med is Map ? Medication.fromJson(med) : Medication())
          .toList(),
      prescriptionDetails: json['prescriptionDetails'] is Map
          ? PrescriptionDetails.fromJson(json['prescriptionDetails'])
          : PrescriptionDetails(),
      generalAdvice: json['generalAdvice'] is Map
          ? (json['generalAdvice'] as Map<String, dynamic>?)?.map(
                (key, value) => MapEntry(key, value as String? ?? 'غير محدد'),
              ) ??
              {}
          : {},
      message: json['message'] as String? ?? 'لا توجد رسالة',
      warning: json['warning'] as String? ?? 'لا يوجد تحذير',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medications': medications.map((med) => med.toJson()).toList(),
      'prescriptionDetails': prescriptionDetails.toJson(),
      'generalAdvice': generalAdvice,
      'message': message,
      'warning': warning,
    };
  }
}
