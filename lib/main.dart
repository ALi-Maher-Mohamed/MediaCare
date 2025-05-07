import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/cubits/theme_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo_impl.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_cubit.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';
import 'package:media_care/presentation/views/doctors_offers/offer_group_view.dart';
import 'observer.dart';
import 'zoom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String? token = await SharedPreference().getToken();
  Bloc.observer = MyBlocObserver();

  runApp(MediCare(
    isLoggedIn: token != null,
  ));
}

class MediCare extends StatelessWidget {
  final bool isLoggedIn;

  MediCare({required this.isLoggedIn, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OfferGroupCubit(
                OfferGroupRepositoryImpl(ApiServiceFunctions(Dio()))),
            child: const OfferGroupView(),
          ),
          BlocProvider(
            create: (context) => PrescriptionCubit(PrescriptionRepoImpl(Dio())),
          ),
          BlocProvider(
            create: (context) =>
                SymptomAnalysisCubit(SymptomAnalysisRepositoryImpl(Dio())),
          ),
          BlocProvider(
            create: (context) =>
                LabAnalysisCubit(LabAnalysisRepositoryImpl(Dio())),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            context.read<ThemeCubit>().setInitialTheme(context);
            return MaterialApp(
              theme: theme,
              locale: Locale('ar'),
              builder: EasyLoading.init(builder: (context, child) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: child!,
                );
              }),
              debugShowCheckedModeBanner: false,
              home: HomeView(),
            );
          },
        ),
      ),
    );
  }
}
