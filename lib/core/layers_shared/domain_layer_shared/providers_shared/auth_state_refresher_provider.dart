import 'dart:async' show StreamSubscription;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../foundation/navigation/utils/refresh_adapter.dart';
import 'auth_state_provider.dart';

part 'auth_state_refresher_provider.g.dart';

/// 🪝 [authStateRefreshStream] — Riverpod Provider exposing [AuthStateRefresher]
/// Internally binds to [authStateStreamProvider.stream]
/// ✅ Used by `refreshListenable` in GoRouter

@riverpod
Raw<AuthStateRefresher> authStateRefreshStream(Ref ref) {
  final stream = ref.watch(authStateStreamProvider.stream);
  final refresher = AuthStateRefresher()..bind(stream);
  ref.onDispose(refresher.dispose);
  return refresher;
}

////

////

/// 🔁 [AuthStateRefresher] — Notifies GoRouter when auth stream emits events
/// ✅ Calls `notifyListeners()` on stream change
/// ✅ Works with any `Stream<User?>` or similar

final class AuthStateRefresher extends ChangeNotifier
    implements GoRouterRefreshAdapter {
  ///-----------------------------------------------

  StreamSubscription? _subscription;

  @override
  void bind(Stream stream) {
    _subscription?.cancel();
    // _subscription = stream.listen((_) => notifyListeners());
    _subscription = stream.listen((_) {
      debugPrint(
        'AuthStateRefresher: stream emitted new auth event, calling notifyListeners()',
      ); // 🪵
      notifyListeners();
    });
  }

  // void trigger() => notifyListeners();
  void trigger() {
    debugPrint('AuthStateRefresher: notifyListeners triggered manually'); // 🪵
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //
}
