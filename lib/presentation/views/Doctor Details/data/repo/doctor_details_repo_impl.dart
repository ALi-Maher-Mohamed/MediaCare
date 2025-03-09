import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/models/doctor_detail_model.dart';
import 'package:media_care/presentation/views/Doctor%20Details/data/repo/doctor_details_repo.dart';

class DoctorDetailsRepoImpl implements DoctorDetailsRepo {
  final ApiServiceFunctions apiService;
  DoctorDetailsRepoImpl(this.apiService);
  @override
  Future<Either<Failure, DoctorDetailsModel>> getDoctorDetails(
      String? id) async {
    try {
      final response = await apiService.get(endpoint: '/api/Doctors/$id');
      final doctorDetailsResponse = DoctorDetailsModel.fromJson(response);
      return Right(doctorDetailsResponse);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
