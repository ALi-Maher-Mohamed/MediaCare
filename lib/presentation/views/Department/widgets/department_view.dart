import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/department_cubit.dart';
import '../manager/department_state.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Departments'),
      ),
      body: BlocConsumer<DepartmentCubit, DepartmentState>(
        listener: (context, state) {
          if (state is DepartmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is DepartmentInitial) {
            return Center(child: Text('Initial state'));
          } else if (state is DepartmentLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DepartmentLoaded) {
            final departments = state.departmentResponse.data.departments;
            return ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return ListTile(
                  leading: Image.network(department.icon),
                  title: Text(department.title),
                  subtitle: Text(department.description),
                );
              },
            );
          } else if (state is DepartmentError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }
}
