import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/models/delivery_service_model.dart';
import 'delivery_service_item.dart';

class DeliveryServiceList extends StatelessWidget {
  final List<DeliveryServiceModel> services;

  const DeliveryServiceList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return DeliveryServiceItem(
          service: services[index],
          index: index,
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 8.h),
    );
  }
}
