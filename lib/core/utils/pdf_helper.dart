import 'package:flutter/services.dart' show rootBundle;
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/data/model/Labs_analytics_model.dart';
import 'package:media_care/presentation/views/AI_Feature/medicine_details/models/medicine_detail_model.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/data/models/Prescription_details_model.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/data/models/symptoms_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfHelper {
  static Future<pw.Font> loadAmiriFont() async {
    final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
    return pw.Font.ttf(fontData);
  }

  static Future<pw.Document> createPdf(dynamic data) async {
    final pdf = pw.Document();

    final amiriFont = await loadAmiriFont();
    print('Type of data passed: ${data.runtimeType}');
    pw.Widget arabicText(String text, {pw.TextStyle? style}) {
      return pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Text(
          text,
          style: style?.copyWith(font: amiriFont) ??
              pw.TextStyle(font: amiriFont, fontSize: 14),
        ),
      );
    }

    pw.Widget arabicBullet(String text) {
      return pw.Directionality(
        textDirection: pw.TextDirection.rtl,
        child: pw.Bullet(
          text: text,
          style: pw.TextStyle(font: amiriFont),
        ),
      );
    }

    if (data is SymptomAnalysisData) {
      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(
              level: 0,
              child: arabicText('نتيجة تحليل الأعراض',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            arabicText('التشخيص: ${data.diagnosis ?? "غير محدد"}'),
            arabicText(
                'التخصص الموصى به: ${data.recommendedSpecialization ?? "غير محدد"}'),
            arabicText('النصيحة: ${data.advice ?? "لا توجد نصائح"}'),
            arabicText(
                'درجة الثقة: ${(data.confidenceScore ?? 0).toStringAsFixed(1)}%'),
            arabicText('الرسالة: ${data.message ?? "لا توجد رسالة"}'),
            pw.SizedBox(height: 10),
            arabicText('الأدوية المقترحة:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            if (data.suggestedMedications.isNotEmpty)
              ...data.suggestedMedications.asMap().entries.map(
                    (entry) => arabicBullet(
                      'دواء ${entry.key + 1}: ${entry.value.name ?? "غير معروف"}, الجرعة: ${entry.value.dosage ?? "غير محددة"}, ملاحظات: ${entry.value.notes ?? "لا توجد ملاحظات"}',
                    ),
                  )
            else
              arabicText('لا توجد أدوية مقترحة'),
            pw.SizedBox(height: 10),
            arabicText('تحذير: ${data.medicationWarning ?? "لا يوجد تحذير"}',
                style: pw.TextStyle(color: PdfColors.red)),
          ],
        ),
      );
    } else if (data is PrescriptionData) {
      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(
              level: 0,
              child: arabicText('الوصفة الطبية',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            arabicText(
                'اسم الطبيب: ${data.prescriptionDetails.doctorName ?? "غير واضح"}'),
            arabicText(
                'اسم المريض: ${data.prescriptionDetails.patientName ?? "غير واضح"}'),
            arabicText(
                'عمر المريض: ${data.prescriptionDetails.patientAge ?? "غير واضح"}'),
            arabicText(
                'تاريخ الوصفة: ${data.prescriptionDetails.prescriptionDate ?? "غير واضح"}'),
            pw.SizedBox(height: 10),
            arabicText('الأدوية:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            if (data.medications.isNotEmpty)
              ...data.medications.asMap().entries.map(
                    (entry) => arabicBullet(
                      'دواء ${entry.key + 1}: ${entry.value.name ?? "غير معروف"}, الجرعة: ${entry.value.dosage ?? "غير محددة"}, التكرار: ${entry.value.frequency ?? "غير محدد"}, المدة: ${entry.value.duration ?? "غير محددة"}, الغرض: ${entry.value.purpose ?? "غير واضح"}, التحذيرات: ${entry.value.warnings ?? "لا توجد"}',
                    ),
                  )
            else
              arabicText('لا توجد أدوية'),
            pw.SizedBox(height: 10),
            arabicText('نصائح عامة:',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ...data.generalAdvice.entries.map(
              (e) => arabicText('${e.key}: ${e.value ?? "غير واضح"}'),
            ),
            pw.SizedBox(height: 10),
            arabicText('رسالة: ${data.message ?? "لا توجد رسالة"}'),
            arabicText('تحذير: ${data.warning ?? "لا يوجد تحذير"}',
                style: pw.TextStyle(color: PdfColors.red)),
          ],
        ),
      );
    } else if (data is MedicineDetail) {
      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(
              level: 0,
              child: arabicText('تفاصيل الدواء',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            arabicText('اسم الدواء: ${data.medicineName ?? "غير معروف"}'),
            arabicText(
                'الاسم بالعربية: ${data.medicineNameArabic ?? "غير معروف"}'),
            pw.SizedBox(height: 10),
            if (data.indications != null && data.indications!.isNotEmpty)
              pw.Column(
                children: [
                  arabicText('الاستطبابات:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...data.indications!.map((e) => arabicBullet(e)),
                ],
              ),
            if (data.dosageInstructions != null)
              arabicText('تعليمات الجرعة: ${data.dosageInstructions}'),
            if (data.sideEffects != null && data.sideEffects!.isNotEmpty)
              pw.Column(
                children: [
                  arabicText('الأعراض الجانبية:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...data.sideEffects!.map((e) => arabicBullet(e)),
                ],
              ),
            if (data.precautions != null && data.precautions!.isNotEmpty)
              pw.Column(
                children: [
                  arabicText('الاحتياطات:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...data.precautions!.map((e) => arabicBullet(e)),
                ],
              ),
            if (data.additionalInformation != null &&
                data.additionalInformation!.isNotEmpty)
              pw.Column(
                children: [
                  arabicText('معلومات إضافية:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...data.additionalInformation!.map((e) => arabicBullet(e)),
                ],
              ),
            if (data.disclaimer != null)
              arabicText('إخلاء مسؤولية: ${data.disclaimer}',
                  style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
          ],
        ),
      );
    } else if (data is LabAnalysisData) {
      pdf.addPage(
        pw.MultiPage(
          build: (context) => [
            pw.Header(
              level: 0,
              child: arabicText('نتائج التحاليل المخبرية',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
            ),
            if (data.testResults.isNotEmpty)
              pw.Table.fromTextArray(
                headers: ['الاسم', 'القيمة', 'الوحدة', 'الحالة', 'ملاحظات']
                    .map((h) => pw.Text(h,
                        style: pw.TextStyle(
                            font: amiriFont, fontWeight: pw.FontWeight.bold)))
                    .toList(),
                data: data.testResults
                    .map((e) => [
                          e.name ?? '',
                          e.value ?? '',
                          e.unit ?? '',
                          e.status ?? '',
                          e.notes ?? '',
                        ])
                    .toList(),
                cellStyle: pw.TextStyle(font: amiriFont),
                headerStyle: pw.TextStyle(
                    font: amiriFont, fontWeight: pw.FontWeight.bold),
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                cellAlignment: pw.Alignment.centerRight,
                headerAlignment: pw.Alignment.centerRight,
              )
            else
              arabicText('لا توجد نتائج تحاليل'),
            pw.SizedBox(height: 10),
            arabicText('التفسير: ${data.interpretation ?? "لا توجد تفسير"}'),
            if (data.recommendations != null &&
                data.recommendations!.isNotEmpty)
              pw.Column(
                children: [
                  arabicText('التوصيات:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ...data.recommendations!.map((e) => arabicBullet(e)),
                ],
              ),
            pw.SizedBox(height: 10),
            arabicText('تحذير: ${data.warning ?? "لا يوجد تحذير"}',
                style: pw.TextStyle(color: PdfColors.red)),
          ],
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          build: (context) => pw.Center(
            child: arabicText('نوع بيانات غير مدعوم لإنشاء PDF'),
          ),
        ),
      );
    }

    return pdf;
  }
}
