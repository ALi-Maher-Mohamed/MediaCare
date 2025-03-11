import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'package:media_care/presentation/views/pharmacies/widgets/pharmacy_view_body.dart';

class PharmacyView extends StatefulWidget {
  const PharmacyView({super.key});

  @override
  State<PharmacyView> createState() => _PharmacyViewState();
}

class _PharmacyViewState extends State<PharmacyView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<PharmacyCubit>().fetchPharmacies();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<PharmacyCubit>().fetchPharmacies(isLoadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return pharmacyViewBody(scrollController: _scrollController);
  }
}
