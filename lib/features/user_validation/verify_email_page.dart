import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/router/routes_names.dart';
import '../../core/constants/app_constants.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/entities/custom_error.dart';
import '../../presentation/widgets/old_buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/text_widget.dart';

part 'widgets_for_email_validation_page.dart';

class VerifyEmailPage extends ConsumerStatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerifyEmailPageState();
}

class _VerifyEmailPageState extends ConsumerState<VerifyEmailPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _sendEmailVerification();
    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _checkEmailVerified(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Email Verification'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _VerifyEmailInfo(),
              const SizedBox(height: AppSpacing.m),
              _VerifyEmailCancelButton(timer: _timer),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------- EMAIL VERIFICATION METHODS ----------------- //

  Future<void> _sendEmailVerification() async {
    try {
      await ref.read(authRepositoryProvider).sendEmailVerification();
    } on CustomError catch (e) {
      if (!mounted) return;
      ErrorHandling.showErrorDialog(context, e);
    }
  }

  Future<void> _checkEmailVerified() async {
    final goRouter = GoRouter.of(context);

    try {
      await ref.read(authRepositoryProvider).reloadUser();
      if (fbAuth.currentUser?.emailVerified ?? false) {
        _timer?.cancel();
        _timer = null;
        goRouter.goNamed(RoutesNames.home);
      }
    } on CustomError catch (e) {
      if (!mounted) return;
      ErrorHandling.showErrorDialog(context, e);
    }
  }

  // ----------------- DISPOSE METHOD ----------------- //

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}
