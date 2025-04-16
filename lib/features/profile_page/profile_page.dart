import 'package:firebase_with_riverpod/presentation/widgets/mini_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/entities/app_user.dart';
import '../../core/entities/custom_error.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/errors_managing/handle_exception.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../core/utils_and_services/extensions/others.dart';
import '../../data/repositories/auth/auth_repository_providers.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/buttons/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import 'profile_provider.dart';

/// 👤 [ProfilePage] — displays user info, handles logout and refresh actions
/// 🧼 Uses [profileProvider] to fetch data and [authRepositoryProvider] to sign out
class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = useMemoized(() => fbAuth.currentUser?.uid);
    if (uid == null) return const SizedBox();
    final profileAsync = ref.watch(profileProvider(uid));

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
        data: (user) => _UserProfile(user),
        error:
            (e, _) => MiniWidgets(
              MWType.error,
              error: handleException(e),
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
    } on CustomError catch (e) {
      if (!context.mounted) return;
      ErrorHandling.showErrorDialog(context, e);
    }
  }
}

/// 📦 [_UserProfile] — displays user data and password change button
/// 🧼 Rendered after successful response from [profileProvider]
class _UserProfile extends StatelessWidget {
  final AppUser user;

  const _UserProfile(this.user);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: TextWidget(
              '${AppStrings.welcome} ${user.name}',
              TextType.headlineSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const TextWidget(AppStrings.profilePageTitle, TextType.titleMedium),
          const SizedBox(height: AppSpacing.s),
          TextWidget(
            '${AppStrings.profileEmailLabel} ${user.email}',
            TextType.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.s),
          TextWidget(
            '${AppStrings.profileIdLabel} ${user.id}',
            TextType.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.huge),
          CustomButton(
            type: ButtonType.filled,
            onPressed: () => context.goTo(RoutesNames.changePassword),
            label: AppStrings.changePassword,
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    ).withPaddingHorizontal(AppSpacing.l);
  }
}
