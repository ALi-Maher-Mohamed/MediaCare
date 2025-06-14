import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/Department_Details/department_details_view.dart';
import 'package:media_care/presentation/views/Department/data/models/department_model.dart';
import 'package:media_care/presentation/views/Department/manager/department_cubit.dart';
import 'package:media_care/presentation/views/Department/manager/department_state.dart';

class SymptomSpecializationCard extends StatelessWidget {
  final String? recommendedSpecialization;

  const SymptomSpecializationCard({super.key, this.recommendedSpecialization});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_hospital,
                    color: Theme.of(context).colorScheme.primary),
                SizedBox(width: 8.w),
                Text(
                  'التخصص الموصى به:',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20.sp,
                      ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              recommendedSpecialization ?? 'غير محدد',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (recommendedSpecialization != null) ...[
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  final state = context.read<DepartmentCubit>().state;

                  if (state is DepartmentLoaded) {
                    final departments =
                        state.departmentResponse.data.departments;

                    final matchedDepartment = departments.firstWhere(
                      (dep) =>
                          dep.title.toLowerCase().trim() ==
                          recommendedSpecialization!.toLowerCase().trim(),
                      orElse: () => Department(
                        id: '',
                        title: '',
                        description: '',
                        icon: '',
                      ),
                    );

                    if (matchedDepartment.id.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DepartmentDetailsScreen(
                              departmentID: matchedDepartment.id,
                              title: matchedDepartment.title),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('التخصص المقترح غير موجود في قائمة الأقسام'),
                        ),
                      );
                    }
                  }
                },
                child: Text('عرض تفاصيل التخصص'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
