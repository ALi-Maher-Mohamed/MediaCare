import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';

import '../../../core/network/found_disease_serv.dart';
import '../../../core/utils/app_color.dart';

class FindYourDisease extends StatefulWidget {
  const FindYourDisease({super.key});

  @override
  FindYourDiseaseState createState() => FindYourDiseaseState();
}

class FindYourDiseaseState extends State<FindYourDisease> {
  File? _imageFile;
  String _symptomsText = '';
  FoundDiseaseApiModel? _apiResponse;
  bool _loading = false;
  String? _errorMessage;

  final _formKey = GlobalKey<FormState>();

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _analyzeContent() async {
    if (_formKey.currentState!.validate() || _imageFile != null) {
      setState(() {
        _loading = true;
        _errorMessage = null;
      });
      final geminiService = GeminiService();
      try {
        final response =
            await geminiService.analyzeTextAndImage(_symptomsText, _imageFile);
        setState(() {
          _apiResponse = response;
          _loading = false;
        });
      } catch (e) {
        setState(() {
          _errorMessage = "فشل في تحليل الصورة والنص. يرجى المحاولة مرة أخرى.";
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: const Text(' أعرف مشكلتك !',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: AppColors.primary)),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: AppColors.lightGrey,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextButton.icon(
                          onPressed: _pickImage,
                          icon: const Icon(
                            Icons.image,
                            color: AppColors.primary,
                          ),
                          label: const Text('اختر ملف (اختياري)',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                          ),
                        ),
                        if (_imageFile != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(
                                _imageFile!,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.primary)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            labelText: 'اوصف الأعراض',
                            labelStyle: TextStyle(color: AppColors.primary),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.primary),
                            ),
                          ),
                          maxLines: 4,
                          onChanged: (value) {
                            setState(() {
                              _symptomsText = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "يرجى إدخال النص أو الصورة.";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _loading ? null : _analyzeContent,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: const Size(200, 50),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CustomProgressIndicator(),
                                )
                              : const Text("تحليل الصورة والنص",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_apiResponse != null)
                  Card(
                    color: AppColors.lightGrey,
                    // elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'التخصص المقترح: ${_apiResponse?.speciality}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary),
                          ),
                          if (_apiResponse?.advice != null)
                            Text(
                              'النصيحة لحين الذهاب للطبيب: ${_apiResponse?.advice}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                        ],
                      ),
                    ),
                  ),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
