class LabAnalysisModel {
  final String? name;
  final String? value;
  final String? unit;
  final String? status;
  final String? notes;

  LabAnalysisModel({
    this.name,
    this.value,
    this.unit,
    this.status,
    this.notes,
  });

  factory LabAnalysisModel.fromJson(Map<dynamic, dynamic> json) {
    return LabAnalysisModel(
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

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString();
    return value.toString();
  }
}

class LabAnalysisData {
  final List<LabAnalysisModel> testResults;
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

  static List<LabAnalysisModel> _parseTestResults(dynamic value) {
    if (value is List) {
      return value
          .map((test) => test is Map<String, dynamic>
              ? LabAnalysisModel.fromJson(test)
              : LabAnalysisModel())
          .toList();
    }
    return [];
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

  static String? _convertToString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value.trim();
    if (value is num) return value.toString();
    return value.toString();
  }
}
