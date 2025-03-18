import 'package:bloc/bloc.dart';
import 'package:media_care/core/SharedPref/shared_pref.dart';
import 'package:media_care/presentation/views/Auth/logout/data/repo/logout_repo.dart';
import 'package:media_care/presentation/views/Auth/logout/manager/cubit/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutRepo logoutRepo;
  LogoutCubit({required this.logoutRepo}) : super(LogoutInitial());
  bool isLoading = false;
  Future<void> logout() async {
    emit(LogoutLoading());
    String? token = await SharedPreference().getToken();
    if (token == null || token.isEmpty) {
      emit(LogoutError(error: "Missing token"));
      return;
    }
    final response = await logoutRepo.logout(token: token.trim());
    response.fold((failure) => emit(LogoutError(error: failure.errMessage)),
        (data) async {
      await SharedPreference().clearToken();
      emit(LogoutSucess(logoutModel: data));
    });
  }
}
