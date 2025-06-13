import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/shared_modules/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain/user_validation_use_case_provider.dart';

part 'user_validation_provider.g.dart';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification polling
/// 🧼 Sends verification email and checks if email is verified via Firebase
//----------------------------------------------------------------//
@riverpod
class EmailVerificationNotifier extends _$EmailVerificationNotifier
    with SafeAsyncState<void> {
  Timer? _timer;
  late final EmailVerificationUseCase _useCase;

  /// 🧱 Initializes verification logic
  @override
  FutureOr<void> build() {
    _useCase = ref.read(emailVerificationUseCaseProvider);
    initSafe();

    unawaited(_useCase.sendVerificationEmail());
    _startPolling();

    ref.onDispose(() => _timer?.cancel());
  }

  /// 🔁 Periodic email check every 5 seconds
  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkEmailVerified(),
    );
  }

  /// ✅ Checks if email is verified and cancels timer
  Future<void> _checkEmailVerified() async {
    final result = await _useCase.checkIfEmailVerified();
    result.fold((_) => null, (isVerified) {
      if (isVerified) {
        _timer?.cancel();

        state = const AsyncData(null);
      }
    });
  }

  //
}
