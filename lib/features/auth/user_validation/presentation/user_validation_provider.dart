import 'dart:async';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/layers_shared/domain_layer_shared/providers_shared/auth_state_refresher_provider.dart';
import '../../../../core/modules_shared/errors_handling/failures/failure_entity.dart';
import '../../../../core/modules_shared/errors_handling/utils/for_riverpod/safe_async_state.dart';
import '../domain/user_validation_use_case_provider.dart';

part 'user_validation_provider.g.dart';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification polling
/// 🧼 Sends verification email and checks if email is verified via Firebase

@riverpod
class EmailVerificationNotifier extends _$EmailVerificationNotifier
    with SafeAsyncState<void> {
  //----------------------------------------------------------------

  Timer? _timer;
  static const _maxPollingDuration = Duration(minutes: 2);
  final Stopwatch _stopwatch = Stopwatch();

  late final EmailVerificationUseCase _useCase;

  /// 🧱 Initializes verification logic
  @override
  FutureOr<void> build() {
    _useCase = ref.read(emailVerificationUseCaseProvider);
    initSafe();
    debugPrint('VerificationNotifier: build() called...');

    unawaited(_useCase.sendVerificationEmail());
    _startPolling();

    ref.onDispose(() => _timer?.cancel());
  }

  /// 🔁 Periodic email check every 5 seconds
  void _startPolling() {
    //
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_stopwatch.elapsed > _maxPollingDuration) {
        _timer?.cancel();
        debugPrint('Polling timed out after 2 minutes');

        state = AsyncError(
          EmailVerificationFailure.timeoutExceeded(),
          StackTrace.current,
        );

        return;
      }
      _checkEmailVerified();
    });
    //
  }

  /// ✅ Checks if email is verified and cancels timer
  Future<void> _checkEmailVerified() async {
    debugPrint(
      'EmailVerificationNotifier: checking email verification status...',
    );
    final result = await _useCase.checkIfEmailVerified();
    result.fold((_) => null, (isVerified) async {
      if (isVerified) {
        _timer?.cancel();

        await _useCase.reloadUser();

        final refreshed = fbAuth.currentUser;
        debugPrint(
          '🔁 After reload: emailVerified=${refreshed?.emailVerified}',
        );

        ref.read(authStateRefreshStreamProvider).trigger();

        state = const AsyncData(null);
      }
    });
  }

  //
}
