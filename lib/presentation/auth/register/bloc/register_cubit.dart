import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:transactions_app/domain/repo/auth_repo.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegistrationState> {
  RegisterCubit(this._authRepo) : super(RegistrationInitial());
  final AuthRepo _authRepo;
  // final UserRepo _userRepo;

  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(RegistrationProcessing());
      final user = await _authRepo.registerWithEmail(
        email: email,
        password: password,
      );
      // await _userRepo.writeUserDown(
      //   id: user.id,
      //   email: user.email,
      // );
      emit(RegistrationSucceed());
    } on Exception catch (e) {
      emit(RegistrationFailed(e.toString()));
    }
  }
}
