import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Doctor%20Details/doctor_details_view.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/offers_details/offer_details_cubit.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/offers_details/offer_details_state.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';
import 'package:media_care/presentation/views/doctors_offers/widgets/doctor_offer_details_view.dart';
import 'package:dio/dio.dart';

class OfferGroupDetailsView extends StatelessWidget {
  final String offerId;

  const OfferGroupDetailsView({super.key, required this.offerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferGroupDetailsCubit(
        OfferGroupRepositoryImpl(ApiServiceFunctions(Dio())),
      )..fetchOfferGroupDetails(offerId),
      child: Scaffold(
        body: BlocBuilder<OfferGroupDetailsCubit, OfferGroupDetailsState>(
          builder: (context, state) {
            if (state is OfferGroupDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OfferGroupDetailsLoaded) {
              final offer = state.offerGroup;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 300,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: 'offer_image_${offer.id}',
                        child: CachedNetworkImage(
                          imageUrl: offer.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error, size: 50),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: _buildDetailRow(
                                context,
                                'العروض المتاحة :',
                                offer.doctorOffersCount?.toString() ?? '0',
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (offer.doctorOffers == null ||
                              offer.doctorOffers!.isEmpty)
                            Column(
                              children: [
                                Text(
                                  'لا توجد عروض في الوقت الحالي',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            )
                          else
                            ...offer.doctorOffers!.map(
                              (doctorOffer) => Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                    imageUrl: doctorOffer.images.isNotEmpty
                                        ? doctorOffer.images[0].image
                                        : offer.image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                  title: Text(doctorOffer.title),
                                  subtitle:
                                      Text('الخصم: ${doctorOffer.discount}'),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DoctorOfferDetailsView(
                                                doctorOffer: doctorOffer),
                                      ),
                                    );
                                  },
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DoctorDetailsView(
                                                  doctorID:
                                                      doctorOffer.doctorId),
                                        ),
                                      );
                                    },
                                    child: const Text('الذهاب للطبيب'),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is OfferGroupDetailsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () => context
                          .read<OfferGroupDetailsCubit>()
                          .fetchOfferGroupDetails(offerId),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
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
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}
