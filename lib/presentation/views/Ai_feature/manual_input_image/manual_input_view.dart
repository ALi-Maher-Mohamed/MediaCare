import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_choice_chips.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_header.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_search_button.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_text_field.dart';

class ManualInputView extends StatefulWidget {
  @override
  _ManualInputViewState createState() => _ManualInputViewState();
}

class _ManualInputViewState extends State<ManualInputView> {
  final TextEditingController _controller = TextEditingController();
  bool _isSymptom = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primary),
        centerTitle: true,
        title: Text(
          'بحث يدوي',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ManualInputHeader(),
            SizedBox(height: 10.h),
            ManualInputTextField(controller: _controller),
            SizedBox(height: 20.h),
            ManualInputChoiceChips(
              isSymptom: _isSymptom,
              onSymptomSelected: (value) {
                setState(() {
                  _isSymptom = value;
                });
              },
            ),
            SizedBox(height: 20.h),
            Center(
              child: ManualInputSearchButton(
                controller: _controller,
                isSymptom: _isSymptom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
