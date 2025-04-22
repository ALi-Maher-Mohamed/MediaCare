import 'package:flutter/material.dart';
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
              builder: (context) =>
                  LaboratoryDetailsPage(laboratory: laboratory),
            ),
          );
        },
        child: LabListViewItemCard(laboratory: laboratory));
  }
}

class LabListViewItemCard extends StatelessWidget {
  const LabListViewItemCard({
    super.key,
    required this.laboratory,
  });

  final LaboratoryModel laboratory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // الصورة على اليسار
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              laboratory.image,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/Gifs/laboratory.gif',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingProgress == null
                      ? child
                      : SizedBox(
                          width: 60,
                          height: 60,
                          child: const CircularProgressIndicator(),
                        ),
            ),
          ),
          const SizedBox(width: 12), // مسافة بين الصورة والنصوص
          // النصوص في المنتصف
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  laboratory.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '${laboratory.city} - ${laboratory.area}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          // أيقونة على اليمين
          IconButton(
            icon: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
            onPressed: () {
              launchCustomUrl(context, '${laboratory.locationUrl}');
            },
          ),
        ],
      ),
    );
  }
}
