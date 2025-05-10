import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_care/core/utils/AI_feture_cards_data.dart';
import 'package:media_care/presentation/views/AI_Feature/image_details.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/manual_input_view.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_card.dart';

class RobotCardList extends StatelessWidget {
  RobotCardList({super.key});

  final Map<String, Function(BuildContext)> _navigationMap = {
    'manual': (context) => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ManualInputView()),
        ),
    'lab': (context) => _pickAndNavigate(context, 'lab'),
    'prescription': (context) => _pickAndNavigate(context, 'prescription'),
    'symptom': (context) => _pickAndNavigate(context, 'symptom'),
  };

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      padding: const EdgeInsets.symmetric(
          vertical: 10, horizontal: 16), // حشوة إضافية
      itemCount: robotCards.length,
      itemBuilder: (context, index) {
        final card = robotCards[index];
        return RobotCard(
          title: card['title']!,
          description: card['description']!,
          image: card['image']!,
          onTap: () => _navigationMap[card['type']!]!(context),
        );
      },
    );
  }

  static Future<void> _pickAndNavigate(
      BuildContext context, String type) async {
    final picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('التقاط صورة'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailView(
                          imagePath: pickedFile.path,
                          type: type,
                        ),
                      ),
                    );
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('اختر صورة من المعرض'),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDetailView(
                          imagePath: pickedFile.path,
                          type: type,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
