import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/laboratories_rating/data/repo/laboratory_rating_repo_impl.dart';
import 'package:media_care/presentation/views/laboratories_rating/manager/cubit/laboratory_rating_state.dart';

class LaboratoryRatingCubit extends Cubit<LaboratoryRatingState> {
  final LaboratoryRatingRepoImpl ratingRepo;

  int rating = 0;
  String review = 'لم يكتب المستخدم مراجعة';
  bool isSubmitting = false;
  String? errorMessage;

  LaboratoryRatingCubit(this.ratingRepo) : super(LaboratoryRatingInitial());

  void updateRating(int newRating) {
    rating = newRating;
    emit(LaboratoryRatingUpdated(rating));
  }

  void updateReview(String newReview) {
    review = newReview;
    emit(LaboratoryRatingReviewUpdated(review));
  }

  Future<void> submitRating({
    required String userId,
    required String laboratoryId,
  }) async {
    if (rating == 0) {
      emit(LaboratoryRatingError('الرجاء اختيار تقييم من 1 إلى 5 نجوم'));
      return;
    }

    emit(LaboratoryRatingLoading());
    isSubmitting = true;

    final token = await SharedPreference().getToken();
    if (token == null || token.isEmpty) {
      emit(const LaboratoryRatingError('يجب تسجيل الدخول أولاً'));
      isSubmitting = false;
      return;
    }

    final response = await ratingRepo.submitRating(
      review: review,
      ratingValue: rating,
      userId: userId,
      laboratoryId: laboratoryId,
      token: token,
    );

    response.fold(
      (failure) {
        errorMessage = failure.errMessage;
        isSubmitting = false;
        emit(LaboratoryRatingError(failure.errMessage));
      },
      (success) {
        isSubmitting = false;
        emit(LaboratoryRatingSuccess(success));
      },
    );
  }
}
