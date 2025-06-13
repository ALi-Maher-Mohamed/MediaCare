import 'package:bloc/bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/data/repos/pharmacy_rating_repo_impl.dart';
import 'package:media_care/presentation/views/Pharmacie_rating/manager/cubit/pharmacy_rating_state.dart';

class PharmacyRatingCubit extends Cubit<PharmacyRatingState> {
  final PharmacyRatingRepoImpl ratingRepo;

  int rating = 0;
  String review = 'لم يكتب المستخدم مراجعة';
  bool isSubmitting = false;
  String? errorMessage;

  PharmacyRatingCubit(this.ratingRepo) : super(PharmacyRatingInitial());

  void updateRating(int newRating) {
    rating = newRating;
    emit(PharmacyRatingUpdated(rating));
  }

  void updateReview(String newReview) {
    review = newReview.isEmpty ? 'لم يكتب المستخدم مراجعة' : newReview;
    emit(PharmacyRatingReviewUpdated(review));
  }

  Future<void> submitRating({
    required String userId,
    required String pharmacyId,
  }) async {
    if (rating == 0) {
      emit(PharmacyRatingError('الرجاء اختيار تقييم من 1 إلى 5 نجوم'));
      return;
    }

    emit(PharmacyRatingLoading());
    isSubmitting = true;

    final token = await SharedPreference().getToken();
    if (token == null || token.isEmpty) {
      emit(const PharmacyRatingError('يجب تسجيل الدخول أولاً'));
      isSubmitting = false;
      return;
    }

    final response = await ratingRepo.submitRating(
      review: review,
      ratingValue: rating,
      userId: userId,
      pharmacyId: pharmacyId,
      token: token,
    );

    response.fold(
      (failure) {
        errorMessage = failure.errMessage;
        isSubmitting = false;
        emit(PharmacyRatingError(failure.errMessage));
      },
      (success) {
        isSubmitting = false;
        emit(PharmacyRatingSuccess(
          review: review,
          ratingValue: rating,
        ));
      },
    );
  }
}
