import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Laboratories/data/repo/laporatory_repo.dart';
import '../model/labs_model/pagination_labs_model.dart';

class LaboratoryRepoImpl implements LaboratoryRepo {
  final ApiServiceFunctions _apiService;

  LaboratoryRepoImpl(Dio dio) : _apiService = ApiServiceFunctions(dio);

  @override
  Future<Either<Failure, LaboratoryPagination>> getLaboratories(
      {int page = 1}) async {
    try {
      // استخدام دالة get من ApiServiceFunctions
      final response = await _apiService.get(
        endpoint: '/api/Laboratories', // المسار النسبي فقط
        queryParams: {'page': page},
      );

      if (response['success'] == true) {
        final laboratoryPagination =
            LaboratoryPagination.fromJson(response['data']);
        return Right(laboratoryPagination);
      } else {
        // معالجة استجابة الـ API الفاشلة
        return Left(ServerFailure.fromResponse(200, response));
      }
    } on DioException catch (e) {
      // معالجة أخطاء Dio
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      // أي خطأ غير متوقع
      return Left(ServerFailure('Unexpected Error: $e'));
    }
  }
}
