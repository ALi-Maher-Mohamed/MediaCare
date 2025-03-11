import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/presentation/views/pharmacies/data/model/pharmacy_model.dart';

import 'pharmacy_repo.dart';

class PharmacyRepoImpl implements PharmacyRepo {
  final Dio _dio;

  PharmacyRepoImpl(this._dio);

  @override
  Future<Either<Failure, List<PharmacyModel>>> getPharmacies(
      {int page = 1}) async {
    try {
      final response = await _dio.get(
        'http://10.0.2.2:8000/api/Pharmacies',
        queryParameters: {'page': page},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = response.data;
        if (jsonResponse['success'] == true) {
          final List<dynamic> data = jsonResponse['data']['data'];
          final pharmacies =
              data.map((json) => PharmacyModel.fromJson(json)).toList();
          return Right(pharmacies);
        } else {
          // نستخدم ServerFailure.fromResponse لتحويل استجابة الـ API الفاشلة
          return Left(
              ServerFailure.fromResponse(response.statusCode, jsonResponse));
        }
      } else {
        // نستخدم ServerFailure.fromResponse لأخطاء الحالة غير 200
        return Left(
            ServerFailure.fromResponse(response.statusCode, response.data));
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
