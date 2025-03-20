import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_care/core/utils/AI_feture_cards_data.dart';
import 'package:media_care/presentation/views/AI_Feature/image_details.dart';
import 'package:media_care/presentation/views/AI_Feature/manual_input_image/manual_input_view.dart';
import 'package:media_care/presentation/views/AI_Feature/widgets_robot_view/robot_card.dart';

class RobotCardList extends StatelessWidget {
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
      separatorBuilder: (context, index) => SizedBox(
        height: 10.h,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
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
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
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
  }
}
