import 'package:bloc/bloc.dart';
import 'package:media_care/presentation/views/pharmacy_details/cubit/pharmacy_details_state.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/model/pharmacy_details_mode;.dart';
import 'package:media_care/presentation/views/pharmacy_details/data/repos/pharmacy_repo.dart';

class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  final PharmacyDetailsRepo repository;

  PharmacyDetailsCubit(this.repository) : super(PharmacyDetailsInitial());

  Future<void> fetchPharmacyDetails(String pharmacyId) async {
    emit(PharmacyDetailsLoading());

    final result = await repository.getPharmacyDetails(pharmacyId);

    result.fold(
      (failure) {
        emit(PharmacyDetailsError(failure.errMessage));
      },
      (pharmacy) {
        emit(PharmacyDetailsSuccess(pharmacy.data));
      },
    );
  }

  void addNewReview({
    required String userId,
    required String userName,
    required String? userAvatar,
    required String review,
    required int ratingValue,
    required String createdAt,
    required String pharmacyId,
  }) {
    if (state is PharmacyDetailsSuccess) {
      final currentState = state as PharmacyDetailsSuccess;
      final updatedPharmacy = currentState.pharmacy.copyWith(
        users: [
          ...currentState.pharmacy.users,
          User(
            id: userId,
            name: userName,
            avatar: userAvatar,
            email: '', // Default empty as it's not needed for display
            phone: '', // Default empty
            address: '', // Default empty
            birthDate: '', // Default empty
            role: '', // Default empty
            points: 0, // Default value
            lastVisit: '', // Default empty
            createdAt: createdAt,
            updatedAt: createdAt,
            pivot: Pivot(
              pharmacyId: pharmacyId,
              userId: userId,
              review: review,
              ratingValue: ratingValue,
              createdAt: createdAt,
              updatedAt: createdAt,
            ),
            googleId: null,
            emailVerifiedAt: null,
            verificationTokenExpiresAt: null,
            resetToken: null,
            resetTokenExpiresAt: null,
          ),
        ],
      );
      emit(PharmacyDetailsSuccess(updatedPharmacy));
    }
  }
}
