import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared_modules/errors_handling/custom_error.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../profile/domain_and_data/profile_repo_provider.dart';
import 'sign_out_provider.dart';

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.text,
      onPressed: () async {
        await ref.read(signOutProvider.notifier).signOut();
      },
      label: LocaleKeys.buttons_sign_in,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      isEnabled: true,
      isLoading: false,
    );
  }
}

/// ❌ [_VerifyEmailCancelButton] — sign out action
class VerifyEmailCancelButton extends ConsumerWidget {
  const VerifyEmailCancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.filled,
      onPressed: () => _handleCancel(ref, context),
      label: LocaleKeys.buttons_cancel,
      isEnabled: true,
      isLoading: false,
    );
  }

  void _handleCancel(WidgetRef ref, BuildContext context) async {
    try {
      await ref.read(signOutProvider.notifier).signOut();
    } on CustomError {
      if (!context.mounted) return;
      // context.showErrorDialog(handleException(e));
    }
  }

  ///
}

/// 🔓 [SignOutIconButton] — signs out the user and clears cached profile
class SignOutIconButton extends ConsumerWidget {
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () async {
        await ref.read(signOutProvider.notifier).signOut();
        ref.read(profileRepoProvider).clearCache();
      },
    );
  }
}
