import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/features/auth/presentation/user_validation/email_verification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show useEffect;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../../../core/shared_modules/theme/core/app_colors.dart';
import '../sign_out/sign_out_buttons.dart';

/// 🧼 [VerifyEmailPage] — screen that handles email verification polling
/// Automatically redirects when email gets verified
class VerifyEmailPage extends HookConsumerWidget {
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 🚀 Starts the polling logic by reading the notifier
    useEffect(() {
      ref.read(emailVerificationNotifierProvider);
      return null;
    }, []);

    /// 🔁 Listens to email verification status and handles redirect or error
    ref.listen(emailVerificationNotifierProvider, (prev, next) {
      next.whenOrNull(
        data: (_) => context.goTo(RoutesNames.home),
        // error: (e, _) => context.showErrorDialog(handleException(e)),
      );
    });

    return const Scaffold(body: _VerifyEmailBody());
  }
}

/// 📦 [_VerifyEmailBody] — main UI container with info & cancel
class _VerifyEmailBody extends StatelessWidget {
  const _VerifyEmailBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(context.isDarkMode ? 0.05 : 0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [_VerifyEmailInfo(), VerifyEmailCancelButton()],
        ).withPaddingAll(AppSpacing.l),
      ),
    );
  }
}

/// ------------------------- Local stateless widgets ------------------------/

/// ℹ️ [_VerifyEmailInfo] — shows instructions about checking inbox / spam
class _VerifyEmailInfo extends StatelessWidget {
  const _VerifyEmailInfo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextWidget(
          LocaleKeys.pages_verify_email,
          TextType.titleMedium,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: AppSpacing.m),
        const TextWidget(LocaleKeys.verify_email_sent, TextType.bodyMedium),
        const SizedBox(height: AppSpacing.xs),
        TextWidget(
          fbAuth.currentUser?.email ?? LocaleKeys.verify_email_unknown,
          TextType.titleSmall,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: AppSpacing.m),
        const TextWidget(LocaleKeys.verify_email_not_found, TextType.bodySmall),
        const SizedBox(height: AppSpacing.xs),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: LocaleKeys.verify_email_check_prefix.tr(),
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              color: context.colorScheme.onSurface,
            ),
            children: [
              TextSpan(
                text: LocaleKeys.verify_email_spam.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(text: LocaleKeys.verify_email_check_suffix.tr()),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.s),
        const TextWidget(
          LocaleKeys.verify_email_or,
          TextType.error,
          color: AppColors.errorColor,
        ),
        const SizedBox(height: AppSpacing.xs),
        const TextWidget(
          LocaleKeys.verify_email_ensure_correct,
          TextType.bodySmall,
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}
