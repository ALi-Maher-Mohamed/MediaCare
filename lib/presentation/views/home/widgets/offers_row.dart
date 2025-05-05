import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/core/utils/app_color.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_cubit.dart';
import 'package:media_care/presentation/views/doctors_offers/data/manager/cubit/doctor_offers_state.dart';
import 'package:media_care/presentation/views/doctors_offers/data/repos/offer_group_repository.dart';
import 'package:media_care/presentation/views/doctors_offers/widgets/offer_group_details_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dio/dio.dart';

class OffersRow extends StatelessWidget {
  const OffersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferGroupCubit(
        OfferGroupRepositoryImpl(ApiServiceFunctions(Dio())),
      )..fetchOfferGroups(),
      child: BlocBuilder<OfferGroupCubit, OfferGroupState>(
        builder: (context, state) {
          if (state is OfferGroupLoading) {
            return SizedBox(
              height: 150.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.h),
                    child: Shimmer.fromColors(
                      baseColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.6),
                      highlightColor: Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(0.8),
                      child: Column(
                        children: [
                          Container(
                            width: 110.w,
                            height: 110.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 90.w,
                            height: 16.h,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is OfferGroupLoaded) {
            final offers = state.offerGroups;
            if (offers.isEmpty) {
              return const SizedBox(
                height: 150,
                child: Center(child: Text('No offers available')),
              );
            }
            return OffersRowBody(offers: offers);
          } else if (state is OfferGroupError) {
            return SizedBox(
              height: 150.h,
              child: Center(child: Text(state.message)),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class OffersRowBody extends StatelessWidget {
  const OffersRowBody({
    super.key,
    required this.offers,
  });

  final List offers;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: offers.length,
      options: CarouselOptions(
        reverse: true,
        height: 180.h,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.5,
        autoPlayInterval: Duration(seconds: 3),
      ),
      itemBuilder: (context, index, realIndex) {
        final offer = offers[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OfferGroupDetailsView(offerId: offer.id),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.sp),
                child: CachedNetworkImage(
                  imageUrl: offer.image,
                  width: 140.w,
                  height: 110.h,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                offer.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
