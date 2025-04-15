import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';

part 'email_verification_provider.g.dart';

@riverpod
class EmailVerificationNotifier extends _$EmailVerificationNotifier {
  Timer? _timer;

  @override
  Future<void> build() async {
    _sendVerification();
    _startPolling();
    ref.onDispose(() => _timer?.cancel());
  }

  void _sendVerification() async {
    await ref.read(authRepositoryProvider).sendEmailVerification();
  }

  void _startPolling() {
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkVerified(),
    );
  }

  Future<void> _checkVerified() async {
    await ref.read(authRepositoryProvider).reloadUser();
    if (fbAuth.currentUser?.emailVerified ?? false) {
      _timer?.cancel();
      state = const AsyncData(null);
    }
  }
}
