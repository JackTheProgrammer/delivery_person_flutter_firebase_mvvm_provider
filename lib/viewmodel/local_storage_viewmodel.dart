import 'package:flutter/material.dart';

import '../services/local_storage_service.dart';

class LocalStorageViewModel extends ChangeNotifier {
  final LocalStorageServices _localStorageServices = LocalStorageServices();

  Future<bool?> getUserAuthenticationStatus() async {
    return await LocalStorageServices.isAuthenticatedUser();
  }

  void authenticateDeliverer() {
    _localStorageServices.authenticateUser();
    notifyListeners();
  }
}
