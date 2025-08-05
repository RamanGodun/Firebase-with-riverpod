import 'dart:async';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/core_of_module/utils/errors_observing/loggers/failure_logger_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/base_modules/errors_handling/core_of_module/failure_entity.dart';
import '../../../../core/base_modules/errors_handling/core_of_module/failure_type.dart';
import '../../../../core/utils_shared/timing_control/timing_config.dart';
import '../../../../core/utils_shared/riverpod_specific/safe_async_state.dart';
import '../../../../app_bootstrap_and_config/firebase_config/firebase_constants.dart';
import '../../domain/email_verification_use_case.dart';
import '../../domain/providers/use_case_provider.dart';

part 'email_verification_provider.g.dart';

/// 🧩 [emailVerificationNotifierProvider] — async notifier that handles email verification polling
/// 🧼 Sends verification email and checks if email is verified via Firebase
//
@riverpod
final class EmailVerificationNotifier extends _$EmailVerificationNotifier
    with SafeAsyncState<void> {
  ///-------------------------------------------------------------

  Timer? _timer;
  static const _maxPollingDuration = AppDurations.min1;
  final Stopwatch _stopwatch = Stopwatch();
  late final EmailVerificationUseCase _emailVerificationUseCase;

  /// 🧱 Initializes verification logic
  @override
  FutureOr<void> build() {
    _emailVerificationUseCase = ref.read(emailVerificationUseCaseProvider);
    initSafe();
    debugPrint('VerificationNotifier: build() called...');

    unawaited(_emailVerificationUseCase.sendVerificationEmail());
    _startPolling();

    ref.onDispose(() => _timer?.cancel());
  }

  /// 🔁 Periodic email check every 5 seconds
  void _startPolling() {
    //
    _stopwatch.start();
    _timer = Timer.periodic(AppDurations.sec3, (_) {
      if (_stopwatch.elapsed > _maxPollingDuration) {
        _timer?.cancel();
        debugPrint('Polling timed out after 1 minute');

        final timeoutFailure = const Failure(
          type: EmailVerificationTimeoutFailureType(),
          message: 'Polling timed out after 1 minute',
        );
        timeoutFailure.log(StackTrace.current);

        state = AsyncError(timeoutFailure, StackTrace.current);

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
    final result = await _emailVerificationUseCase.checkIfEmailVerified();
    result.fold((_) => null, (isVerified) async {
      if (isVerified) {
        _timer?.cancel();

        await _emailVerificationUseCase.reloadUser();

        final refreshed = FirebaseConstants.fbAuth.currentUser;
        debugPrint(
          '🔁 After reload: emailVerified=${refreshed?.emailVerified}',
        );

        state = const AsyncData(null);
      }
    });
  }

  //
}
