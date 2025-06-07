import 'package:flutter/services.dart' show rootBundle;
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/data/models/Prescription_details_model.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHelper {
  static Future<pw.Font> loadArabicFont() async {
    final fontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  static Future<pw.Font> loadArabicBoldFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      // If bold font is not available, return regular font
      return loadArabicFont();
    }
  }

  // Helper method to check if string is not null and not empty
  static bool _isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  // Helper method to check if list is not null and not empty
  static bool _isListNotEmpty(List? list) {
    return list != null && list.isNotEmpty;
  }

  // Helper method to check if map is not null and not empty
  static bool _isMapNotEmpty(Map? map) {
    return map != null && map.isNotEmpty;
  }

  static Future<pw.Document> createPdf(dynamic data) async {
    final pdf = pw.Document();
    final arabicFont = await loadArabicFont();
    final arabicBoldFont = await loadArabicBoldFont();

    print('Type of data passed: ${data.runtimeType}');

    // Helper method for Arabic text with proper RTL support
    pw.Widget arabicText(
      String text, {
      double fontSize = 12,
      bool isBold = false,
      PdfColor? color,
      pw.TextAlign textAlign = pw.TextAlign.right,
    }) {
      return pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Text(
          text,
          style: pw.TextStyle(
            font: isBold ? arabicBoldFont : arabicFont,
            fontSize: fontSize,
            color: color ?? PdfColors.black,
          ),
          textAlign: textAlign,
        ),
      );
    }

    // Enhanced bullet point with better styling
    pw.Widget arabicBulletPoint(String text) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 4, right: 10),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.only(top: 6, left: 8),
              height: 4,
              width: 4,
              decoration: const pw.BoxDecoration(
                color: PdfColors.blue,
                shape: pw.BoxShape.circle,
              ),
            ),
            pw.Expanded(
              child: arabicText(text, fontSize: 11),
            ),
          ],
        ),
      );
    }

    // Section header with styling
    pw.Widget sectionHeader(String title) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(top: 15, bottom: 8),
        padding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: pw.BoxDecoration(
          color: PdfColors.blue50,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
          border: pw.Border.all(color: PdfColors.blue200, width: 1),
        ),
        child: arabicText(
          title,
          fontSize: 14,
          isBold: true,
          color: PdfColors.blue800,
        ),
      );
    }

    // Info card for key-value pairs - only shows if value is not empty
    pw.Widget? infoCard(String label, String? value, {PdfColor? valueColor}) {
      if (!_isNotEmpty(value)) return null;

      return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 6),
        padding: const pw.EdgeInsets.all(10),
        decoration: pw.BoxDecoration(
          color: PdfColors.grey50,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          border: pw.Border.all(color: PdfColors.grey200, width: 0.5),
        ),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 2,
              child: arabicText(label,
                  fontSize: 11, isBold: true, color: PdfColors.grey700),
            ),
            pw.Expanded(
              flex: 3,
              child: arabicText(value!,
                  fontSize: 11, color: valueColor ?? PdfColors.black),
            ),
          ],
        ),
      );
    }

    // Warning box - only shows if text is not empty
    pw.Widget? warningBox(String? text) {
      if (!_isNotEmpty(text)) return null;

      return pw.Container(
        margin: const pw.EdgeInsets.symmetric(vertical: 10),
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: PdfColors.red50,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
          border: pw.Border.all(color: PdfColors.red300, width: 1),
        ),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Container(
              margin: const pw.EdgeInsets.only(left: 8),
              child: pw.Icon(
                pw.IconData(0xe002), // Warning icon
                color: PdfColors.red,
                size: 16,
              ),
            ),
            pw.Expanded(
              child: arabicText(
                text!,
                fontSize: 11,
                color: PdfColors.red800,
                isBold: true,
              ),
            ),
          ],
        ),
      );
    }

    // Page header with logo area
    pw.Widget pageHeader(String title) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 20),
        padding: const pw.EdgeInsets.all(16),
        decoration: pw.BoxDecoration(
          gradient: const pw.LinearGradient(
            colors: [PdfColors.blue600, PdfColors.blue800],
          ),
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        ),
        child: pw.Center(
          child: arabicText(
            title,
            fontSize: 22,
            isBold: true,
            color: PdfColors.white,
          ),
        ),
      );
    }

    if (data is SymptomAnalysisData) {
      // Create list of widgets that are not null
      List<pw.Widget> pageWidgets = [
        pageHeader('نتائج تحليل الأعراض'),
      ];

      // Basic information section - only add if there's data
      List<pw.Widget> basicInfoWidgets = [];
      final diagnosisCard = infoCard('التشخيص', data.diagnosis);
      final specializationCard =
          infoCard('التخصص الموصى به', data.recommendedSpecialization);
      final confidenceCard = infoCard(
          'درجة الثقة',
          data.confidenceScore != null
              ? '${data.confidenceScore!.toStringAsFixed(1)}%'
              : null,
          valueColor: (data.confidenceScore ?? 0) > 80
              ? PdfColors.green
              : PdfColors.orange);

      if (diagnosisCard != null) basicInfoWidgets.add(diagnosisCard);
      if (specializationCard != null) basicInfoWidgets.add(specializationCard);
      if (confidenceCard != null) basicInfoWidgets.add(confidenceCard);

      if (basicInfoWidgets.isNotEmpty) {
        pageWidgets.add(sectionHeader('معلومات التشخيص'));
        pageWidgets.addAll(basicInfoWidgets);
      }

      // Medical advice section
      if (_isNotEmpty(data.advice)) {
        pageWidgets.add(sectionHeader('النصائح الطبية'));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: PdfColors.green200, width: 1),
          ),
          child: arabicText(data.advice!, fontSize: 11),
        ));
      }

      // Suggested medications section
      if (_isListNotEmpty(data.suggestedMedications)) {
        pageWidgets.add(sectionHeader('الأدوية المقترحة'));
        for (int i = 0; i < data.suggestedMedications.length; i++) {
          final med = data.suggestedMedications[i];
          List<pw.Widget> medWidgets = [
            arabicText('دواء ${i + 1}: ${med.name ?? "غير معروف"}',
                fontSize: 12, isBold: true, color: PdfColors.blue800),
          ];

          if (_isNotEmpty(med.dosage)) {
            medWidgets.add(arabicText('الجرعة: ${med.dosage}', fontSize: 10));
          }
          if (_isNotEmpty(med.notes)) {
            medWidgets.add(arabicText('ملاحظات: ${med.notes}', fontSize: 10));
          }

          pageWidgets.add(pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 8),
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
              border: pw.Border.all(color: PdfColors.blue200, width: 0.5),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: medWidgets,
            ),
          ));
        }
      }

      // Additional message section
      if (_isNotEmpty(data.message)) {
        pageWidgets.add(sectionHeader('رسالة إضافية'));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: PdfColors.grey300, width: 1),
          ),
          child: arabicText(data.message!, fontSize: 11),
        ));
      }

      // Warning section
      final warning = warningBox(_isNotEmpty(data.medicationWarning)
          ? 'تحذير مهم: ${data.medicationWarning}'
          : null);
      if (warning != null) {
        pageWidgets.add(warning);
      }

      pdf.addPage(
        pw.MultiPage(
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pageWidgets,
        ),
      );
    } else if (data is PrescriptionData) {
      List<pw.Widget> pageWidgets = [
        pageHeader('تفاصيل الوصفة الطبية'),
      ];

      // Basic information section
      List<pw.Widget> basicInfoWidgets = [];
      final doctorCard =
          infoCard('اسم الطبيب', data.prescriptionDetails.doctorName);
      final patientCard =
          infoCard('اسم المريض', data.prescriptionDetails.patientName);
      final ageCard =
          infoCard('عمر المريض', data.prescriptionDetails.patientAge);
      final dateCard =
          infoCard('تاريخ الوصفة', data.prescriptionDetails.prescriptionDate);

      if (doctorCard != null) basicInfoWidgets.add(doctorCard);
      if (patientCard != null) basicInfoWidgets.add(patientCard);
      if (ageCard != null) basicInfoWidgets.add(ageCard);
      if (dateCard != null) basicInfoWidgets.add(dateCard);

      if (basicInfoWidgets.isNotEmpty) {
        pageWidgets.add(sectionHeader('معلومات أساسية'));
        pageWidgets.addAll(basicInfoWidgets);
      }

      // Medications section
      if (_isListNotEmpty(data.medications)) {
        pageWidgets.add(sectionHeader('قائمة الأدوية'));
        for (int i = 0; i < data.medications.length; i++) {
          final med = data.medications[i];
          List<pw.Widget> medWidgets = [
            arabicText('${i + 1}. ${med.name ?? "غير معروف"}',
                fontSize: 13, isBold: true, color: PdfColors.blue800),
            pw.SizedBox(height: 4),
          ];

          if (_isNotEmpty(med.dosage)) {
            medWidgets.add(arabicText('• الجرعة: ${med.dosage}', fontSize: 10));
          }
          if (_isNotEmpty(med.frequency)) {
            medWidgets
                .add(arabicText('• التكرار: ${med.frequency}', fontSize: 10));
          }
          if (_isNotEmpty(med.duration)) {
            medWidgets
                .add(arabicText('• المدة: ${med.duration}', fontSize: 10));
          }
          if (_isNotEmpty(med.purpose)) {
            medWidgets.add(arabicText('• الغرض: ${med.purpose}', fontSize: 10));
          }
          if (_isNotEmpty(med.warnings)) {
            medWidgets.add(arabicText('• تحذيرات: ${med.warnings}',
                fontSize: 10, color: PdfColors.red700));
          }

          pageWidgets.add(pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 10),
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.blue50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              border: pw.Border.all(color: PdfColors.blue200, width: 1),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: medWidgets,
            ),
          ));
        }
      }

      // General advice section
      if (_isMapNotEmpty(data.generalAdvice)) {
        List<pw.Widget> adviceWidgets = [];
        for (var entry in data.generalAdvice.entries) {
          final adviceCard = infoCard(entry.key, entry.value);
          if (adviceCard != null) {
            adviceWidgets.add(adviceCard);
          }
        }
        if (adviceWidgets.isNotEmpty) {
          pageWidgets.add(sectionHeader('النصائح العامة'));
          pageWidgets.addAll(adviceWidgets);
        }
      }

      // Additional message section
      if (_isNotEmpty(data.message)) {
        pageWidgets.add(sectionHeader('رسالة إضافية'));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: PdfColors.grey300, width: 1),
          ),
          child: arabicText(data.message!, fontSize: 11),
        ));
      }

      // Warning section
      final warning = warningBox(
          _isNotEmpty(data.warning) ? 'تحذير: ${data.warning}' : null);
      if (warning != null) {
        pageWidgets.add(warning);
      }

      pdf.addPage(
        pw.MultiPage(
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pageWidgets,
        ),
      );
    } else if (data is MedicineDetail) {
      List<pw.Widget> pageWidgets = [
        pageHeader('دليل معلومات الدواء'),
      ];

      // Basic information section
      List<pw.Widget> basicInfoWidgets = [];
      final nameCard = infoCard('اسم الدواء', data.medicineName);
      final arabicNameCard =
          infoCard('الاسم بالعربية', data.medicineNameArabic);

      if (nameCard != null) basicInfoWidgets.add(nameCard);
      if (arabicNameCard != null) basicInfoWidgets.add(arabicNameCard);

      if (basicInfoWidgets.isNotEmpty) {
        pageWidgets.add(sectionHeader('معلومات أساسية'));
        pageWidgets.addAll(basicInfoWidgets);
      }

      // Dosage instructions section
      if (_isNotEmpty(data.dosageInstructions)) {
        pageWidgets.add(sectionHeader('تعليمات الجرعة'));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: PdfColors.green200, width: 1),
          ),
          child: arabicText(data.dosageInstructions!, fontSize: 11),
        ));
      }

      // Indications section
      if (_isListNotEmpty(data.indications)) {
        pageWidgets.add(sectionHeader('الاستطبابات (دواعي الاستعمال)'));
        for (String indication in data.indications!) {
          if (_isNotEmpty(indication)) {
            pageWidgets.add(arabicBulletPoint(indication));
          }
        }
      }

      // Side effects section
      if (_isListNotEmpty(data.sideEffects)) {
        List<pw.Widget> sideEffectWidgets = [];
        for (String effect in data.sideEffects!) {
          if (_isNotEmpty(effect)) {
            sideEffectWidgets.add(arabicBulletPoint(effect));
          }
        }
        if (sideEffectWidgets.isNotEmpty) {
          pageWidgets.add(sectionHeader('الأعراض الجانبية'));
          pageWidgets.add(pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: PdfColors.orange50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              border: pw.Border.all(color: PdfColors.orange200, width: 1),
            ),
            child: pw.Column(
              children: sideEffectWidgets,
            ),
          ));
        }
      }

      // Precautions section
      if (_isListNotEmpty(data.precautions)) {
        List<pw.Widget> precautionWidgets = [];
        for (String precaution in data.precautions!) {
          if (_isNotEmpty(precaution)) {
            precautionWidgets.add(arabicBulletPoint(precaution));
          }
        }
        if (precautionWidgets.isNotEmpty) {
          pageWidgets.add(sectionHeader('الاحتياطات والتحذيرات'));
          pageWidgets.add(pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: PdfColors.red50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              border: pw.Border.all(color: PdfColors.red200, width: 1),
            ),
            child: pw.Column(
              children: precautionWidgets,
            ),
          ));
        }
      }

      // Additional information section
      if (_isListNotEmpty(data.additionalInformation)) {
        List<pw.Widget> additionalInfoWidgets = [];
        for (String info in data.additionalInformation!) {
          if (_isNotEmpty(info)) {
            additionalInfoWidgets.add(arabicBulletPoint(info));
          }
        }
        if (additionalInfoWidgets.isNotEmpty) {
          pageWidgets.add(sectionHeader('معلومات إضافية'));
          pageWidgets.addAll(additionalInfoWidgets);
        }
      }

      // Disclaimer section
      if (_isNotEmpty(data.disclaimer)) {
        pageWidgets.add(pw.SizedBox(height: 20));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(10),
          decoration: pw.BoxDecoration(
            color: PdfColors.grey100,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(5)),
            border: pw.Border.all(color: PdfColors.grey400, width: 1),
          ),
          child: arabicText(
            'إخلاء مسؤولية: ${data.disclaimer}',
            fontSize: 9,
            color: PdfColors.grey700,
          ),
        ));
      }

      pdf.addPage(
        pw.MultiPage(
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pageWidgets,
        ),
      );
    } else if (data is LabAnalysisData) {
      List<pw.Widget> pageWidgets = [
        pageHeader('تقرير نتائج التحاليل المخبرية'),
      ];

      // Test results section
      if (_isListNotEmpty(data.testResults)) {
        // Filter out empty test results
        List<dynamic> validTests = data.testResults.where((test) {
          return _isNotEmpty(test.name) ||
              _isNotEmpty(test.value) ||
              _isNotEmpty(test.status);
        }).toList();

        if (validTests.isNotEmpty) {
          pageWidgets.add(sectionHeader('نتائج الفحوصات'));

          List<pw.TableRow> tableRows = [
            // Header row
            pw.TableRow(
              decoration: const pw.BoxDecoration(color: PdfColors.blue600),
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: arabicText('اسم الفحص',
                      fontSize: 11, isBold: true, color: PdfColors.white),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: arabicText('القيمة',
                      fontSize: 11, isBold: true, color: PdfColors.white),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: arabicText('الوحدة',
                      fontSize: 11, isBold: true, color: PdfColors.white),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: arabicText('الحالة',
                      fontSize: 11, isBold: true, color: PdfColors.white),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  child: arabicText('ملاحظات',
                      fontSize: 11, isBold: true, color: PdfColors.white),
                ),
              ],
            ),
          ];

          // Data rows
          for (int i = 0; i < validTests.length; i++) {
            final test = validTests[i];
            final isEven = i % 2 == 0;
            final bgColor = isEven ? PdfColors.grey50 : PdfColors.white;

            tableRows.add(pw.TableRow(
              decoration: pw.BoxDecoration(color: bgColor),
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: arabicText(test.name ?? '', fontSize: 10),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child:
                      arabicText(test.value ?? '', fontSize: 10, isBold: true),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: arabicText(test.unit ?? '', fontSize: 10),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: arabicText(
                    test.status ?? '',
                    fontSize: 10,
                    color: _getStatusColor(test.status),
                    isBold: true,
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.all(6),
                  child: arabicText(test.notes ?? '', fontSize: 9),
                ),
              ],
            ));
          }

          pageWidgets.add(pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400, width: 0.5),
            columnWidths: {
              0: const pw.FlexColumnWidth(2), // الاسم
              1: const pw.FlexColumnWidth(1.5), // القيمة
              2: const pw.FlexColumnWidth(1), // الوحدة
              3: const pw.FlexColumnWidth(1.5), // الحالة
              4: const pw.FlexColumnWidth(2), // ملاحظات
            },
            children: tableRows,
          ));
        }
      }

      // Interpretation section
      if (_isNotEmpty(data.interpretation)) {
        pageWidgets.add(sectionHeader('التفسير الطبي'));
        pageWidgets.add(pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColors.blue50,
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
            border: pw.Border.all(color: PdfColors.blue200, width: 1),
          ),
          child: arabicText(data.interpretation!, fontSize: 11),
        ));
      }

      // Recommendations section
      if (_isListNotEmpty(data.recommendations)) {
        List<pw.Widget> recommendationWidgets = [];
        for (String rec in data.recommendations!) {
          if (_isNotEmpty(rec)) {
            recommendationWidgets.add(arabicBulletPoint(rec));
          }
        }
        if (recommendationWidgets.isNotEmpty) {
          pageWidgets.add(sectionHeader('التوصيات الطبية'));
          pageWidgets.add(pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: PdfColors.green50,
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(6)),
              border: pw.Border.all(color: PdfColors.green200, width: 1),
            ),
            child: pw.Column(
              children: recommendationWidgets,
            ),
          ));
        }
      }

      // Warning section
      final warning = warningBox(
          _isNotEmpty(data.warning) ? 'تحذير مهم: ${data.warning}' : null);
      if (warning != null) {
        pageWidgets.add(warning);
      }

      pdf.addPage(
        pw.MultiPage(
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pageWidgets,
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          textDirection: pw.TextDirection.rtl,
          margin: const pw.EdgeInsets.all(20),
          build: (context) => pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.red50,
                borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
                border: pw.Border.all(color: PdfColors.red300, width: 2),
              ),
              child: arabicText(
                'نوع البيانات غير مدعوم لإنشاء ملف PDF',
                fontSize: 16,
                isBold: true,
                color: PdfColors.red800,
              ),
            ),
          ),
        ),
      );
    }

    return pdf;
  }

  // Helper method to get color based on test status
  static PdfColor _getStatusColor(String? status) {
    if (status == null) return PdfColors.black;

    final statusLower = status.toLowerCase();
    if (statusLower.contains('طبيعي') || statusLower.contains('normal')) {
      return PdfColors.green;
    } else if (statusLower.contains('مرتفع') ||
        statusLower.contains('high') ||
        statusLower.contains('عالي')) {
      return PdfColors.red;
    } else if (statusLower.contains('منخفض') || statusLower.contains('low')) {
      return PdfColors.orange;
    }
    return PdfColors.black;
  }
}
