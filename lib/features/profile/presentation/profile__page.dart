import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/foundation/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/foundation/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/layers_shared/presentation_layer_shared/widgets_shared/loaders/loader.dart';
import 'package:firebase_with_riverpod/core/foundation/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/app_configs/firebase/firebase_constants.dart';
import '../../../core/foundation/localization/widgets/key_value_text_widget.dart';
import '../../../core/foundation/localization/widgets/text_widget.dart';
import '../../../core/foundation/localization/generated/locale_keys.g.dart';
import '../../../core/foundation/localization/widgets/language_toggle_button.dart';
import '../../../core/foundation/navigation/app_routes/app_routes.dart';
import '../../../core/foundation/theme/ui_constants/_app_constants.dart';
import '../../../core/foundation/theme/widgets_and_utils/theme_toggle_widgets/theme_picker.dart';
import '../../../core/foundation/theme/widgets_and_utils/blur_wrapper.dart';
import '../../../core/foundation/theme/widgets_and_utils/box_decorations/_box_decorations_factory.dart';
import '../domain/entities/_user_entity.dart';
import '../../../core/layers_shared/presentation_layer_shared/widgets_shared/buttons/filled_button.dart';
import '../../../core/layers_shared/presentation_layer_shared/widgets_shared/app_bar.dart';
import '../../../core/foundation/theme/widgets_and_utils/theme_toggle_widgets/theme_toggler.dart';
import '../../auth/sign_out/presentation/sign_out_buttons.dart';
import 'profile_provider.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out

class ProfilePage extends ConsumerWidget {
  ///------------------------------------
  const ProfilePage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();

    final asyncUser = ref.watch<AsyncValue<UserEntity>>(profileProvider(uid));

    // ❗️ Declarative error listener
    ref.listenFailure(profileProvider(uid), context);

    ///
    return Scaffold(
      appBar: const CustomAppBar(
        title: LocaleKeys.profile_title,
        actionWidgets: [LanguageToggleButton(), SignOutIconButton()],
      ),

      ///
      body: asyncUser.when(
        data: (user) => _UserProfile(user),
        loading: () => const AppLoader(),
        error: (_, _) => const SizedBox(), // error shown by overlay
      ),
    );
  }

  //
}
