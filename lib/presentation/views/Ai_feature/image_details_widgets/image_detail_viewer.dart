import 'dart:io';
import 'package:flutter/material.dart';

class ImageDetailViewer extends StatelessWidget {
  final String imagePath;

  const ImageDetailViewer({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.file(
          File(imagePath),
          fit:
              BoxFit.contain, // تغيير من fill إلى contain لعرض الصورة بشكل أفضل
        ),
      ),
    );
  }
}
