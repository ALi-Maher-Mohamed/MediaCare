import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/cubits/theme_cubit.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_cubit.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_state.dart';
import 'package:media_care/presentation/views/My%20appointments/widgets/myAppointments_view.dart';
import 'package:media_care/presentation/views/profile/data/repo/profile_repo_impl.dart';
import 'package:media_care/presentation/views/profile/manager/profile_cubit.dart';
import 'package:media_care/presentation/views/profile/manager/profile_state.dart';
import 'package:media_care/presentation/views/profile/profile_ui.dart';
import '../../Auth/login/login_view.dart';

class MenuViewBody extends StatelessWidget {
  const MenuViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(
        profileRepo: ProfileRepoImpl(ApiServiceFunctions(Dio())),
      )..fetchProfile(),
      child: BlocConsumer<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is LogoutSucess) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess(state.logoutModel.message ?? "");
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
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, profileState) {
              if (profileState is ProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (profileState is ProfileLoaded) {
                final user = profileState.user;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'مرحبا بك',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.avatar ??
                            "https://cdn.pixabay.com/photo/2017/07/18/23/23/user-2517430_1280.png",
                      ),
                      radius: 100,
                    ),
                    SizedBox(height: 20),
                    Text(
                      user.name!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      user.email!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    // باقي القائمة كما هي
                    buildListTiles(context),
                  ],
                );
              } else if (profileState is ProfileError) {
                return Center(child: Text("حدث خطأ: ${profileState.message}"));
              } else {
                return Center(child: Text("جاري تحميل البيانات..."));
              }
            },
          );
        },
      ),
    );
  }

  Widget buildListTiles(BuildContext context) {
    var cubit = context.read<LogoutCubit>();

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
            title: Text(
              'الرئيسية',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.solidCalendar, color: Theme.of(context).iconTheme.color),
          title: Text(
            'حجوزاتي',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AppointmentsScreen()));
          },
        ),
        ListTile(
          leading: Icon(Icons.brightness_6,
              color: Theme.of(context).iconTheme.color),
          title: Text(
            'تبديل الثيم',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () {
            context.read<ThemeCubit>().toggleTheme();
          },
        ),
        ListTile(
          leading: FaIcon(FontAwesomeIcons.solidUser, color: Theme.of(context).iconTheme.color),
          title: Text(
            'الحساب الشخصي',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
          },
        ),
        GestureDetector(
          onTap: () {
            cubit.logout();
          },
          child: ListTile(
            leading:
                Icon(Icons.logout, color: Theme.of(context).iconTheme.color),
            title: Text(
              'تسجيل الخروج',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
