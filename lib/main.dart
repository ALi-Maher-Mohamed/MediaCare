import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/repo/Labs_analytics_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/Labs_analytics/managers/cubit/labs_analytics_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/manager/cubit/prescription_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/prescription_analysis/repo/Prescription_repo_impl.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/managers/cubit/symptom_cubit.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo.dart';
import 'package:media_care/presentation/views/AI_Feature/symptom_analysis/repos/symptom_analysis_repo_impl.dart';
import 'package:media_care/presentation/views/Auth/login/login_view.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo_impl.dart';
import 'observer.dart';
import 'zoom_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final service = LaboratoryRepoImpl(Dio());
  final result = await service.getLaboratories(page: 1);
  print('Test API call: ${result.fold((l) => l, (r) => r)}');
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
        ],
        child: MaterialApp(
          locale: Locale('ar'),
          builder: EasyLoading.init(builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              // يجعل التطبيق بالكامل من اليسار لليمين
              child: child!,
            );
          }),
          debugShowCheckedModeBanner: false,
          home: isLoggedIn ? HomeView() : HomeView(),
        ),
      ),
    );
  }
}
