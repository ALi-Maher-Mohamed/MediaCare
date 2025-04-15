import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/offers_details/offer_details_cubit.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/offers_details/offer_details_state.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';

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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow(
                                    context,
                                    'Created At',
                                    offer.createdAt.toString().split('.')[0],
                                  ),
                                  const Divider(),
                                  _buildDetailRow(
                                    context,
                                    'Updated At',
                                    offer.updatedAt.toString().split('.')[0],
                                  ),
                                  const Divider(),
                                  _buildDetailRow(
                                    context,
                                    'Doctor Offers',
                                    offer.doctorOffersCount?.toString() ?? '0',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (offer.doctorOffers != null &&
                              offer.doctorOffers!.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Text(
                              'Related Doctor Offers',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            ...offer.doctorOffers!.map(
                              (offer) => ListTile(
                                title: Text(offer
                                    .toString()), // Placeholder until we have a model
                                leading: const Icon(Icons.medical_services),
                              ),
                            ),
                          ],
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
