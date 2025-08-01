import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/theme/widgets_and_utils/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/shared_presentation_layer/shared_widgets/loader.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app_bootstrap_and_config/firebase_config/firebase_constants.dart';
import '../../../core/shared_presentation_layer/shared_widgets/buttons/text_button.dart';
import '../../../core/base_modules/localization/module_widgets/text_widget.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../core/base_modules/theme/ui_constants/app_colors.dart';
import '../../auth/presentation/sign_out/sign_out_provider.dart';
import 'provider/email_verification_provider.dart';

part 'widgets_for_email_verification_page.dart';

/// 🧼 [VerifyEmailPage] — screen that handles email verification polling
/// Automatically redirects when email gets verified
//
final class VerifyEmailPage extends ConsumerWidget {
  ///--------------------------------------------
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final asyncValue = ref.watch(emailVerificationNotifierProvider);

    /// ⛑️ Error listener
    ref.listenRetryAwareFailure(
      emailVerificationNotifierProvider,
      context,
      ref: ref,
      onRetry: () => ref.invalidate(emailVerificationNotifierProvider),
    );

    // 🎯 Trigger the polling logic
    ref.read(emailVerificationNotifierProvider);

    return Scaffold(
      body: Center(
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              const _VerifyEmailInfo(),
              //
              (asyncValue.isLoading)
                  ? const AppLoader()
                  : const VerifyEmailCancelButton(),
            ],
          ).withPaddingSymmetric(h: AppSpacing.xl, v: AppSpacing.xxl),
        ),
      ),
    );
  }
}
