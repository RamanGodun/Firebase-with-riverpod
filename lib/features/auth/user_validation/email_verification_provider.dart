import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/config/firebase/firebase_constants.dart';
import '../_domain_data/auth_repository_providers.dart';

part 'email_verification_provider.g.dart';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification
/// 🧼 Sends verification email and polls every 5s to check if user verified email
//----------------------------------------------------------------//

@riverpod
class EmailVerificationNotifier extends _$EmailVerificationNotifier {
  Timer? _timer;

  /// 🧱 Initializes verification flow
  /// - Sends verification email
  /// - Starts polling every 5s
  /// - Cleans up timer on dispose
  @override
  Future<void> build() async {
    _sendVerification();
    _startPolling();
    ref.onDispose(() => _timer?.cancel());
  }

  /// 📩 Sends email verification request via [AuthRepository]
  void _sendVerification() {
    unawaited(ref.read(authRepositoryProvider).sendEmailVerification());
  }

  /// 🔁 Starts timer to poll [AuthRepository.reloadUser] every 5s
  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkVerified(),
    );
  }

  /// ✅ Checks verification status
  /// If verified — cancels timer and updates state
  Future<void> _checkVerified() async {
    await ref.read(authRepositoryProvider).reloadUser();
    final isVerified = fbAuth.currentUser?.emailVerified ?? false;

    if (isVerified) {
      _timer?.cancel();
      state = const AsyncData(null);
    }
  }
}
