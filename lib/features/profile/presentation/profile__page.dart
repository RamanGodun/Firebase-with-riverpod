import 'package:firebase_with_riverpod/core/general_utils/widget_ref_extensions/show_dialog_when_error_x.dart';
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
import '../../../core/shared_modules/theme/core/constants/_app_constants.dart';
import '../domain/entities/app_user.dart';
import '../../../core/shared_modules/navigation/routes_names.dart';
import '../../../core/shared_layers/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../core/shared_layers/shared_presentation/widgets/custom_app_bar.dart';
import '../../../core/shared_modules/theme/widget_for_theme_toggling.dart';
import '../../auth/sign_out/presentation/sign_out_buttons.dart';
import 'profile_provider.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});
  //---------------------------

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final asyncUser = ref.watch(profileProvider(uid));

    // ❗️ Declarative error listener
    ref.listenFailure(profileProvider(uid), context);

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

  //
}
