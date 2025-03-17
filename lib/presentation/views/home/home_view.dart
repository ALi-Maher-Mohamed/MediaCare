import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import 'package:media_care/presentation/views/pharmacies/data/repos/pharmacy_repo_impl.dart';
import '../no_internet/no_intenet_view.dart';
import '../pharmacies/manager/cubit/pharmacy_cubit.dart';
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
                      PharmacyCubit(PharmacyRepoImpl(Dio()))..fetchPharmacies(),
                  child: HomeViewBody(),
                );
              } else {
                return NoInternetView();
              }
            },
            child: CustomProgressIndicator()),
      ),
    );
  }
}
