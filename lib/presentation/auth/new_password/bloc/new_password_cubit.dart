import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:transactions_app/domain/repo/auth_repo.dart';

part 'new_password_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepo) : super(LoginInitial());
  final AuthRepo _authRepo;

  Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginProcessing());
      await _authRepo.loginWithEmail(email: email, password: password);
      emit(LoginSucceed());
    } on Exception catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
