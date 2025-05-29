import 'package:firebase_with_riverpod/core/shared_modules/navigation/utils/context_x.dart';
import 'package:firebase_with_riverpod/core/shared_presentation/widgets/mini_widgets.dart';
import 'package:firebase_with_riverpod/core/utils/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_config/firebase/firebase_constants.dart';
import '../../../core/shared_modules/localization/code_base_for_both_options/key_value_x_for_text_w.dart';
import '../../../core/shared_modules/localization/code_base_for_both_options/text_widget.dart';
import '../../../core/shared_modules/localization/generated/locale_keys.g.dart';
import '../../../core/shared_modules/localization/language_toggle_widget/_toggle_button.dart';
import '../../../core/shared_presentation/constants/_app_constants.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/navigation/routes_names.dart';
import '../../../core/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../core/shared_presentation/widgets/custom_app_bar.dart';
import '../../auth/presentation/sign_out/sign_out_buttons.dart';
import 'profile_provider.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final profileAsync = ref.watch(profileProvider(uid));

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.profile_title,
        actionWidgets: [
          const LanguageToggleButton(),
          _RefreshButton(uid: uid),
          const SignOutIconButton(),
        ],
      ),
      body: profileAsync.when(
        data: (user) => _UserProfile(user),
        error:
            (e, _) => const MiniWidgets(
              MWType.error,
              // error: handleException(e),
              isForDialog: false,
            ),
        loading: () => const MiniWidgets(MWType.loading),
        skipLoadingOnRefresh: false,
      ),
    );
  }

  //
}
