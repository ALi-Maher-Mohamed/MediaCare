import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:media_care/core/utils/cubits/theme_cubit.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_cubit.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_state.dart';
import '../../Auth/login/login_view.dart';

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
            (route) => false,
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
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall, // بالفعل بيتبع الـ Theme
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
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall, // بالفعل بيتبع الـ Theme
            ),
            Text(
              'باشا البلد @example.com',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ), // بالفعل بيتبع الـ Theme
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                ZoomDrawer.of(context)!.toggle();
              },
              child: ListTile(
                leading: Icon(Icons.home,
                    color: Theme.of(context)
                        .iconTheme
                        .color), // تعديل: تتبع الـ Theme
                title: Text(
                  'Home',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge, // بالفعل بيتبع الـ Theme
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings,
                  color: Theme.of(context)
                      .iconTheme
                      .color), // تعديل: تتبع الـ Theme
              title: Text(
                'Settings',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // بالفعل بيتبع الـ Theme
              ),
            ),
            ListTile(
              leading: Icon(Icons.help,
                  color: Theme.of(context)
                      .iconTheme
                      .color), // تعديل: تتبع الـ Theme
              title: Text(
                'Help',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // بالفعل بيتبع الـ Theme
              ),
            ),
            ListTile(
              leading: Icon(Icons.brightness_6,
                  color: Theme.of(context)
                      .iconTheme
                      .color), // تعديل: تتبع الـ Theme
              title: Text(
                'تبديل الثيم',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // تعديل: تتبع الـ Theme
              ),
              onTap: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_system_daydream,
                  color: Theme.of(context)
                      .iconTheme
                      .color), // تعديل: تتبع الـ Theme
              title: Text(
                'العودة لثيم النظام',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge, // تعديل: تتبع الـ Theme
              ),
              onTap: () {
                context.read<ThemeCubit>().resetToSystem(context);
              },
            ),
            GestureDetector(
              onTap: () {
                cubit.logout();
              },
              child: ListTile(
                leading: Icon(Icons.logout,
                    color: Theme.of(context)
                        .iconTheme
                        .color), // تعديل: تتبع الـ Theme
                title: Text(
                  'Logout',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge, // بالفعل بيتبع الـ Theme
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
