import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import 'sign_out_provider.dart';

/// 🔘 [SignOutButton] — triggers logout via [signOutProvider]
/// 🧼 Declarative error handling with overlay via `.listen()`
//
final class SignOutTextButton extends ConsumerWidget {
  ///--------------------------------------
  const SignOutTextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // ❗️ Shows (declarative) error state
    ref.listenFailure(signOutProvider, context);

    return AppTextButton(
      onPressed: () => ref.read(signOutProvider.notifier).signOut(),
      label: LocaleKeys.buttons_sign_out,
    );
  }
}

////

////

/// 🔓 [SignOutIconButton] — used in AppBar to logout
/// 🧼 Shows errors using overlay on failure
//
final class SignOutIconButton extends ConsumerWidget {
  ///----------------------------------
  const SignOutIconButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // ❗️ Shows (declarative) error state
    ref.listenFailure(signOutProvider, context);

    return IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () => ref.read(signOutProvider.notifier).signOut(),
    );
  }
}
