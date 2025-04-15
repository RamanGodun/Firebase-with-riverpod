import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/entities/custom_error.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../core/router/routes_names.dart';
import '../../presentation/widgets/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import 'email_verification_provider.dart';

class VerifyEmailPage extends HookConsumerWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      ref.read(emailVerificationNotifierProvider.notifier);
      return null;
    }, []);

    ref.listen(emailVerificationNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (_) => context.goTo(RoutesNames.home),
        error:
            (e, _) => ErrorHandling.showErrorDialog(context, e as CustomError),
      );
    });

    return const Scaffold(body: _VerifyEmailBody());
  }
}

class _VerifyEmailBody extends StatelessWidget {
  const _VerifyEmailBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(context.isDarkMode ? 0.05 : 0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(AppSpacing.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                'Email Verification',
                TextType.headlineMedium,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: AppSpacing.m),
              _VerifyEmailInfo(),
              SizedBox(height: AppSpacing.xxxl),
              _VerifyEmailCancelButton(),
            ],
          ),
        ),
      ),
    );
  }
}

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
        const SizedBox(height: AppSpacing.xs),
        TextWidget(
          fbAuth.currentUser?.email ?? 'Unknown',
          TextType.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: AppSpacing.m),
        const TextWidget('If you cannot find the email,', TextType.bodySmall),
        const SizedBox(height: AppSpacing.xs),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Please check ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            children: const [
              TextSpan(
                text: 'SPAM',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: ' folder.'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget('OR', TextType.error, color: AppConstants.errorColor),
        const SizedBox(height: AppSpacing.xs),
        const TextWidget('Ensure your email is correct.', TextType.bodySmall),
      ],
    );
  }
}

class _VerifyEmailCancelButton extends ConsumerWidget {
  const _VerifyEmailCancelButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: () async {
        try {
          await ref.read(authRepositoryProvider).signout();
        } on CustomError catch (e) {
          if (!context.mounted) return;
          ErrorHandling.showErrorDialog(context, e);
        }
      },
      label: 'Cancel',
      isEnabled: true,
      isLoading: false,
    );
  }
}
