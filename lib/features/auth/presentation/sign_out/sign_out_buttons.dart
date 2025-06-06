import 'package:firebase_with_riverpod/core/shared_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../../core/utils/for_riverpod_providers/auth_actions.dart';

class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButton(
      type: ButtonType.text,
      onPressed:
          () => AuthActions.signOut(ref: ref, onError: context.showError),
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
      onPressed:
          () => AuthActions.signOut(ref: ref, onError: context.showError),
      label: LocaleKeys.buttons_cancel,
      isEnabled: true,
      isLoading: false,
    );
  }
}

/// 🔓 [SignOutIconButton] — signs out the user and clears cached profile
class SignOutIconButton extends ConsumerWidget {
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed:
          () => AuthActions.signOut(ref: ref, onError: context.showError),
    );
  }
}
