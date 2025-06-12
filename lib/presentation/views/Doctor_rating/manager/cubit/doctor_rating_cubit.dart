import 'package:bloc/bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/Doctor_rating/data/repo/doctor_rating_repo_impl.dart';
import 'package:media_care/presentation/views/Doctor_rating/manager/cubit/doctor_rating_state.dart';

class DoctorRatingCubit extends Cubit<DoctorRatingState> {
  final DoctorRatingRepoImpl ratingRepo;

  DoctorRatingCubit(this.ratingRepo) : super(DoctorRatingInitial());

  int _rating = 0;
  String _review = 'لم يكتب المستخدم مراجعة';
  bool _isSubmitting = false;

  int get rating => _rating;
  String get review => _review;
  bool get isSubmitting => _isSubmitting;

  void updateRating(int newRating) {
    _rating = newRating;
    emit(DoctorRatingUpdated(rating: _rating, review: _review));
  }

  void updateReview(String newReview) {
    _review = newReview;
    emit(DoctorRatingUpdated(rating: _rating, review: _review));
  }

  Future<void> submitRating({
    required String userId,
    required String doctorId,
  }) async {
    if (_rating == 0) {
      emit(DoctorRatingError('الرجاء اختيار تقييم من 1 إلى 5 نجوم'));
      return;
    }

    _isSubmitting = true;
    emit(DoctorRatingLoading());

    final token = await SharedPreference().getToken();
    if (token == null || token.isEmpty) {
      _isSubmitting = false;
      emit(const DoctorRatingError('يجب تسجيل الدخول أولاً'));
      return;
    }

    final response = await ratingRepo.submitRating(
      review: _review,
      ratingValue: _rating,
      userId: userId,
      doctorId: doctorId,
      token: token,
    );

    response.fold(
      (failure) {
        _isSubmitting = false;
        emit(DoctorRatingError(failure.errMessage));
      },
      (success) {
        _isSubmitting = false;
        emit(DoctorRatingSuccess(success));
      },
    );
  }
}
