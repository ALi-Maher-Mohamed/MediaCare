// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_cubit.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_state.dart';
// import 'package:media_care/core/network/api_service.dart';
// import 'package:media_care/presentation/views/Auth/login/data/repo/login_repo_impl.dart';
import '../../Auth/login/login_view.dart';
// import '../../Auth/login/manager/login_cubit.dart';

class MenuViewBody extends StatelessWidget {
  const MenuViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LogoutCubit>();
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSucess) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess(
            state.logoutModel.message ?? "",
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
            (route) => false, // Remove all previous screens from the stack
          );
        } else if (state is LogoutLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is LogoutError) {
          EasyLoading.showError(state.error);
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              backgroundImage: Image.asset(
                'assets/images/Ali1.jpg',
                fit: BoxFit.fitHeight,
              ).image,
              radius: 100,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Ali Maher',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'باشا البلد @example.com',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                ZoomDrawer.of(context)!.toggle();
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              title: Text(
                'Settings',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: Colors.black,
              ),
              title: Text(
                'Help',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                cubit.logout();
                // context.read<LoginCubit>().logout();
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
