import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/presentation/views/Doctor%20Details/doctor_details_view.dart';
import 'package:media_care/presentation/views/doctors_offers/data/model/offer_group_model.dart';

class DoctorOfferDetailsView extends StatelessWidget {
  final DoctorOffer doctorOffer;

  const DoctorOfferDetailsView({super.key, required this.doctorOffer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: doctorOffer.images.isNotEmpty
                    ? doctorOffer.images[0].image
                    : '',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, size: 50),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Row(
                      children: [
                        Text(
                          doctorOffer.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                        ),
                        SizedBox(width: 16.w),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  ?.surface),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDetailsView(
                                    doctorID: doctorOffer.doctorId),
                              ),
                            );
                          },
                          child: Text(
                            'الذهاب للطبيب',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow(context, 'معلومات عن العرض',
                              doctorOffer.infoAboutOffer),
                          const Divider(),
                          _buildDetailRow(
                              context, 'للتواصل ', doctorOffer.details),
                          const Divider(),
                          _buildDetailRow(context, 'السعر قبل الخصم',
                              doctorOffer.priceBeforeDiscount),
                          const Divider(),
                          _buildDetailRow(
                              context, 'الخصم', doctorOffer.discount),
                          const Divider(),
                          _buildDetailRow(context, 'من', doctorOffer.fromDay),
                          const Divider(),
                          _buildDetailRow(context, 'الى', doctorOffer.toDay),
                        ],
                      ),
                    ),
                  ),
                  if (doctorOffer.images.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'صور العرض',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: doctorOffer.images.length,
                        itemBuilder: (context, index) {
                          final image = doctorOffer.images[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CachedNetworkImage(
                              imageUrl: image.image,
                              width: 150,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
