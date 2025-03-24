class prescriptionModel {
  final String? name;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final String? purpose;
  final String? warnings;

  prescriptionModel({
    this.name,
    this.dosage,
    this.frequency,
    this.duration,
    this.purpose,
    this.warnings,
  });

  factory prescriptionModel.fromJson(Map<dynamic, dynamic> json) {
    return prescriptionModel(
      name: json['name'] as String? ?? 'غير واضح',
      dosage: json['dosage'] as String? ?? 'غير واضحة',
      frequency: json['frequency'] as String? ?? 'غير واضح',
      duration: json['duration'] as String? ?? 'غير واضح',
      purpose: json['purpose'] as String? ?? 'غير واضح',
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
      doctorName: json?['doctorName'] as String? ?? 'غير واضح',
      patientName: json?['patientName'] as String? ?? 'غير واضح',
      patientAge: json?['patientAge'] as String? ?? 'غير واضح',
      prescriptionDate: json?['prescriptionDate'] as String? ?? 'غير واضح',
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

class PrescriptionData {
  final List<prescriptionModel> medications;
  final PrescriptionDetails prescriptionDetails;
  final Map<String, String?> generalAdvice;
  final String? message;
  final String? warning;

  PrescriptionData({
    required this.medications,
    required this.prescriptionDetails,
    required this.generalAdvice,
    this.message,
    this.warning,
  });

  factory PrescriptionData.fromJson(Map<String, dynamic> json) {
    return PrescriptionData(
      medications: (json['medications'] as List? ?? [])
          .map((med) => med is Map
              ? prescriptionModel.fromJson(med)
              : prescriptionModel())
          .toList(),
      prescriptionDetails: json['prescriptionDetails'] is Map
          ? PrescriptionDetails.fromJson(json['prescriptionDetails'])
          : PrescriptionDetails(),
      generalAdvice: json['generalAdvice'] is Map
          ? (json['generalAdvice'] as Map<String, dynamic>?)?.map(
                (key, value) => MapEntry(key, value as String? ?? 'غير واضح'),
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
