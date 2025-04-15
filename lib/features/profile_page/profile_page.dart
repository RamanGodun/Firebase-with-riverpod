import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../core/entities/app_user.dart';
import '../../core/entities/custom_error.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/extensions/context_extensions.dart';
import '../../core/utils_and_services/extensions/others.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/custom_buttons.dart';
import '../../presentation/widgets/text_widget.dart';
import 'profile_provider.dart';

part 'widgets_for_profile_page.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = useMemoized(() => fbAuth.currentUser?.uid);
    if (uid == null) return const SizedBox();

    final profileAsync = ref.watch(profileProvider(uid));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile page',
        actionIcons: const [Icons.refresh, Icons.logout],
        actionCallbacks: [
          () => ref.invalidate(profileProvider(uid)),
          () => _signOutUser(context, ref),
        ],
      ),
      body: profileAsync.when(
        data: (user) => _UserProfile(user),
        error: (e, _) => _ErrorMessage(error: e as CustomError),
        loading: () => const _LoadingIndicator(),
        skipLoadingOnRefresh: false,
      ),
    );
  }

  Future<void> _signOutUser(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authRepositoryProvider).signout();
    } on CustomError catch (e) {
      if (!context.mounted) return;
      ErrorHandling.showErrorDialog(context, e);
    }
  }
}
