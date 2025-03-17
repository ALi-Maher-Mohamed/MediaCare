import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';
import 'pharmacy_repo.dart';

class PharmacyRepoImpl implements PharmacyRepo {
  final ApiServiceFunctions _apiService;

  PharmacyRepoImpl(Dio dio)
      : _apiService =
            ApiServiceFunctions(dio); // تمرير Dio إلى ApiServiceFunctions

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacies(
      {int page = 1}) async {
    try {
      // استخدام دالة get من ApiServiceFunctions
      final response = await _apiService.get(
        endpoint: '/api/Pharmacies', // نستخدم المسار فقط بدون الـ base URL
        queryParams: {'page': page},
      );

      if (response['success'] == true) {
        final List<dynamic> data = response['data']['data'];
        final pharmacies =
            data.map((json) => PharmacyModel.fromJson(json)).toList();
        return Right(pharmacies);
      } else {
        // نستخدم ServerFailure.fromResponse لتحويل استجابة الـ API الفاشلة
        return Left(ServerFailure.fromResponse(200, response));
      }
    } on DioException catch (e) {
      // نستخدم ServerFailure.fromDioError لتحويل أخطاء Dio
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      // أي خطأ غير متوقع
      return Left(ServerFailure('Unexpected Error: $e'));
    }
  }
}
