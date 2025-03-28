import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/utils/cubits/theme_cubit.dart';
import 'observer.dart';
import 'zoom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await SharedPreference().getToken();
  Bloc.observer = MyBlocObserver();

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MediCare(),
    ),
  );
}

class MediCare extends StatelessWidget {
  final bool isLoggedIn;

  const MediCare({this.isLoggedIn = false, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // تحديث الـ Theme في البداية بناءً على النظام
        context.read<ThemeCubit>().setInitialTheme(context);
        return BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            // تحديث تلقائي بناءً على النظام لو مش يدوي
            context.read<ThemeCubit>().setInitialTheme(context);
            return MaterialApp(
              theme: theme,
              locale: const Locale('ar'),
              builder: EasyLoading.init(builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                );
              }),
              debugShowCheckedModeBanner: false,
              home: HomeView(),
              // isLoggedIn ? const HomeView() : const LoginView(),
            );
          },
        );
      },
    );
  }
}
