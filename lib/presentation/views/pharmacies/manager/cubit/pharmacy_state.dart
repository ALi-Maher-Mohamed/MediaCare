part of 'pharmacy_cubit.dart';

@immutable
abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacySuccessState extends PharmacyState {
  final List<PharmacyModel> pharmacies;
  final int currentPage;
  final bool hasMore;

  PharmacySuccessState({
    required this.pharmacies,
    required this.currentPage,
    required this.hasMore,
  });
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);
}
