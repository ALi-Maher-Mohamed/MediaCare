import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/network/api_service.dart';
import '../models/hospital_model.dart';
import 'hospital_repo.dart';

class HospitalRepoImpl implements HospitalRepo {
  final ApiServiceFunctions apiService;

  HospitalRepoImpl(this.apiService);

  @override
  Future<Either<Failure, HospitalModel>> getHospitals() async {
    try {
      final response = await apiService.get(endpoint: '/api/Hospitals');
      final HospitalResponse = HospitalModel.fromJson(response);
      return Right(HospitalResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
