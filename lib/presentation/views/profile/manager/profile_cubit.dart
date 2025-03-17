import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/SharedPref/shared_pref.dart';
import '../../../../core/errors/failure.dart';
import '../data/models/profile_model.dart';
import '../data/repo/profile_repo_impl.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepoImpl profileRepo;
  // final SecureStorage secureStorage;
  String? userId;

  ProfileCubit({
    required this.profileRepo,
  }) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    try {
      String? token = await SharedPreference().getToken();
      print('token = $token');
      if (token == null) {
        emit(ProfileError('No token found'));
        return;
      }
      Either<Failure, UserModel> result =
          await profileRepo.getAccount(token: token);
      result.fold((failure) => emit(ProfileError(failure.errMessage)), (user) {
        userId = user.id;
        emit(ProfileLoaded(user));
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
