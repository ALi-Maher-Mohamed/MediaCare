import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../pharmacies/manager/cubit/pharmacy_cubit.dart';
import 'custom_offer_item.dart';

class PharmacyListView extends StatelessWidget {
  PharmacyListView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      child:
          BlocBuilder<PharmacyCubit, PharmacyState>(builder: (context, State) {
        if (State is PharmacyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (State is PharmacySuccessState) {
          var pharmacy = [...State.pharmacies];
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: pharmacy.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                child: CustomListViewItem(
                  image: pharmacy[index].image,
                  title: pharmacy[index].title,
                ),
              );
            },
          );
        } else {
          return Center(child: Text(' لا توجد بيانات متاحة للعرض'));
        }
      }),
    );
  }
}
