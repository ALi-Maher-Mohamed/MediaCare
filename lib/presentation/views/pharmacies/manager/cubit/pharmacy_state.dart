part of 'pharmacy_cubit.dart';

abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoadingState extends PharmacyState {}

class PharmacySuccessState extends PharmacyState {
  final List<PharmacyModel> pharmacies;
  final List<PharmacyModel> allPharmacies;

  PharmacySuccessState(this.pharmacies, this.allPharmacies);
}

class PharmacyErrorState extends PharmacyState {
  final String message;

  PharmacyErrorState(this.message);
}
