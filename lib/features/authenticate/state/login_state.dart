part of 'login_cubit.dart';

class LoginStates extends Equatable {
  const LoginStates();

  @override
  List<Object?> get props => [];
}

class LoginOnIdle extends LoginStates {}

class LoginOnGoing extends LoginStates {}

class LoginOnSucceed extends LoginStates {
  const LoginOnSucceed({required this.model});
  final AuthModel model;

  @override
  List<Object?> get props => ["model: $model"];
}

class LoginOnFailed extends LoginStates {
  const LoginOnFailed({required this.message});
  final String message;

  @override
  List<Object> get props => ["message: $message"];
}

class LoginOnError extends LoginStates {
  const LoginOnError({required this.model});
  final KocekReportModel model;

  @override
  List<Object> get props => ["model: $model"];
}
