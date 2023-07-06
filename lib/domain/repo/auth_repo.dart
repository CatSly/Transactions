import 'package:transactions_app/domain/entities/user_credentials.dart';

abstract class AuthRepo {
  Future<bool> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserCredentials> registerWithEmail({
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});

  Future<void> updateLastLogin();
}
