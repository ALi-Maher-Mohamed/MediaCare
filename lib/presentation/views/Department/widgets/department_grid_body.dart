import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Department_Details/department_details_view.dart';
import 'package:media_care/presentation/views/Department/data/models/department_model.dart';
import 'package:media_care/presentation/views/Department/widgets/department_item.dart';

class DepartmentGridBody extends StatelessWidget {
  const DepartmentGridBody({
    super.key,
    required this.departments,
  });

  final List<Department> departments;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9.w / 1.0.h,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: departments.length,
        itemBuilder: (context, index) {
          final department = departments[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartmentDetailsScreen(
                    title: department.title,
                    departmentID: department.id,
                  ),
                  settings: RouteSettings(
                    arguments: department.title,
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.sp),
            child: DepartmentItem(
              title: department.title,
              iconUrl: department.icon,
            ),
          );
        },
      ),
    );
  }
}
