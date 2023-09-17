part of 'auth_cubit.dart';

class AuthStates extends Equatable {
  const AuthStates();

  @override
  List<Object?> get props => [];
}

class AuthOnGoing extends AuthStates {}

class AuthOnDashboard extends AuthStates {}

class AuthOnLogin extends AuthStates {}

class AuthOnDashboardWithNotification extends AuthStates {
  const AuthOnDashboardWithNotification({required this.message});
  final String message;

  @override
  List<Object?> get props => ["message: $message"];
}
