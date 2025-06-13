import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/SharedPref/shared_pref.dart';
import '../../../../core/errors/failure.dart';
import '../data/models/profile_model.dart';
import '../data/repo/profile_repo_impl.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepoImpl profileRepo;
  String? _userId;
  String? _userName;
  String? _userAvatar;

  ProfileCubit({
    required this.profileRepo,
  }) : super(ProfileInitial());

  String? get userId => _userId;
  String? get userName => _userName;
  String? get userAvatar => _userAvatar;

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
        _userId = user.id;
        _userName = user.name;
        _userAvatar = user.avatar;
        emit(ProfileLoaded(user));
      });
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
