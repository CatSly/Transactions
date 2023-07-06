part of 'register_cubit.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationProcessing extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationSucceed extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationFailed extends RegistrationState {

  const RegistrationFailed(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
