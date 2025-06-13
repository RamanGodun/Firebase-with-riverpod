import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/core/utils/widget_ref_extensions/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/features/auth/presentation/user_validation/email_verification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_modules/navigation/routes_names.dart';
import '../../../../core/shared_modules/theme/core/constants/_app_constants.dart';
import '../../../../core/shared_modules/theme/core/app_colors.dart';
import '../sign_out/sign_out_buttons.dart';

part 'widgets_for_verify_email_page.dart';

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

    /// 🪝 Error listener — declarative failure handling
    ref.listenFailure(emailVerificationNotifierProvider, context);

    /// 🪝 Success listener — redirect after success
    ref.listen(emailVerificationNotifierProvider, (prev, next) {
      if (next is AsyncData) context.goTo(RoutesNames.home);
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
