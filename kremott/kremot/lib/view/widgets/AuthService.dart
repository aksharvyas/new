// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

/// Provide authentication services with [FirebaseAuth].
class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<void> phoneAuth({
    required String phoneNumber,
    required Future<String?> Function() smsCode,
  }) async {
    try {
      final confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);

      final _smsCode = await smsCode.call();

      if (_smsCode != null) {
        await confirmationResult.confirm(_smsCode);
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) {
    try {
      return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign the Firebase user out.
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
