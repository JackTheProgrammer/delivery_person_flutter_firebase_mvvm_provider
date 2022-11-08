import 'package:flutter/material.dart';

import '/services/firebase_auth_service.dart';
import '/services/local_storage_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  final LocalStorageServices _localAuthStatusService = LocalStorageServices();

  void signIn(String userEmail, String userPassword) async {
    await _firebaseAuthService.signInUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    _localAuthStatusService.authenticateUser();
    notifyListeners();
  }

  void signUp(String userEmail, String userPassword) async {
    await _firebaseAuthService.createUserWithEmailAndPassword(
      userEmail,
      userPassword,
    );
    _localAuthStatusService.authenticateUser();
    notifyListeners();
  }

  void signOut() async {
    await _firebaseAuthService.logOut();
    _localAuthStatusService.unAuthenticateUser();
    notifyListeners();
  }
}
