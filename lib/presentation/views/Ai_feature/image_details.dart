import 'package:flutter/material.dart';
import 'package:media_care/presentation/views/Ai_feature/image_details_widgets/image_analysis_button.dart';
import 'package:media_care/presentation/views/Ai_feature/image_details_widgets/image_detail_app_bar.dart';
import 'package:media_care/presentation/views/Ai_feature/image_details_widgets/image_detail_viewer.dart';

class ImageDetailView extends StatelessWidget {
  final String imagePath;
  final String type;

  const ImageDetailView(
      {required this.imagePath, required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ImageDetailAppBar(),
      body: Column(
        children: [
          ImageDetailViewer(imagePath: imagePath),
          ImageAnalysisButton(imagePath: imagePath, type: type),
        ],
      ),
    );
  }
}
