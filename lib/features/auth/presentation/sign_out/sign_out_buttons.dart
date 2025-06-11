import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/for_riverpod/extensions/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/features/auth/presentation/sign_out/sign_out_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';

/// 🔘 [SignOutButton] — triggers logout via [signOutProvider]
/// 🧼 Declarative error handling with overlay via `.listen()`
//----------------------------------------------------------
class SignOutButton extends ConsumerWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ❗️ Listens (declarative) error state
    ref.listen<AsyncValue<void>>(
      signOutProvider,
      (prev, next) => context.showDialogWhenErrorState(next),
    );

    return CustomButton(
      type: ButtonType.text,
      onPressed: () => ref.read(signOutProvider.notifier).signOut(),
      label: LocaleKeys.buttons_sign_out,
      fontWeight: FontWeight.w600,
      fontSize: 15,
      isEnabled: true,
      isLoading: false,
    );
  }
}

/// ❌ [VerifyEmailCancelButton] — signs out from verification screen
/// 🧼 Listens for errors via [signOutProvider]
//-------------------------------------------------
class VerifyEmailCancelButton extends ConsumerWidget {
  const VerifyEmailCancelButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ❗️ Listens (declarative) error state
    ref.listen<AsyncValue<void>>(
      signOutProvider,
      (prev, next) => context.showDialogWhenErrorState(next),
    );

    return CustomButton(
      type: ButtonType.filled,
      onPressed: () => ref.read(signOutProvider.notifier).signOut(),
      label: LocaleKeys.buttons_cancel,
      isEnabled: true,
      isLoading: false,
    );
  }
}

/// 🔓 [SignOutIconButton] — used in AppBar to logout
/// 🧼 Shows errors using overlay on failure
//-------------------------------------------
class SignOutIconButton extends ConsumerWidget {
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ❗️ Listens (declarative) error state
    ref.listen<AsyncValue<void>>(
      signOutProvider,
      (prev, next) => context.showDialogWhenErrorState(next),
    );

    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () => ref.read(signOutProvider.notifier).signOut(),
    );
  }
}
