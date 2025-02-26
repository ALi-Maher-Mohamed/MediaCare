import 'package:flutter/material.dart';
import '../../../../core/utils/app_color.dart';
import '../../search/search_view.dart';

class SearchDoctor extends StatelessWidget {
  const SearchDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ' ! أكتشف المزيد ',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchView();
                }));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'ابحث بالتخصص او باسم الدكتور',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.search,
                      color: AppColors.primary,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
