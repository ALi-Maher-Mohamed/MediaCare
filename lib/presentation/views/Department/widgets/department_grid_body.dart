import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Department%20Details/department_details_view.dart';
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .9,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
          crossAxisCount: 2),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DepartmentDetailsScreen(
                  departmentID: department.id,
                ),
                settings: RouteSettings(
                  arguments: department.title,
                ),
              ),
            );
          },
          child: DepartmentItem(
            title: department.title,
            iconUrl: department.icon,
          ),
        );
      },
    );
  }
}
