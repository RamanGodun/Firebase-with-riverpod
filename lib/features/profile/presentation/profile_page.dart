import 'package:firebase_with_riverpod/core/shared_presentation/widgets/mini_widgets.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_riverpod/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/config/bootstrap/firebase/firebase_constants.dart';
import '../../../core/shared_presentation/constants/app_constants.dart';
import '../../../core/shared_modules/localization/app_strings.dart';
import '../../../core/shared_domain/entities/app_user.dart';
import '../../../core/shared_modules/navigation/routes_names.dart';
import '../../../core/shared_modules/errors_handling/custom_error.dart';
import '../../../core/shared_presentation/widgets/buttons/custom_buttons.dart';
import '../../../core/shared_presentation/widgets/custom_app_bar.dart';
import '../../../core/shared_presentation/widgets/text_widget.dart';
import '../../auth/_domain_data/auth_repository_providers.dart';
import '../domain_and_data/profile_repository.dart';
import 'profile_provider.dart';

part 'profile_widget.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = fbAuth.currentUser?.uid;
    if (uid == null) return const SizedBox();
    final profileAsync = ref.watch(
      profileProvider(uid).select((value) => value),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.profilePageTitle,
        actionIcons: const [Icons.refresh, Icons.logout],
        actionCallbacks: [
          () => ref.invalidate(profileProvider(uid)),
          () => _signOutUser(context, ref),
        ],
      ),
      body: profileAsync.when(
        data: (user) => _UserProfileWidget(user),
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

  /// 🔁 Triggers sign out via [authRepositoryProvider]
  Future<void> _signOutUser(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authRepositoryProvider).signout();
      ref.read(profileRepositoryProvider).clearCache();
    } on CustomError {
      if (!context.mounted) return;
      // context.showErrorDialog(handleException(e));
    }
  }
}
