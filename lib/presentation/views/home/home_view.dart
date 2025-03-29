import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:media_care/core/utils/widgets/custom_circular_indicator.dart';
import '../no_internet/no_intenet_view.dart';
import 'widgets/home_view_body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            List<ConnectivityResult> connectivity,
            Widget child,
          ) {
            final bool connected =
                !connectivity.contains(ConnectivityResult.none);
            return connected ? HomeViewBody() : NoInternetView();
          },
          child: CustomProgressIndicator(),
        ),
      ),
    );
  }
}
