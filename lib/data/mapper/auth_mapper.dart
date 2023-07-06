import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:transactions_app/domain/entities/user_credentials.dart';

@LazySingleton()
class AuthMapper {
  UserCredentials toUserCredentials(UserCredential userCredential) {
    return UserCredentials(
      id: userCredential.user?.uid ?? '',
      email: userCredential.user?.email ?? '',
    );
  }
}
