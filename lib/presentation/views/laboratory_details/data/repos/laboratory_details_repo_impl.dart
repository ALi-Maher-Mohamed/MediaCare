import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:media_care/core/errors/failure.dart';
import 'package:media_care/core/network/api_service.dart';
import 'package:media_care/presentation/views/laboratory_details/data/models/laboratory_details_model.dart';
import 'package:media_care/presentation/views/laboratory_details/data/repos/laboratory_details_repo.dart';

class LaboratoryRepositoryImpl implements LaboratoryRepository {
  final ApiServiceFunctions apiService;

  LaboratoryRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, Laboratory>> getLaboratory(String id) async {
    try {
      final response = await apiService.get(
        endpoint: '/api/Laboratories/$id',
      );

      if (response['success'] == true) {
        final data = response['data'];
        return Right(_mapToLaboratory(data));
      } else {
        return Left(ServerFailure(response['message'] ?? 'Unknown error'));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Network error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Laboratory _mapToLaboratory(Map<String, dynamic> data) {
    return Laboratory(
      id: data['id'],
      title: data['title'],
      service: data['service'],
      image: data['image'],
      phone: data['phone'],
      city: data['city'],
      area: data['area'],
      locationUrl: data['locationUrl'],
      whatsappLink: data['whatsappLink'],
      insurance: data['insurence'],
      startAt: data['start_at'],
      endAt: data['end_at'],
      avgRate: data['avg_rate'],
      chainLaboratoryId: data['chain_laboratory_id'],
      createdAt: data['created_at'],
      updatedAt: data['updated_at'],
      users: (data['users'] as List<dynamic>)
          .map((user) => User(
                id: user['id'] ?? '',
                name: user['name'] ?? '',
                review: user['review'],
                rating: user['rating'],
              ))
          .toList(),
      insuranceCompanies: (data['insurance_companies'] as List<dynamic>)
          .map((company) => InsuranceCompany(
                id: company['id'] ?? '',
                name: company['name'] ?? '',
              ))
          .toList(),
    );
  }
}
