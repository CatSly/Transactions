import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

part 'splash_state.dart';

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkAuth() async {
    try {
      Future<void>.delayed(const Duration(milliseconds: 100), () {
        if (FirebaseAuth.instance.currentUser != null) {
          emit(UserAuthenticated());
        } else {
          emit(UserNonAuthenticated());
        }
      });
    } on Exception catch (e) {
      emit(SplashFailed(e.toString()));
    }
  }
}
