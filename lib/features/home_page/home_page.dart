import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/entities/custom_error.dart';
import '../../presentation/widgets/buttons.dart';
import '../../presentation/widgets/custom_app_bar.dart';
import '../../presentation/widgets/text_widget.dart';
import '../../core/app_navigation/route_names.dart';
import '../../data/repositories/auth/auth_repository_provider.dart';
import '../../data/sources/remote/consts/firebase_constants.dart';
import '../../core/utils_and_services/dialog_managing/error_dialog.dart';
import '../../core/utils_and_services/helpers.dart';
import 'home_provider.dart';

/// **Home Page**
/// - Displays user profile information.
/// - Allows users to refresh their profile data.
/// - Provides a sign-out option and a link to change the password.

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // =========== Build method =========== //

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = fbAuth.currentUser!.uid;
    final profileState = ref.watch(profileProvider(uid));

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        actionIcons: const [Icons.logout, Icons.refresh],
        actionCallbacks: [
          () => _signOutUser(context, ref),
          () => ref.invalidate(profileProvider),
        ],
      ),

      ///
      body: profileState.when(
        skipLoadingOnRefresh: false,
        data: (appUser) => _UserProfile(appUser: appUser),
        error: (e, _) => _ErrorWidget(error: e as CustomError),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

// =========== PROFILE WIDGET =========== //

/// **User Profile Section**
/// - Displays user details such as name, email, and ID.
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
            onPressed: () => Helpers.goTo(context, RouteNames.changePassword),
            child: const TextWidget('Change Password', TextType.button),
          ),
        ],
      ),
    );
  }
}

// =========== ERROR WIDGET =========== //

/// **Error Display**
/// - Displays error details if the profile loading fails.
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

// =========== USED METHODS =========== //

Future<void> _signOutUser(BuildContext context, WidgetRef ref) async {
  try {
    await ref.read(authRepositoryProvider).signout();
  } on CustomError catch (e) {
    if (!context.mounted) return;
    ErrorHandling.showErrorDialog(context, e);
  }
}
