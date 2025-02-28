// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:media_care/presentation/views/Department/data/models/department_model.dart';
// import 'package:media_care/presentation/views/Department/manager/department_cubit.dart';
// import 'package:media_care/presentation/views/Department/manager/department_state.dart';
//
// class DepartmentView extends StatelessWidget {
//   static const String routeName = "/Department";
//
//
//   const DepartmentView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // var data = DepartmentCubit.get(context).getDepartmentData(1);
//     return BlocConsumer<DepartmentCubit, DepartmentState>(
//       listener: (context, state) {
//         if (state is GetDepartmentLoading ) {
//           EasyLoading.dismiss();
//           EasyLoading.show(status: 'Loading...');
//         }
//         if (state is GetDepartmentError) {
//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               title: Text("Error"),
//               content: Text("Something went wrong"),
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color(0xff0dcaf0),
//             title: Text('Departments'),
//             titleTextStyle: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           body: ListView.builder(itemBuilder: (context, index) {
//             return Text('${data[index].data?.title??''}',
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.w600,
//               fontSize: 20,
//             ),
//             );
//           }, itemCount: data.length)
//         );
//       },
//     );
//   }
// }
