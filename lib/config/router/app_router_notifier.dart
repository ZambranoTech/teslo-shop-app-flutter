import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _auhNotifier;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._auhNotifier){
    _auhNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus( AuthStatus value ) {
    _authStatus = value;
    notifyListeners();
  }
  
}