part of 'pharmacy_cubit.dart';

@immutable
abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacySuccessState extends PharmacyState {
  final List<PharmacyModel> pharmacies;

  PharmacySuccessState(this.pharmacies);
}

class PharmacyError extends PharmacyState {
  final String message;

  PharmacyError(this.message);
}
