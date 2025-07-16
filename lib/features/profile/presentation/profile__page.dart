import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/shared_presentation_layer/widgets_shared/loaders/loader.dart';
import 'package:firebase_with_riverpod/core/base_modules/theme/extensions/theme_x.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/base_modules/localization/widgets/key_value_text_widget.dart';
import '../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/localization/widgets/language_toggle_button.dart';
import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_toggle_widgets/theme_picker.dart';
import '../../../core/base_modules/theme/widgets_and_utils/box_decorations/_box_decorations_factory.dart';
import '../../auth/presentation/sign_out/sign_out_buttons.dart';
import '../domain/entities/_user_entity.dart';
import '../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../core/shared_presentation_layer/widgets_shared/app_bar.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_toggle_widgets/theme_toggler.dart';
import 'profile_provider.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — Displays user details, handles logout, navigation to password change, and provides theme/language toggling.
/// Uses [profileProvider] for user data and listens for error overlays.

class ProfilePage extends ConsumerWidget {
  ///----------------------------------
  const ProfilePage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    /// Get current user UID (null if not signed in)
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final asyncUser = ref.watch<AsyncValue<UserEntity>>(profileProvider(uid));

    // ❗️ Listen and display any async errors as overlays
    ref.listenFailure(profileProvider(uid), context);

    final isDark = context.isDarkMode;

    ///
    return Scaffold(
      appBar: const _ProfileAppBar(),

      /// User data loaded — render profile details
      body: asyncUser.when(
        data:
            (user) => Center(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xxm),
                padding: const EdgeInsets.all(AppSpacing.l),
                decoration: BoxDecorationFactory.iosCard(isDark),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Avatar, username
                    Row(
                      children: [
                        ClipOval(
                          child:
                              user.profileImage.isNotEmpty
                                  ? FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: user.profileImage,
                                    width: 96,
                                    height: 96,
                                    fit: BoxFit.cover,
                                  )
                                  : Container(
                                    width: 96,
                                    height: 96,
                                    color: context.colorScheme.surfaceVariant,
                                    child: const Icon(Icons.person, size: 48),
                                  ),
                        ),
                        const SizedBox(width: AppSpacing.m),
                        Expanded(
                          child: KeyValueTextWidget(
                            labelKey: LocaleKeys.profile_welcome,
                            value: user.name,
                            labelTextType: TextType.headlineSmall,
                            valueTextType: TextType.headlineSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.m),

                    /// Email and ID
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_email,
                      value: user.email,
                      labelTextType: TextType.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxxs),
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_id,
                      value: user.id,
                      labelTextType: TextType.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    /// Theme switcher and change password button
                    const _ThemeSection(),
                    const SizedBox(height: AppSpacing.xl),
                    const _ChangePasswordButton(),
                  ],
                ),
              ),
            ).withPaddingBottom(AppSpacing.massive),

        /// Show loader while data is loading
        loading: () => const AppLoader(),

        /// Show nothing, as overlay handles errors
        error: (_, _) => const SizedBox(),

        //
      ),
    );
  }
}
