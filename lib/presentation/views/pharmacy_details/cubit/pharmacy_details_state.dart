import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details_mode;.dart';

abstract class PharmacyDetailsState {}

class PharmacyDetailsInitial extends PharmacyDetailsState {}

class PharmacyDetailsLoading extends PharmacyDetailsState {}

class PharmacyDetailsSuccess extends PharmacyDetailsState {
  final PharmacyData pharmacy;

  PharmacyDetailsSuccess(this.pharmacy);
}

class PharmacyDetailsError extends PharmacyDetailsState {
  final String message;

  PharmacyDetailsError(this.message);
}
