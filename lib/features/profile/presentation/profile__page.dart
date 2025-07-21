import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_riverpod/core/base_modules/errors_handling/utils/for_riverpod/show_dialog_when_error_x.dart';
import 'package:firebase_with_riverpod/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_riverpod/core/shared_presentation_layer/widgets_shared/loaders/loader.dart';
import 'package:firebase_with_riverpod/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app_bootstrap_and_config/app_config/firebase/firebase_constants.dart';
import '../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../core/base_modules/localization/widgets/key_value_text_widget.dart';
import '../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../core/base_modules/localization/widgets/language_toggle_button.dart';
import '../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../core/base_modules/theme/widgets_and_utils/blur_wrapper.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_toggle_widgets/theme_picker.dart';
import '../../../core/utils_shared/spider/app_images.dart';
import '../../auth/presentation/sign_out/sign_out_buttons.dart';
import '../domain/entities/_user_entity.dart';
import '../../../core/shared_presentation_layer/widgets_shared/buttons/filled_button.dart';
import '../../../core/shared_presentation_layer/widgets_shared/app_bar.dart';
import '../../../core/base_modules/theme/widgets_and_utils/theme_toggle_widgets/theme_toggler.dart';
import 'provider/profile_provider.dart';

part 'profile_page_widgets.dart';

/// 👤 [ProfilePage] — Displays user details, handles logout, navigation to password change, and provides theme/language toggling.
/// Uses [profileProvider] for user data and listens for error overlays.
//
final class ProfilePage extends ConsumerWidget {
  ///----------------------------------
  const ProfilePage({super.key});
  //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    /// Get current user UID (null if not signed in)
    final uid = FirebaseConstants.fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final asyncUser = ref.watch<AsyncValue<UserEntity>>(profileProvider(uid));

    // ❗️ Listen and display any async errors as overlays
    ref.listenFailure(profileProvider(uid), context);

    ///
    return Scaffold(
      appBar: const _ProfileAppBar(),

      /// User data loaded — render profile details
      body: asyncUser.when(
        data: (user) => _UserProfileCard(user: user),

        /// Show loader while data is loading
        loading: () => const AppLoader(),

        /// Show nothing, as overlay handles errors
        error: (_, _) => const SizedBox(),

        //
      ),
    );
  }
}

////

////

/// 🧾 [_UserProfileCard] — Displays user information after successful fetch.
//
final class _UserProfileCard extends StatelessWidget {
  ///-----------------------------------------------

  final UserEntity user;
  const _UserProfileCard({required this.user});
  //

  @override
  Widget build(BuildContext context) {
    //
    return Center(
      child: BlurContainer(
        child: Card(
          margin: const EdgeInsets.all(AppSpacing.xxm),
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInImage.assetNetwork(
                placeholder: AppImagesPaths.loading,
                image: user.profileImage,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 👤 Name
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_name,
                      value: user.name,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.titleMedium,
                    ),

                    /// 🆔 ID
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_id,
                      value: user.id,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.bodySmall,
                    ),

                    /// 📧 Email
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_email,
                      value: user.email,
                      labelTextType: TextType.bodyMedium,
                      valueTextType: TextType.titleSmall,
                    ),

                    /// 📊 Points
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_points,
                      value: user.point.toString(),
                      labelTextType: TextType.bodyMedium,
                    ),

                    /// 🏆 Rank
                    KeyValueTextWidget(
                      labelKey: LocaleKeys.profile_rank,
                      value: user.rank,
                      labelTextType: TextType.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.l),

                    ///
                    const _ThemeSection(),
                    const SizedBox(height: AppSpacing.xl),

                    const _ChangePasswordButton(),
                    //
                  ],
                ),
              ),
            ],
          ),
        ),
      ).withPaddingOnly(bottom: AppSpacing.huge),
    );
  }
}
