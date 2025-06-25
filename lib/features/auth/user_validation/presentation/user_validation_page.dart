import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/modules_shared/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:firebase_with_riverpod/core/modules_shared/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/features/auth/user_validation/presentation/user_validation_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/text_button.dart';
import '../../../../core/modules_shared/localization/widgets/text_widget.dart';
import '../../../../core/modules_shared/localization/generated/locale_keys.g.dart';
import '../../../../core/modules_shared/navigation/app_routes/app_routes.dart';
import '../../../../core/modules_shared/theme/ui_constants/_app_constants.dart';
import '../../../../core/modules_shared/theme/ui_constants/app_colors.dart';
import '../../sign_out/presentation/sign_out_provider.dart';

part 'widgets_for_verify_email_page.dart';

/// 🧼 [VerifyEmailPage] — screen that handles email verification polling
/// Automatically redirects when email gets verified

class VerifyEmailPage extends ConsumerWidget {
  ///--------------------------------------------
  const VerifyEmailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ⛑️ Error listener
    // ref.listenFailure(emailVerificationNotifierProvider, context);
    ref.listenFailureWithAction<void>(
      emailVerificationNotifierProvider,
      context,
      onConfirmed: () async {
        await fbAuth.signOut();
        if (context.mounted) context.goNamed(RoutesNames.signIn);
      },
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
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [_VerifyEmailInfo(), VerifyEmailCancelButton()],
          ).withPaddingAll(AppSpacing.l),
        ),
      ).withPaddingHorizontal(AppSpacing.xm),
    );
  }
}
