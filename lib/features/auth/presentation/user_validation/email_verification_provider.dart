import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data_providers/email_verification_repo_provider.dart';
import '../../domain/auth_use_cases.dart';

part 'email_verification_provider.g.dart';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification
/// 🧼 Sends verification email and polls every 5s to check if user verified email
//----------------------------------------------------------------//

@riverpod
class EmailVerificationNotifier extends _$EmailVerificationNotifier {
  Timer? _timer;
  late final EmailVerificationUseCase _useCase;
  bool _isMounted = true;

  /// 🧱 Initializes verification flow
  @override
  Future<void> build() async {
    _useCase = EmailVerificationUseCase(
      ref.read(emailVerificationRepoProvider),
    );

    await _useCase.sendVerificationEmail();
    _startPolling();

    ref.onDispose(() {
      _timer?.cancel();
      _isMounted = false;
    });
  }

  /// 🔁 Periodic check every 5s
  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) => checkVerified());
  }

  /// ✅ Public method for manual verification check
  Future<void> checkVerified() async {
    final isVerified = await _useCase.checkIfEmailVerified();
    if (!_isMounted) return;

    if (isVerified) {
      _timer?.cancel();
      state = const AsyncData(null);
    }
  }

  ///
}
