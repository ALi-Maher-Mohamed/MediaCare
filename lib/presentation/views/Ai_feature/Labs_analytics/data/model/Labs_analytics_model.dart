// Lab Test Result Model
class LabTestResult {
  final String? name;
  final String? value;
  final String? unit;
  final String? status;
  final String? notes;

  LabTestResult({
    this.name,
    this.value,
    this.unit,
    this.status,
    this.notes,
  });

  factory LabTestResult.fromJson(Map<dynamic, dynamic> json) {
    return LabTestResult(
      name: _convertToString(json['name']) ?? 'غير محدد',
      value: _convertToString(json['value']) ?? '',
      unit: _convertToString(json['unit']) ?? 'غير محدد',
      status: _convertToString(json['status']) ?? 'غير محدد',
      notes: _convertToString(json['notes']) ?? 'لا توجد ملاحظات',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'unit': unit,
      'status': status,
      'notes': notes,
    };
  }

  // دالة مساعدة لتحويل أي قيمة إلى String بأمان
  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString(); // تحويل int أو double إلى String
    return value.toString(); // كحل بديل لأنواع أخرى
  }
}

// Main Lab Analysis Data Model
class LabAnalysisData {
  final List<LabTestResult> testResults;
  final String? interpretation;
  final List<String>? recommendations;
  final String? warning;

  LabAnalysisData({
    required this.testResults,
    this.interpretation,
    this.recommendations,
    this.warning,
  });

  factory LabAnalysisData.fromJson(Map<String, dynamic> json) {
    return LabAnalysisData(
      testResults: _parseTestResults(json['testResults']),
      interpretation:
          _convertToString(json['interpretation']) ?? 'لا توجد تفسير',
      recommendations: _convertToList(json['recommendations']),
      warning: _convertToString(json['warning']) ?? 'لا يوجد تحذير',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'testResults': testResults.map((test) => test.toJson()).toList(),
      'interpretation': interpretation,
      'recommendations': recommendations,
      'warning': warning,
    };
  }

  // دالة لتحويل القيم إلى قائمة LabTestResult بأمان
  static List<LabTestResult> _parseTestResults(dynamic value) {
    if (value is List) {
      return value
          .map((test) => test is Map<String, dynamic>
              ? LabTestResult.fromJson(test)
              : LabTestResult())
          .toList();
    }
    return []; // إرجاع قائمة فارغة عند حدوث أي مشكلة
  }

  // دالة لتحويل القيم إلى قائمة نصوص
  static List<String>? _convertToList(dynamic value) {
    if (value == null) return null;
    if (value is List) {
      return value.map((item) => _convertToString(item) ?? '').toList();
    }
    if (value is String) {
      return [value.trim()]; // إذا كان نصاً واحداً، نضعه داخل List
    }
    return null;
  }

  // دالة مساعدة لتحويل القيمة إلى String بأمان
  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString();
    return value.toString();
  }
}
