import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/doctors_offers/data/model/offer_group_model.dart';

abstract class OfferGroupRepository {
  Future<Either<String, OfferGroupResponse>> getOfferGroups({int page = 1});
  Future<Either<String, OfferGroupDetailsResponse>> getOfferGroupDetails(
      String id);
}

class OfferGroupRepositoryImpl implements OfferGroupRepository {
  final ApiServiceFunctions apiService;

  OfferGroupRepositoryImpl(this.apiService);

  @override
  Future<Either<String, OfferGroupResponse>> getOfferGroups(
      {int page = 1}) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/Offer_Groups',
        queryParams: {'page': page},
      );
      final offerGroupResponse = OfferGroupResponse.fromJson(response);
      if (offerGroupResponse.success) {
        return Right(offerGroupResponse);
      } else {
        return Left(offerGroupResponse.message);
      }
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to fetch offer groups');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }

  @override
  Future<Either<String, OfferGroupDetailsResponse>> getOfferGroupDetails(
      String id) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/Offer_Groups/$id',
      );
      final offerGroupDetailsResponse =
          OfferGroupDetailsResponse.fromJson(response);
      if (offerGroupDetailsResponse.success) {
        return Right(offerGroupDetailsResponse);
      } else {
        return Left(offerGroupDetailsResponse.message);
      }
    } on DioException catch (e) {
      return Left(e.message ?? 'Failed to fetch offer group details');
    } catch (e) {
      return Left('Unexpected error: $e');
    }
  }
}
