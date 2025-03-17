import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'pharmacy_repo.dart';

class PharmacyRepoImpl implements PharmacyRepo {
  final ApiServiceFunctions _apiService;

  PharmacyRepoImpl(Dio dio) : _apiService = ApiServiceFunctions(dio);

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacies(
      {int page = 1}) async {
    try {
      final response = await _apiService.get(
        endpoint: '/api/Pharmacies',
        queryParams: {'page': page},
      );

      if (response['success'] == true) {
        final List<dynamic> data = response['data']['data'];
        final pharmacies =
            data.map((json) => PharmacyModel.fromJson(json)).toList();
        return Right(pharmacies);
      } else {
        return Left(ServerFailure.fromResponse(200, response));
      }
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('Unexpected Error: $e'));
    }
  }
}
