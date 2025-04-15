import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_cubit.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_state.dart';
import 'package:media_care/presentation/views/doctors_offers/widgets/offer_group_details_view.dart';

class OfferGroupView extends StatefulWidget {
  const OfferGroupView({super.key});

  @override
  State<OfferGroupView> createState() => _OfferGroupViewState();
}

class _OfferGroupViewState extends State<OfferGroupView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<OfferGroupCubit>().fetchOfferGroups();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.8 &&
          !(context.read<OfferGroupCubit>().state is OfferGroupLoadingMore)) {
        context.read<OfferGroupCubit>().fetchOfferGroups(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offer Groups')),
      body: BlocBuilder<OfferGroupCubit, OfferGroupState>(
        builder: (context, state) {
          if (state is OfferGroupLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OfferGroupLoaded ||
              state is OfferGroupLoadingMore) {
            final offerGroups = state is OfferGroupLoaded
                ? state.offerGroups
                : (state as OfferGroupLoadingMore).offerGroups;
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  offerGroups.length + (state is OfferGroupLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == offerGroups.length &&
                    state is OfferGroupLoadingMore) {
                  return const Center(child: CircularProgressIndicator());
                }
                final offer = offerGroups[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Hero(
                      tag: 'offer_image_${offer.id}',
                      child: CachedNetworkImage(
                        imageUrl: offer.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    title: Text(offer.title),
                    subtitle: Text(
                        'Created: ${offer.createdAt.toString().split('.')[0]}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OfferGroupDetailsView(offerId: offer.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is OfferGroupError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<OfferGroupCubit>().fetchOfferGroups(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
