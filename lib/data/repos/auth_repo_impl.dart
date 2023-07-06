import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:transactions_app/data/mapper/auth_mapper.dart';
import 'package:transactions_app/domain/entities/user_credentials.dart';
import 'package:transactions_app/domain/repo/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl(this.authMapper);
  final AuthMapper authMapper;
  FirebaseAuth auth = FirebaseAuth.instance;



  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Future<bool> loginWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth.instance.currentUser?.displayName;
    var result = false;
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) result = true;
      updateLastLogin();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return result;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
    }
  }

  @override
  Future<UserCredentials> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final userCredentials = authMapper.toUserCredentials(userCredential);

    return userCredentials;
  }

  @override
  Future<void> updateLastLogin() async {
    FirebaseAuth.instance.currentUser?.displayName;
    return users
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'lastLoginTimestamp': Timestamp.now()})
        .then((value) => print('User Updated'))
        .catchError((error) => print('Failed to update user: $error'));
  }
}
