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
import '../widgets/buttons.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/text_widget.dart';

/// **Verify Email Page**
/// - Sends a verification email to the user.
/// - Periodically checks if the email has been verified.
/// - Redirects to home once verification is complete.

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

  // =========== BUILD METHOD =========== //

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

  // =========== EMAIL VERIFICATION METHODS =========== //

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

  // =========== DISPOSE METHOD =========== //

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
}

// =========== STATIC WIDGETS =========== //

/// **Verification Info Section**
/// - Displays email verification instructions.
class _VerifyEmailInfo extends StatelessWidget {
  const _VerifyEmailInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextWidget(
          'Verification email has been sent to',
          TextType.bodyMedium,
        ),
        TextWidget(
          fbAuth.currentUser?.email ?? 'Unknown',
          TextType.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget(
          'If you cannot find verification email,',
          TextType.bodyMedium,
        ),
        RichText(
          text: TextSpan(
            text: 'Please check ',
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
            children: const [
              TextSpan(
                text: 'SPAM',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' folder.'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget('Ensure your email is correct.', TextType.bodyMedium),
      ],
    );
  }
}

/// **Cancel Button**
/// - Allows users to cancel email verification and log out.
class _VerifyEmailCancelButton extends ConsumerWidget {
  final Timer? timer; // ✅ Таймер може бути null

  const _VerifyEmailCancelButton({required this.timer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: () async {
        try {
          await ref.read(authRepositoryProvider).signout();
          timer?.cancel(); // ✅ Безпечне скасування таймера
        } on CustomError catch (e) {
          if (!context.mounted) return;
          ErrorHandling.showErrorDialog(context, e);
        }
      },
      child: const TextWidget('CANCEL', TextType.button),
    );
  }
}
