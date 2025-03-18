import 'package:equatable/equatable.dart';

import 'package:media_care/presentation/views/Auth/logout/data/models/logout_model.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSucess extends LogoutState {
  final LogoutModel logoutModel;

  LogoutSucess({
    required this.logoutModel,
  });
  @override
  List<Object> get props => [logoutModel];
}

class LogoutError extends LogoutState {
  final String error;
  LogoutError({required this.error});
  List<Object> get props => [error];
}
