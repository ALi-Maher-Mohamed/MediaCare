import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../pharmacies/data/service/pharmacy_service.dart';
import '../pharmacies/manager/cubit/pharmacy_cubit.dart';
import '../../../core/utils/app_color.dart';
import '../no_internet/no_intenet_view.dart';
import 'widgets/home_view_body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            if (connected) {
              return BlocProvider(
                create: (context) =>
                    PharmacyCubit(PharmacyService())..fetchPharmacies(),
                child: HomeViewBody(),
              );
            } else {
              return NoInternetView();
            }
          },
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
