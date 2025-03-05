import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/widgets/custom_shimmer_list_view.dart';
import 'package:shimmer/shimmer.dart';
import '../data/service/pharmacy_service.dart';
import '../manager/cubit/pharmacy_cubit.dart';
import 'pharmact_list_view.dart';

class PharmacyViewBody extends StatelessWidget {
  const PharmacyViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PharmacyCubit(PharmacyService())..fetchPharmacies(),
      child: BlocBuilder<PharmacyCubit, PharmacyState>(
        builder: (context, state) {
          if (state is PharmacyLoading && (state is! PharmacySuccessState)) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PharmacyError) {
            return Center(child: Text(state.message));
          } else if (state is PharmacySuccessState) {
            return CustomPharmacyListView(
              pharmacies: state.pharmacies,
            );
          }
          return Shimmer.fromColors(
            baseColor: AppColors.primary,
            highlightColor: Colors.white,
            child: CustomShimmerListView(),
          );
        },
      ),
    );
  }
}

//  Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(
//                 pharmacy.image,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pharmacy.title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${pharmacy.city} - ${pharmacy.area}',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     pharmacy.service,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.blueGrey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.phone, color: AppColors.primary, size: 30),
//               onPressed: () {
//                 launchDialer(pharmacy.phone);
//               },
//             ),
//           ],
//         ),
//       ),
