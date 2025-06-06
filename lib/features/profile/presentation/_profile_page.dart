import 'package:firebase_with_riverpod/core/shared_modules/errors_handling/utils/consumable.dart';
import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/widgets/mini_widgets.dart';
import 'package:firebase_with_riverpod/core/shared_layers/shared_presentation/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../core/shared_modules/localization/code_base_for_both_options/key_value_x_for_text_w.dart';
import '../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../core/shared_modules/localization/language_toggle_widget/language_toggle_button.dart';
import '../../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../../core/shared_layers/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/navigation/routes_names.dart';
import '../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../core/shared_layers/shared_presentation/widgets/custom_app_bar.dart';
import '../../../core/shared_modules/theme/provider_and_toggle_widget/theme_toggle_widget.dart';
import '../../auth/presentation/sign_out/sign_out_buttons.dart';
import 'profile_notifier.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final asyncUser = ref.watch(profileNotifierProvider(uid));

    showDialogWhenError(context: context, ref: ref, uid: uid);

    ///
    return Scaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.profile_title,
        actionWidgets: [
          LanguageToggleButton(),
          ThemeToggleIcon(),
          SignOutIconButton(),
        ],
      ),

      ///
      body: asyncUser.when(
        data: (user) => _UserProfile(user),
        loading: () => const MiniWidgets(MWType.loading),
        error: (_, _) => const SizedBox(), // error shown by overlay
      ),
    );
  }

  /// ✅ [showDialogWhenError] listens to failure in [profileNotifierProvider]
  /// ✅ Triggers contextual `showError` only once per failure
  void showDialogWhenError({
    required BuildContext context,
    required WidgetRef ref,
    required String uid,
  }) {
    // ref.listenManual(profileNotifierProvider(uid), (_, _) {
    //   final failure =
    //       ref.read(profileNotifierProvider(uid).notifier).consumeFailure();
    //   if (failure != null) {
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //       context.showError(failure);
    //     });
    //   }
    // });
    ref.listenManual(profileNotifierProvider(uid), (_, _) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.consume(
          ref.read(profileNotifierProvider(uid).notifier).consumeFailure(),
        );
      });
    });
  }

  //
}
