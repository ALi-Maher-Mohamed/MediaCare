import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_choice_chips.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_header.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_search_button.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/widgets/manual_input_text_field.dart';

class ManualInputView extends StatefulWidget {
  const ManualInputView({super.key}); // تحويل إلى const لتحسين الأداء

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
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor, // توافق مع الثيم
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).appBarTheme.backgroundColor, // من الثيم
        elevation: Theme.of(context).appBarTheme.elevation,
        iconTheme:
            Theme.of(context).appBarTheme.iconTheme, // لون الأيقونة من الثيم
        centerTitle: true,
        title: Text(
          'بحث يدوي',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 24.sp,
              ), // نمط من الثيم
        ),
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
