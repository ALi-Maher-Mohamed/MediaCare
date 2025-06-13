import 'package:dartz/dartz.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details_mode;.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/repos/pharmacy_repo.dart';

class PharmacyDetailsRepoImpl implements PharmacyDetailsRepo {
  final ApiServiceFunctions apiService;

  PharmacyDetailsRepoImpl({required this.apiService});

  @override
  Future<Either<Failure, PharmacyResponse>> getPharmacyDetails(
      String pharmacyId) async {
    try {
      final data =
          await apiService.get(endpoint: '/api/Pharmacies/$pharmacyId');
      final pharmacyResponse = PharmacyResponse.fromJson(data);
      return Right(pharmacyResponse);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
