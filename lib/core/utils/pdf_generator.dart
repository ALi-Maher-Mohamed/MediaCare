import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Ai_feature/medicine_details/models/medicine_detail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class PdfGenerator {
  static Future<String> generatePdf(
    BuildContext context,
    MedicineDetail medicine,
  ) async {
    final pdf = pw.Document();

    // تحميل الخط العربي
    final font = pw.Font.ttf(
      await DefaultAssetBundle.of(context)
          .load('assets/fonts/Amiri-Regular.ttf'),
    );

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        margin: pw.EdgeInsets.all(16),
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: <pw.Widget>[
              pw.Text(
                medicine.medicineName ?? 'غير محدد',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              if (medicine.medicineNameArabic != null)
                pw.Text(
                  medicine.medicineNameArabic!,
                  style: pw.TextStyle(fontSize: 20, font: font),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'الاستطبابات:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              if (medicine.indications == null || medicine.indications!.isEmpty)
                pw.Text(
                  'غير متوفر',
                  style: pw.TextStyle(fontSize: 16, font: font),
                )
              else
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: medicine.indications!
                      .map<pw.Widget>(
                        (indication) => pw.Padding(
                          padding: pw.EdgeInsets.only(right: 10, bottom: 4),
                          child: pw.Text(
                            '• $indication',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                        ),
                      )
                      .toList(),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'تعليمات الجرعة:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              pw.Text(
                medicine.dosageInstructions ?? 'غير متوفر',
                style: pw.TextStyle(fontSize: 16, font: font),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'الآثار الجانبية:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              if (medicine.sideEffects == null || medicine.sideEffects!.isEmpty)
                pw.Text(
                  'غير متوفر',
                  style: pw.TextStyle(fontSize: 16, font: font),
                )
              else
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: medicine.sideEffects!
                      .map<pw.Widget>(
                        (effect) => pw.Padding(
                          padding: pw.EdgeInsets.only(right: 10, bottom: 4),
                          child: pw.Text(
                            '• $effect',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                        ),
                      )
                      .toList(),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'الاحتياطات:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              if (medicine.precautions == null || medicine.precautions!.isEmpty)
                pw.Text(
                  'غير متوفر',
                  style: pw.TextStyle(fontSize: 16, font: font),
                )
              else
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: medicine.precautions!
                      .map<pw.Widget>(
                        (precaution) => pw.Padding(
                          padding: pw.EdgeInsets.only(right: 10, bottom: 4),
                          child: pw.Text(
                            '• $precaution',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                        ),
                      )
                      .toList(),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'معلومات إضافية:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              if (medicine.additionalInformation == null ||
                  medicine.additionalInformation!.isEmpty)
                pw.Text(
                  'غير متوفر',
                  style: pw.TextStyle(fontSize: 16, font: font),
                )
              else
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: medicine.additionalInformation!
                      .map<pw.Widget>(
                        (info) => pw.Padding(
                          padding: pw.EdgeInsets.only(right: 10, bottom: 4),
                          child: pw.Text(
                            '• $info',
                            style: pw.TextStyle(fontSize: 16, font: font),
                          ),
                        ),
                      )
                      .toList(),
                ),
              pw.SizedBox(height: 20),
              pw.Text(
                'إخلاء المسؤولية:',
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              pw.Text(
                medicine.disclaimer ?? 'غير متوفر',
                style: pw.TextStyle(fontSize: 16, font: font),
              ),
            ],
          ),
        ],
      ),
    );

    // حفظ الملف في مجلد التنزيلات
    String filePath;
    if (Platform.isAndroid) {
      // طلب إذن التخزين على Android
      var status = await Permission.storage.request();
      if (status.isGranted) {
        final dir = await getExternalStorageDirectory();
        filePath =
            '${dir!.path}/تفاصيل_الدواء_${medicine.medicineName ?? "دواء"}.pdf';
      } else {
        // إذا تم رفض الإذن، استخدم المجلد المؤقت
        final dir = await getTemporaryDirectory();
        filePath =
            '${dir.path}/تفاصيل_الدواء_${medicine.medicineName ?? "دواء"}.pdf';
      }
    } else {
      // على iOS، استخدم مجلد المستندات
      final dir = await getApplicationDocumentsDirectory();
      filePath =
          '${dir.path}/تفاصيل_الدواء_${medicine.medicineName ?? "دواء"}.pdf';
    }

    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    return filePath;
  }
}
