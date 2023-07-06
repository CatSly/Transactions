part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashProcessing extends SplashState {
  @override
  List<Object> get props => [];
}

class UserNonAuthenticated extends SplashState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashFailed extends SplashState {
  const SplashFailed(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
