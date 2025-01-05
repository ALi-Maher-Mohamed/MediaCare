import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class FoundDiseaseApiModel {
  final String advice;
  final String speciality;

  FoundDiseaseApiModel({required this.advice, required this.speciality});

  factory FoundDiseaseApiModel.fromJson(Map<String, dynamic> json) {
    return FoundDiseaseApiModel(
      advice: json['advice'],
      speciality: json['speciality'],
    );
  }
}

class GeminiService {
  static const String apiKey =
      'AIzaSyCF_UzyUbnSwkNcEwyYSe_E-X3k1r8LQBE'; // Your API key
  final String modelName = 'gemini-1.5-flash';

  Future<FoundDiseaseApiModel> analyzeTextAndImage(
      String text, File? file) async {
    try {
      final parts = await _prepareParts(text, file);
      final response = await _generateContent(parts);

      // Remove bold markdown (if any)
      final cleanedResponse = response.replaceAll('**', '');

      // Split the response to extract speciality and advice
      final partsResponse = cleanedResponse.split("النصيحة:");
      final speciality = partsResponse[0].trim();
      final advice = partsResponse.length > 1 ? partsResponse[1].trim() : '';

      return FoundDiseaseApiModel(advice: advice, speciality: speciality);
    } catch (error) {
      throw Exception('Gemini API Error: $error');
    }
  }

  Future<String> _generateContent(List<Map<String, dynamic>> parts) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/$modelName:generateContent?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'role': 'user',
            'parts': parts,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Failed to generate content: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> _prepareParts(
      String text, File? file) async {
    final parts = <Map<String, dynamic>>[];

    if (file != null) {
      final base64Image = await _fileToBase64(file);
      parts.add({
        'inlineData': {
          'data': base64Image,
          'mimeType': 'image/jpeg',
        },
      });
      parts.add({
        'text':
            'الرد باللغة العربية والادويه باللغة الانجليزيه: لخص محتوى الروشتة حتى يفهمها المريض: $text',
      });
    } else {
      parts.add({
        'text':
            'حلل الأعراض التالية وقدم نصيحة حول تخصص الطبيب الذي ينبغي الذهاب إليه: $text',
      });
    }

    return parts;
  }

  Future<String> _fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
