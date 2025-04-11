import 'package:firebase_with_riverpod/core/utils_and_services/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/entities/custom_error.dart';
import '../../core/router/routes_names.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/firebase_constants.dart';
import '../../presentation/widgets/buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/text_widget.dart';
import 'profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  /// ----------------- BUILD METHOD --------------------- //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.watch(profileProvider(uid));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile page',
        actionIcons: const [Icons.refresh, Icons.logout],
        actionCallbacks: [
          () => ref.invalidate(profileProvider),
          () => _signOutUser(context, ref),
        ],
      ),

      ///
      body: profileState.when(
        skipLoadingOnRefresh: false,
        data: (appUser) => _UserProfile(appUser: appUser),
        error: (e, _) => _ErrorWidget(error: e as CustomError),
        loading:
            () => const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}

// ----------------- USED METHODS ----------------- //

Future<void> _signOutUser(BuildContext context, WidgetRef ref) async {
  try {
    await ref.read(authRepositoryProvider).signout();
  } on CustomError catch (e) {
    if (!context.mounted) return;
    ErrorHandling.showErrorDialog(context, e);
  }
}

// ----------------- PROFILE WIDGET ----------------- //

class _UserProfile extends StatelessWidget {
  final dynamic appUser;

  const _UserProfile({required this.appUser});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget('Welcome ${appUser.name}', TextType.headlineSmall),
          const SizedBox(height: 20.0),
          const TextWidget('Your Profile', TextType.titleMedium),
          const SizedBox(height: 10.0),
          TextWidget('Email: ${appUser.email}', TextType.bodyMedium),
          const SizedBox(height: 10.0),
          TextWidget('ID: ${appUser.id}', TextType.bodyMedium),
          const SizedBox(height: 40),
          CustomButton(
            type: ButtonType.filled,
            onPressed: () => context.goTo(RoutesNames.changePassword),
            label: 'Change Password',
            isEnabled: true,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}

// ----------------- ERROR WIDGET ----------------- //

class _ErrorWidget extends StatelessWidget {
  final CustomError error;

  const _ErrorWidget({required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        'code: ${error.code}\nplugin: ${error.plugin}\nmessage: ${error.message}',
        TextType.error,
        alignment: TextAlign.center,
      ),
    );
  }
}
