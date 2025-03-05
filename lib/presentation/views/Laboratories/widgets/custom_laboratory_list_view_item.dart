import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/functins/launch_url.dart';
import '../data/model/labs_model/data.dart';
import 'laboratory_details_page.dart';

class LaboratoryListViewItem extends StatelessWidget {
  const LaboratoryListViewItem({
    super.key,
    required this.laboratory,
    required this.index,
  });
  final int index;
  final LaboratoryModel laboratory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LaboratoryDetailsPage(laboratory: laboratory),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                laboratory.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    laboratory.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${laboratory.city} - ${laboratory.area}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    laboratory.service,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.phone, color: AppColors.primary, size: 30),
              onPressed: () {
                launchDialer(laboratory.phone);
              },
            ),
          ],
        ),
      ),
    );
  }
}
