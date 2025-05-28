import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/email_verification_repo.dart';
import '../../domain/email_verification_use_case.dart';

part 'email_verification_provider.g.dart';

/// 📬 [emailVerificationNotifierProvider] — handles sending verification email & polling
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
    final repo = ref.read(emailVerificationRepoProvider);
    final useCase = EmailVerificationUseCase(repo);

    useCase.sendVerificationEmail();
    _startPolling(useCase);
    ref.onDispose(() => _timer?.cancel());
  }

  /// 📩 Sends email verification request via [AuthRepository]
  /// 🔁 Starts timer to poll [AuthRepository.reloadUser] every 5s
  /// ✅ Checks verification status
  /// If verified — cancels timer and updates state
  void _startPolling(EmailVerificationUseCase useCase) {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final isVerified = await useCase.checkIfEmailVerified();
      if (isVerified) {
        _timer?.cancel();
        state = const AsyncData(null);
      }
    });
  }
}
